function testSignalPCA()

    load('grandResults.mat');
    ix = find(isnan(grandMetrics));
    grandMetrics(ix) = 0;

    
    [genoMetrics, genoIX] = stratifyByGenotype(grandMetrics, grandIX);
    classIX = uniqueTypes(grandIX);
    genoList = unique(genoIX(:,3));
    powerList = unique(genoIX(:,1)); 
    
    Zm = zscore(genoMetrics,0,1);
    Z = zscore(grandMetrics,0,1);
    
    genoCorr = corr(Zm);
    
    [sigCorr, noiseCorr] = signalCorrelation(Z, classIX, 20);
    
    ffsubplot(2,2,1);
    image(genoCorr,'CDataMapping','scaled');
    set(gca,'XTick',[],'YTick',[]); colorbar;
    title('Corr matrix by genotype');
    
    ffsubplot(2,2,2);
    image(sigCorr,'CDataMapping','scaled');
        set(gca,'XTick',[],'YTick',[]); colorbar;
    title('Signal correlation');
    
    ffsubplot(2,2,3);
    image(noiseCorr,'CDataMapping','scaled');
        set(gca,'XTick',[],'YTick',[]); colorbar;
    title('Noise correlation');
    
    ffsubplot(2,2,4);
    [Vg,Dg] = eig(genoCorr);
    plot(real(cumsum(diag(Dg))./sum(diag(Dg))),'g.-'); hold on;
    [Vs,Ds] = eig(sigCorr);
    plot(real(cumsum(diag(Ds))./sum(diag(Ds))),'b.-');
    [Vn,Dn] = eig(noiseCorr);
    plot(real(cumsum(diag(Dn))./sum(diag(Dn))),'r.-');
    
    figure();
    h = biplot(Vg(:,1:2),'varlabels',metricLabels);
    title('Genotype PC1-PC2');
    for n = 1:length(h)
        if isprop(h(n),'FontSize')
            set(h(n),'FontSize',6);
        end
    end
    
        figure();
    h = biplot(Vs(:,1:2),'varlabels',metricLabels);
    title('Signal PC1-PC2');
    for n = 1:length(h)
        if isprop(h(n),'FontSize')
            set(h(n),'FontSize',6);
        end
    end
    
        figure();
    h = biplot(Vn(:,1:2),'varlabels',metricLabels);
    title('Noise PC1-PC2');
    for n = 1:length(h)
        if isprop(h(n),'FontSize')
            set(h(n),'FontSize',6);
        end
    end
    
    % Get avg. decPI for each genotype
    for genoNn=1:length(genoList)
        genoN = genoList(genoNn);
    
        ix = find(genoIX(:,3) == genoN);
        meanPI(genoNn) = mean(genoMetrics(ix,2));
    end
    [B, decPIorder] = sort(meanPI,'descend');
    
    
    scores = grandMetrics*Vs;
       
    genoList = unique(grandIX(:,3));
    powerList = unique(grandIX(:,1));
    
    figure;
    ffsubplot(1,1,1);
    for genoNn = 1:length(genoList)
        genoN = decPIorder(genoNn);
        for powerNn = 1:length(powerList)
            powerN = powerList(powerNn);
            
            ix = find((grandIX(:,3) == genoN) & (grandIX(:,1) == powerN));
            meanVal1(powerN) = nanmean(scores(ix,1));
            meanVal2(powerN) = nanmean(scores(ix,2));           
        end       
        
        plot(meanVal1,meanVal2,'.-','Color',extractColor(jet,genoNn,[length(genoList) 1])); hold on;
    end
    title('PC1 & PC2 by Genotype');
    
    figure;
        for powerNn = 1:length(powerList)
        powerN = powerList(powerNn);
        for genoNn = 1:length(genoList)
            genoN = decPIorder(genoNn);

            ix = find((grandIX(:,3) == genoN) & (grandIX(:,1) == powerN));
            meanVal1(genoNn) = nanmean(scores(ix,1));
            meanVal2(genoNn) = nanmean(scores(ix,2));    
        end             
        scatter(meanVal1,meanVal2,'.','MarkerEdgeColor',pretty(9 - powerN)); hold on;
    end
    title('PC1 & PC2 by Power');
    
    
    
    
    
    
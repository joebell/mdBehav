function pcaByFly(grandMetrics, grandIX, metricLabels)

    ix = find(isnan(grandMetrics));
    grandMetrics(ix) = 0;
 
    genoList = unique(grandIX(:,3));
    powerList = unique(grandIX(:,1));
    Z = zscore(grandMetrics,0,1);
    
    % Get avg. decPI for each genotype
    for genoNn=1:length(genoList)
        genoN = genoList(genoNn);
    
        ix = find(grandIX(:,3) == genoN);
        meanPI(genoNn) = mean(grandMetrics(ix,2));
    end
    [B, decPIorder] = sort(meanPI,'descend');
    
    
    [coeff, scores, latent] = princomp(Z);
    figure();
    ffsubplot(2,3,1);
    plot(cumsum(latent)./sum(latent),'.-'); xlabel('PC #'); ylabel('Variance explained');
    

    
    ffsubplot(2,3,2);
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
    
    ffsubplot(2,3,3);
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
    
    ffsubplot(2,3,4:6);
    h = biplot(coeff(:,1:2),'varlabels',metricLabels);
    for n = 1:length(h)
        if isprop(h(n),'FontSize')
            set(h(n),'FontSize',6);
        end
    end
            
    
    
    
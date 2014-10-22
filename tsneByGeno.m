function tsneByGeno(grandMetrics, grandIX, metricLabels)

    [genoMetrics, genoIX] = stratifyByGenotype(grandMetrics, grandIX);
    genoList = unique(genoIX(:,3));
    powerList = unique(genoIX(:,1));
    Z = zscore(genoMetrics,0,1);

    % Get avg. decPI for each genotype
    for genoNn=1:length(genoList)
        genoN = genoList(genoNn);
    
        ix = find(genoIX(:,3) == genoN);
        meanPI(genoNn) = mean(genoMetrics(ix,2));
    end
    [B, decPIorder] = sort(meanPI,'descend');
    
    
    scores = fast_tsne(Z,20,30,.2);
    figure();
    
 
    ffsubplot(1,2,1);
    for genoNn = 1:length(genoList)
        genoN = decPIorder(genoNn);
        for powerNn = 1:length(powerList)
            powerN = powerList(powerNn);
            
            ix = find((genoIX(:,3) == genoN) & (genoIX(:,1) == powerN));
            meanVal1(powerN) = nanmean(scores(ix,1));
            meanVal2(powerN) = nanmean(scores(ix,2));
            
        end       
        plot(meanVal1,meanVal2,'.-','Color',extractColor(jet,genoNn,[length(genoList) 1])); hold on;
    end
    title('tSNE by Genotype');
    
    ffsubplot(1,2,2);
    for powerNn = 1:length(powerList)
        powerN = powerList(powerNn);
        
        ix = find(genoIX(:,1) == powerN);
        scatter(scores(ix,1),scores(ix,2),'.','MarkerEdgeColor',pretty(9-powerN)); hold on;
        
    end
    title('tSNE by Power');

            
    
    
    
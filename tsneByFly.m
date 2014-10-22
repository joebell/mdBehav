function tsneByFly(grandMetrics, grandIX, metricLabels)

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
    
    
    scores = fast_tsne(Z,20,100,.2,true);
        
    ffsubplot(2,2,1);
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
    title('tSNE Means by Genotype');
    
    ffsubplot(2,2,2);
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
    title('tSNE Means by Power');
    
    ffsubplot(2,2,3);
    for genoNn = 1:length(genoList)
        genoN = decPIorder(genoNn);
        for powerNn = 1:length(powerList)
            powerN = powerList(powerNn);
            
            ix = find((grandIX(:,3) == genoN) & (grandIX(:,1) == powerN));
            scatter(scores(ix,1),scores(ix,2),'.','MarkerEdgeColor',extractColor(jet,genoNn,[length(genoList) 1])); hold on;
        end                      
    end
    title('tSNE by Genotype');
    
    ffsubplot(2,2,4);
    for powerNn = 1:length(powerList)
        powerN = powerList(powerNn);
        for genoNn = 1:length(genoList)
            genoN = decPIorder(genoNn);

            ix = find((grandIX(:,3) == genoN) & (grandIX(:,1) == powerN));
            scatter(scores(ix,1),scores(ix,2),'.','MarkerEdgeColor',pretty(9 - powerN)); hold on;    
        end             
        
    end
    title('tSNE by Power');
    

    
    
    
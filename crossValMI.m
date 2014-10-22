function MI = crossValMI(metric1, metric2, grandIX, nBins, nSplits)

    genoList = unique(grandIX(:,3));
    powerList = unique(grandIX(:,1));

    MIs = [];
    
    % For the metric, how much of the entropy in the metric cross-validates
    % to other flies of the same power and genotype
    for splitN = 1:nSplits
        
        list1 = [];
        list2 = [];
        for genoNn = 1:length(genoList)
            genoN = genoList(genoNn);
            
            ix = find(grandIX(:,3) == genoN);
            flyList = unique(grandIX(ix,2));
            randOrder = randperm(length(flyList));
            flys1 = flyList(randOrder(1:(length(flyList)/2)));
            flys2 = flyList(randOrder((length(flyList)/2 + 1):end));
            
            for powerNn = 1:length(powerList)
                powerN = powerList(powerNn);
               
                ix1 = find((grandIX(:,1) == powerN) &...
                           (grandIX(:,3) == genoN) &...
                           (ismember(grandIX(:,2),flys1)));
                       
                ix2 = find((grandIX(:,1) == powerN) &...
                           (grandIX(:,3) == genoN) &...
                           (ismember(grandIX(:,2),flys2)));
                      
                list1 = cat(1,list1, metric1(ix1));
                list2 = cat(1,list2, metric2(ix2));
                list1 = cat(1,list1, metric1(ix2));
                list2 = cat(1,list2, metric2(ix1));
                        
            end            
        end
               
        MIs(end+1) = mutualInfo(list1,list2, nBins);
        
    end
            
    MI = mean(MIs);
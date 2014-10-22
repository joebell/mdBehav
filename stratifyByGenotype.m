function [genoMetrics, genoIX] = stratifyByGenotype(grandMetrics, grandIX)

    genoList = unique(grandIX(:,3));
    powerList = unique(grandIX(:,1));
    
    genoMetrics = [];
    genoIX = [];

    for genoNn = 1:length(genoList)
        genoN = genoList(genoNn);
        for powerNn = 1:length(powerList)
            powerN = powerList(powerNn);
            
            ix = find((grandIX(:,1) == powerN) & (grandIX(:,3) == genoN));
            genoMetrics = cat(1,genoMetrics,nanmean(grandMetrics(ix,:),1));
            genoIX = cat(1,genoIX,[powerN,NaN,genoN]);
            
        end
    end
function gpArray = pullGenoPower(metricData, IX, metricN)

    powerList = unique(IX(:,1));
    genoList = unique(IX(:,3));
    
    for powerNn = 1:length(powerList)
        powerN = powerList(powerNn);
        
        for genoNn = 1:length(genoList)
            for genoN = genoList(genoNn);
                
                ix = find((IX(:,1) == powerN) & (IX(:,3) == genoN));
                gpArray(genoNn,powerNn) = mean(metricData(ix,metricN));
                
            end
        end
    end
                

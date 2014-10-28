function classIX = uniqueTypes(grandIX)

    powerNs = grandIX(:,1);
    flyNs   = grandIX(:,2);
    genoNs  = grandIX(:,3);
    
    powerList = unique(powerNs);
    genoList  = unique(genoNs);
    
    for genoNn = 1:length(genoList)
        genoN = genoList(genoNn);
        for powerNn = 1:length(powerList)
            powerN = powerList(powerNn);
            
            ix = find((powerNs == powerN) & (genoNs == genoN));
            classIX(ix) = (genoNn - 1)*length(powerList) + powerNn;
        end
    end
    
    classIX = classIX(:);
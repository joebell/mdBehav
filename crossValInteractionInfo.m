function MI = crossValInteractionInfo( X, grandIX, nBins,  nSplits)

    Xshuff = zeros(size(X,1), nSplits);
    classIX = uniqueTypes(grandIX);
    powerN = grandIX(:,1);
    genoN = grandIX(:,3);
    
    MIs = [];

    uniqueClasses = unique(classIX);
    for classNn = 1:length(uniqueClasses)
        ix = find(classIX == uniqueClasses(classNn));       
        for splitN = 1:nSplits
            newOrderX = ix(randperm(length(ix)));
            Xshuff(newOrderX, splitN) = X(ix);
        end
    end
    
    for splitN = 1:nSplits
        
        CMIA = condContMutualInfo( X, Xshuff(:,splitN), classIX, nBins)   
        CMIP = condContMutualInfo( X, Xshuff(:,splitN), powerN, nBins)  
        CMIG = condContMutualInfo( X, Xshuff(:,splitN), genoN, nBins)
        
        MIs(splitN) = CMIA - CMIG - CMIP
        
    end
    
    MI = mean(MIs);
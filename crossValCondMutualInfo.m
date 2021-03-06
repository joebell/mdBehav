function MI = crossValCondMutualInfo( X, Y, grandIX, nBins,  nSplits)

    Xshuff = zeros(size(X,1), nSplits);
    Yshuff = zeros(size(Y,1), nSplits);
    classIX = uniqueTypes(grandIX);
    powerN = grandIX(:,1);
    genoN = grandIX(:,3);
    
    MIs = [];

    uniqueClasses = unique(classIX);
    for classNn = 1:length(uniqueClasses)
        ix = find(classIX == uniqueClasses(classNn));       
        for splitN = 1:nSplits
            newOrderX = ix(randperm(length(ix)));
            newOrderY = ix(randperm(length(ix)));
            Xshuff(newOrderX, splitN) = X(ix);
            Yshuff(newOrderY, splitN) = Y(ix);
        end
    end
    
    for splitN = 1:nSplits
        
        CMIG = condContMutualInfo( Xshuff(:,splitN), Yshuff(:,splitN), genoN, nBins);        
        MIs(splitN) = CMIG;
        
    end
    
    MI = mean(MIs);
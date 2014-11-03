function MI = crossValContMI(X,Y,nBins,classIX,nSplits)

    Xshuff = zeros(size(X,1),nSplits);
    Yshuff = zeros(size(Y,1),nSplits);
    
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
        % MIs(splitN) = contMutualInfo(Xshuff(:,splitN),Yshuff(:,splitN),nBins);
        k = 4;
        MIs(splitN) = kraskovMI(Xshuff(:,splitN), Yshuff(:,splitN), k);
    end
    
    MI = mean(MIs);

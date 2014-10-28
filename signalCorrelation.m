function [sigCorr, noiseCorr] = signalCorrelation( X, classIX, nSplits)

    nDim = size(X, 2);
    corrMatrices = zeros(nDim,nDim,nSplits);
    shuffMatrix = zeros(size(X,1),size(X,2),nSplits);
    uniqueClasses = unique(classIX);
    
    totalCorr = corr(X);
    
    % Make shuffles matrices
    for classNn = 1:length(uniqueClasses)
        ix = find(classIX == uniqueClasses(classNn));
        for splitN = 1:nSplits
            for dimN = 1:nDim
                newOrder = ix(randperm(length(ix)));
                shuffMatrix(newOrder, dimN, splitN) = X(ix,dimN);
            end
        end
    end
    
    % Calculate the correlation matrix of each shuffled matrix
    for splitN = 1:nSplits
        corrMatrices(:,:,splitN) = corr(X, squeeze(shuffMatrix(:,:,splitN)));
    end
    
    % Average the shuffled correlation matrices
    sigCorr = mean(corrMatrices,3);
    noiseCorr = totalCorr - sigCorr;
            
            
            
        
    


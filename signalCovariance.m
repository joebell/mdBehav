function [sigCov, noiseCov] = signalCovariance( X, classIX, nSplits)

    nDim = size(X, 2);
    corrMatrices = zeros(nDim,nDim,nSplits);
    shuffMatrix = zeros(size(X,1),size(X,2),nSplits);
    uniqueClasses = unique(classIX);
    
    totalCov = cov(X);
    
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
        for xn = 1:size(X,2)
            for yn = 1:size(shuffMatrix,2)
                out = cov(squeeze(X(:,xn)), squeeze(shuffMatrix(:,yn,splitN)));
                corrMatrices(xn,yn,splitN) = out(1,2);
            end
        end
    end
    
    % Average the shuffled correlation matrices
    sigCov = mean(corrMatrices,3);
    noiseCov = totalCov - sigCov;
            
            
            
        
    


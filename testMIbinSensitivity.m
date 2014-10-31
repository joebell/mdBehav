function testMIbinSensitivity()

%     nSamples = 10000;
%     noiseFract = .3;
%     latent = (1-noiseFract)*randn(nSamples,1);
%     X = noiseFract*randn(nSamples,1) + latent;
%     Y = noiseFract*randn(nSamples,1) + latent;

    load('grandResults.mat');
    ix = find(isnan(grandMetrics));
    grandMetrics(ix) = 0;
    classIX = uniqueTypes(grandIX);
    X = grandMetrics(:,1);
    Y = grandMetrics(:,2);
    
    uniqueClasses = unique(classIX);
    for classNn = 1:length(uniqueClasses)
        ix = find(classIX == uniqueClasses(classNn));
        newOrderX = ix(randperm(length(ix)));
        newOrderY = ix(randperm(length(ix)));
        Xshuff(newOrderX) = X(ix);
        Yshuff(newOrderY) = Y(ix);
    end
    X = Xshuff(:);
    Y = Yshuff(:);
    
    CM = corr([X,Y]);   
    ffsubplot(2,2,1);
    N = hist3([X,Y],[64 64]);
    image(N,'CDataMapping','scaled');
    set(gca,'YDir','normal','XTick',[],'YTick',[]);
    title(['Joint distribution, R = ',num2str(CM(1,2))]);
    
    ffsubplot(2,2,2);
    Pxy = N./sum(N(:));
    Px = sum(N,2)./sum(N(:));
    Py = sum(N,1)./sum(N(:));
    Imap = Pxy.*log2(Pxy./(Px*Py));
    image(Imap,'CDataMapping','scaled');
    set(gca,'YDir','normal','XTick',[],'YTick',[]);
    title('Mutual information (bits)');
    
    
    binList = 1:12;
    for binN = 1:length(binList)
        nBins = 2^binList(binN);
        
        MI(binN) = contMutualInfo(X, Y, nBins);
    end
    
    ffsubplot(2,2,3);
    plot(binList, MI,'b.-'); hold on;
    xlabel('log2 Nbins');
    ylabel('Estimated MI');
    title('Fixed histogram estimator');
    
    optX = (max(X) - min(X))/(2*iqr(X)*length(X)^(-1/3));
    optY = (max(Y) - min(Y))/(2*iqr(Y)*length(Y)^(-1/3));
    nBins = max(ceil([optX optY]));
    optMI = contMutualInfo(X, Y, nBins);
    plot(xlim(),[1 1]*optMI,'k--');
    plot([1 1]*log2(nBins),ylim(),'k--');
    
    
    pause(1);

    kList = [4,6,8,12,16,24,32,58,64,96,128,192,256];
    for Kn = 1:length(kList)
        k = kList(Kn)   
        kMI(Kn) = kraskovMI(X,Y,k)
    end
    
    ffsubplot(2,2,4);
    plot(log2(kList), kMI,'r.-');
    xlabel('log2 k nearest neighbors');
    ylabel('Estimated MI');
    title('Kraskov K-NN estimator');
    
    
    

    
    
    
    
    
      
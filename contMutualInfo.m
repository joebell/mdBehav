function I = contMutualInfo(X, Y, nBins)

        
    [N, ctrs] = hist3([X,Y],[nBins,nBins]);
	Pxy = N./sum(N(:));
    Px = sum(N,2)./sum(N(:));
    Py = sum(N,1)./sum(N(:));
    
    Ixy = Pxy.*log2(Pxy./(Px*Py));
    
    I = nansum(Ixy(:));
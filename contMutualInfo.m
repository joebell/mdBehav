function I = contMutualInfo(X, Y, nBins)

		minX = min(X);
		maxX = max(X);
		Xbins = [minX:((maxX - minX)/(nBins-1)):maxX];
        
        
		minY = min(Y);
		maxY = max(Y);
		Ybins = [minY:((maxY - minY)/(nBins-1)):maxY];
        
    N = hist3([X,Y],{Xbins,Ybins});
	Pxy = N./sum(N(:));
    Px = sum(N,2)./sum(N(:));
    Py = sum(N,1)./sum(N(:));
    
    Ixy = Pxy.*log2(Pxy./(Px*Py));
    
    I = nansum(Ixy(:));
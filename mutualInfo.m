function I = mutualInfo(X, Y, nBins)

	% I = shannonEntropy(X, nBins) - conditionalEntropy(X, Y, nBins, nBins);
    
    if length(unique(X)) <= nBins
		Xbins = unique(X);
	else
		minX = min(X);
		maxX = max(X);
		Xbins = [minX:((maxX - minX)/(nBins-1)):maxX];
    end
    
    Ybins = unique(Y);
    
    N = hist3([X,Y],{Xbins,Ybins});
	Pxy = N./sum(N(:));
    Px = sum(N,2)./sum(N(:));
    Py = sum(N,1)./sum(N(:));
    
    Ixy = Pxy.*log2(Pxy./(Px*Py));
    
    I = nansum(Ixy(:));

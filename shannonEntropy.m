function H = shannonEntropy(X, nBins)
    
    minX = min(X);
    maxX = max(X);
    Xbins = [minX:((maxX - minX)/(nBins-1)):maxX];

	N = hist(X, Xbins);
	Px = N./sum(N);

	H = -nansum(Px.*log2(Px));	

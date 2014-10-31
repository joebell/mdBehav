function H = shannonEntropy(X, nBins)
    
	N = hist(X, nBins);
	Px = N./sum(N);

	H = -nansum(Px.*log2(Px));	

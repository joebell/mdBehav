function H = findNBins(X,Y)

	binList = [4:64];
	for n = 1:length(binList)

		nBins = binList(n);
		H(n) = mutualInfo(X, Y, nBins);
		% H(n) = conditionalEntropy(X,Y,nBins,nBins);

	end

	plot(binList, H);

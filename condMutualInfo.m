function I = condMutualInfo(X, Y, Z, nBins)

	if length(unique(X)) <= nBins
		Xbins = unique(X);
	else
		minX = min(X);
		maxX = max(X);
		Xbins = [minX:((maxX - minX)/(nBins-1)):maxX];
	end

% 	if length(unique(Y)) <= nBins
% 		Ybins = unique(Y);
% 	else
% 		minY = min(Y);
% 		maxY = max(Y);
% 		Ybins = [minY:((maxY - minY)/(nBins-1)):maxY];
% 	end
    Ybins = unique(Y);
	Zbins = unique(Z);

	Zix = dsearchn(Zbins, Z);
	N = hist(Z,Zbins);
	Pz = N/sum(N);

	for Zn = 1:length(Zbins)

		ix = find(Zix == Zn);
		subX = X(ix);
		subY = Y(ix);

		N = hist3([subX,subY],{Xbins,Ybins});
		PxyOnZ = N./sum(N(:));
        PxOnZ = sum(N,2)./sum(N(:));
        PyOnZ = sum(N,1)./sum(N(:));

		IxyOnZ = PxyOnZ.*log2(PxyOnZ./(PxOnZ*PyOnZ));
        
		Ixy(Zn) = nansum(IxyOnZ(:));
         
    end

	I = nansum(Pz.*Ixy);



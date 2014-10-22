function MI = measureMI(grandMetrics, grandIX, nBins)

	powerN = grandIX(:,1);
	genoN = grandIX(:,3);
    genoList = unique(genoN);
    powerList = unique(powerN);

	for metricN = 1:size(grandMetrics,2)

		metricN
		metric = grandMetrics(:,metricN);
		MI(metricN) = mutualInfo(metric, genoN, nBins);

    end
function MI = measureMI(grandMetrics, grandIX, nBins)

    ix = find(isnan(grandMetrics));
    grandMetrics(ix) = 0;

	for metricN1 = 1:size(grandMetrics,2)
        metricN1
        for metricN2 = metricN1:size(grandMetrics,2)
            metricN2
            nBins = 1024; nSplits = 1;
            oneMI = crossValCondMutualInfo(grandMetrics(:,metricN1),...
                                           grandMetrics(:,metricN2),...
                                           grandIX, nBins,  nSplits)
            MI(metricN1,metricN2) = oneMI;
            MI(metricN2,metricN1) = oneMI;
            
        end
    end
function MI = measureMI(grandMetrics, grandIX, nBins)

    ix = find(isnan(grandMetrics));
    grandMetrics(ix) = 0;
    classIX = uniqueTypes(grandIX);

	for metricN1 = 1:size(grandMetrics,2)
        metricN1
        for metricN2 = metricN1:size(grandMetrics,2)
            metricN2
           
            nSplits = 1;
            oneMI = crossValContMI(grandMetrics(:,metricN1),grandMetrics(:,metricN2),nBins,classIX,nSplits);
            %oneMI = contMutualInfo(grandMetrics(:,metricN1), grandMetrics(:,metricN2), nBins);
            MI(metricN1,metricN2) = oneMI;
            MI(metricN2,metricN1) = oneMI;
            
        end
    end
function parMeasureMI(grandMetrics, grandIX, nBins, metricN1)

    ix = find(isnan(grandMetrics));
    grandMetrics(ix) = 0;
    classIX = uniqueTypes(grandIX);

	MI      = NaN*ones(size(grandMetrics,2),size(grandMetrics,2));
	MIshuff = NaN*ones(size(grandMetrics,2),size(grandMetrics,2));

        metricN1
        for metricN2 = metricN1:size(grandMetrics,2)
            metricN2
           
            nSplits = 5;
            oneMIshuff = crossValContMI(grandMetrics(:,metricN1),grandMetrics(:,metricN2),nBins,classIX,nSplits);
            % oneMI = contMutualInfo(grandMetrics(:,metricN1), grandMetrics(:,metricN2), nBins);
			k = 4;
			oneMI = kraskovMI(grandMetrics(:,metricN1), grandMetrics(:,metricN2), k);
			MIshuff(metricN1,metricN2) = oneMIshuff;
			MIshuff(metricN2,metricN1) = oneMIshuff;
            MI(metricN1,metricN2) = oneMI;
            MI(metricN2,metricN1) = oneMI;
            
        end

		save(['MI4-',num2str(metricN1,'%02d'),'.mat'],'metricN1','MI','MIshuff');

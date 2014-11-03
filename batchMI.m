function batchMI(grandMetrics, grandIX)

	for metricN1 = 1:size(grandMetrics,2)

		aRow = {grandMetrics, grandIX, 1, metricN1};
		allArgs{metricN1} = aRow;

	end

	batchSubmit(@parMeasureMI, allArgs);

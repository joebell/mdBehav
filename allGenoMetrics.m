function allGenoMetrics()

    grandMetrics = [];
    grandIX = [];

    genoList = [1:76];
   
	allArgs = {};	
    for genoNn = 1:length(genoList)
        genoN = genoList(genoNn);
        
		allArgs{genoNn} = {genoN}; 
    end

	batchSubmit(@calcAllMetrics,allArgs);

    

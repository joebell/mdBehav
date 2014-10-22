function allGenoMetrics()

    grandMetrics = [];
    grandIX = [];

    genoList = [1:78];
   
	allArgs = {};	
    for genoNn = 1:length(genoList)
        genoN = genoList(genoNn);
        
		allArgs{genoNn} = {genoN}; 
    end

	trackJob = batchSubmit(@totalTracks, allArgs);
	dependency = ['-w "done("',trackJob,'*")"'];
	batchSubmit(@calcAllMetrics,allArgs,dependency);

    

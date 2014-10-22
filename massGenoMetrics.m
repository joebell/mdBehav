function massGenoMetrics()

    genoList = [1:78];  
    grandMetrics = [];
    grandIX = [];
    
    summaryResults = {};
    
    for genoNn = 1:length(genoList)
        genoN = genoList(genoNn)
    
        load(['~/Desktop/Code/derived/geno',num2str(genoN,'%03d'),'.mat']);
        fileName = ['~/Desktop/Code/derived/allMetrics',num2str(genoN,'%03d'),'.mat'];
        a = dir(fileName);
        if size(a,1) > 0
            load(['~/Desktop/Code/derived/allMetrics',num2str(genoN,'%03d'),'.mat']);

            allMetricIX(:,3) = genoN;
            grandMetrics = cat(1,grandMetrics, allMetrics);
            grandIX = cat(1, grandIX, allMetricIX);

            summaryEntry{1} = genotypeString;

            nMetrics = size(allMetrics,2);
            for metricN = 1:nMetrics

                metricArray = [];
                for entryN = 1:size(allMetricIX,1)
                    powerN = allMetricIX(entryN,1);
                    flyN   = allMetricIX(entryN,2);

                    metricArray(flyN, powerN) = allMetrics(entryN,metricN);
                end
                summaryEntry{metricN + 1} = metricArray;
            end

            summaryResults{end+1} = summaryEntry;
        end
        save('~/Desktop/Code/mdBehav/grandResults.mat','grandMetrics','grandIX','summaryResults');
    end
    
    save('~/Desktop/Code/mdBehav/grandResults.mat','grandMetrics','grandIX','summaryResults','metricLabels');
        
        
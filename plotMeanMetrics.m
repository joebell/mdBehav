function plotMeanMetrics(meanMetrics, meanIX, plotColor)

    powerList = unique(meanIX(:,1));
    flyList = unique(meanIX(:,2));
    nFlies = length(flyList);
    
    for powerNn = 1:length(powerList)
        powerN = powerList(powerNn);
        
        ix = find(meanIX(:,1) == powerN);
        traceMean(powerNn) = nanmean(meanMetrics(ix));
        traceErr(powerNn) = nanstd(meanMetrics(ix))/sqrt(nFlies);
    end
    
%     for flyNn = 1:nFlies
%         flyN = flyList(flyNn);
%         
%         ix = find(meanIX(:,2) == flyN);
%         plot(meanMetrics(ix)); hold on;
%     end
    
    errorbar(traceMean,traceErr,'Color',plotColor);
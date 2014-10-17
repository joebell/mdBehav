%           1      2     3     4       5          6       7     8      9
% tAIX = [powerN, LR, presN, laneN, roomTemp, trialTime, repN, flyN, genoN
function [meanMetrics, meanIX] = stratifyByFly(metrics, metricIX, tAIX)

    flyList = unique(tAIX(:,8));
    powerList = unique(tAIX(:,1));
    
    meanMetrics = [];
    meanIX = [];
    for flyNn = 1:length(flyList)
        flyN = flyList(flyNn);
        for powerNn = 1:length(powerList)
            powerN = powerList(powerNn);
        
            ix = find((tAIX(metricIX,8) == flyN) & (tAIX(metricIX,1) == powerN));
            meanVal = nanmean(metrics(ix,:),1);
            
            meanMetrics = cat(1, meanMetrics,meanVal);
            meanIX      = cat(1, meanIX, [powerN flyN]);
            
        end
    end
    
    

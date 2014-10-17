%           1      2     3     4       5          6       7     8      9
% tAIX = [powerN, LR, presN, laneN, roomTemp, trialTime, repN, flyN, genoN
function stratifySpeeds(tA, tAIX)

    PI = calcPI(tA, tAIX);
    speeds = normSpeedOdorOut(tA, tAIX);
    
    for powerN = 1:8
        
        ix = find(tAIX(:,1) == powerN);
        
        % scatter(PI(ix),speeds(ix),9,pretty(powerN)); hold on;
        [N, x] = hist(speeds(ix),[0:.02:2]);
        plot(x,N,'Color',pretty(powerN)); hold on;
        
    end
    
    
function speeds = calcSpeed(tA, tAIX, timeWindow)

    samplePeriod = .05;
    nTraces = size(tAIX, 1);
    
    sampleWindow = timeWindow./samplePeriod;
    
    % headPosX = bodyX + headX;
    headPosX = squeeze(tA(:,sampleWindow(1):sampleWindow(2),1) +...
                       tA(:,sampleWindow(1):sampleWindow(2),3));
    headPosY = squeeze(tA(:,sampleWindow(1):sampleWindow(2),2) +...
                       tA(:,sampleWindow(1):sampleWindow(2),4));
                   
    posDiffs = sqrt(diff(headPosX,1,2).^2 + diff(headPosY,1,2).^2);
    speeds = squeeze(mean(posDiffs,2))./samplePeriod;
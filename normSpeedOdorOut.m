%           1      2     3     4       5          6       7     8      9
% tAIX = [powerN, LR, presN, laneN, roomTemp, trialTime, repN, flyN, genoN
function normSpeeds = normSpeedOdorOut(tA, tAIX)

    samplePeriod = .05;
    nTraces = size(tAIX, 1);
    preWindow  = [30 60]./samplePeriod;
    odorWindow = [60 90]./samplePeriod;
    
    % Calc pre-speeds
    % headPosX = bodyX + headX;
    headPosX = squeeze(tA(:,preWindow(1):preWindow(2),1) +...
                       tA(:,preWindow(1):preWindow(2),3));
    headPosY = squeeze(tA(:,preWindow(1):preWindow(2),2) +...
                       tA(:,preWindow(1):preWindow(2),4));                  
    posDiffs = sqrt([diff(headPosX,1,2)].^2 + [diff(headPosY,1,2)].^2);
    preSpeeds = squeeze(mean(posDiffs,2))./samplePeriod;
    
    % Calc odor speeds
    headPosX = squeeze(tA(:,odorWindow(1):odorWindow(2),1) +...
                       tA(:,odorWindow(1):odorWindow(2),3));
    headPosY = squeeze(tA(:,odorWindow(1):odorWindow(2),2) +...
                       tA(:,odorWindow(1):odorWindow(2),4));                  
    posDiffs = sqrt(diff(headPosX,1,2).^2 + diff(headPosY,1,2).^2); 
    posDiffs(:,end+1) = 0;
          
    
    for traceN = 1:nTraces   
        % Flip for LR if neccessary
        ix = find((-tAIX(traceN,2))*headPosX(traceN,:) < 0);
        odorSpeeds(traceN) = squeeze(mean(posDiffs(traceN,ix),2))./samplePeriod;
        nPoints(traceN) = length(ix);
    end

    normSpeeds = odorSpeeds(:) - preSpeeds(:);
    ix = find(nPoints == 0);
    normSpeeds(ix) = 0;
        
    
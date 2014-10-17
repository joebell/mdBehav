%%
%   Returns IX for trials only when fly is already in the laser zone
%   and already pointed upLaser or downLaser
%
function [gIX, stSamp] = gateFlashEncounterByDirection(tA, tAIX, timeStart, gatePosition, upLaser)
     
    samplePeriod = .05;
    sampleStart = timeStart./samplePeriod;
    nTraces = size(tAIX, 1);
    
    % headPosX = bodyX + headX;
    headPosX = squeeze(tA(:,sampleStart,1) +...
                       tA(:,sampleStart,3));
    
    % Flip so lasered side is positive
    headPosX = (-tAIX(:,2)).*headPosX;
    
    % Figure out which samples are upwind
    headAngle = fcnHeadAngle(tA, tAIX);
    if upLaser
        rightDirection = (cos(headAngle(:,sampleStart)) > cos(pi/4)); 
    else
        rightDirection = (-cos(headAngle(:,sampleStart)) > cos(pi/4));
    end
    
                   
    gIX = [];
    stSamp = [];
    for traceN = 1:size(tAIX,1)
        % If the fly is in the gatePosition zone at the start...
        % and it's headed in the right direction...
        % add the index to the list.
        if ((headPosX(traceN) >= gatePosition(1)) & ...
            (headPosX(traceN)  < gatePosition(2)) & ...
            (rightDirection(traceN)))   
        
            IX = traceN;
            samp = sampleStart;      
        else
            IX = [];
            samp = [];
        end
        
%         clf;
%         oneTrace =  (-tAIX(traceN,2))*(tA(traceN,:,1) + tA(traceN,:,3));
%         plot(oneTrace,'b.-'); hold on;
%         scatter(samp,oneTrace(samp),'go');
%         plot(xlim(),gatePosition(1).*[1 1],'k');
%         plot(xlim(),gatePosition(2).*[1 1],'k');
%         plot(sampleStart.*[1 1],ylim,'k');
%         pause;
%         disp('-');
        
        % Add to the list
        gIX = cat(1,gIX, IX);
        stSamp = cat(1,stSamp, samp);
        
    end
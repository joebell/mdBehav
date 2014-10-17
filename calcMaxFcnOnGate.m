function [perGateMeas, measIX] = calcMaxFcnOnGate(tA, tAIX, gIX, stSamp, enSamp, calcFcn)
    
    measQty = calcFcn( tA, tAIX);
    
    % For each gating event, take the avg. of measQty over the window
    for gateN = 1:length(gIX)
        IX = gIX(gateN);
        
        plotSign = -tAIX(IX,2); % plotSign = -LR
        perGateMeas(gateN,1) = max(measQty(IX, [stSamp(gateN):enSamp(gateN)]));
    end
    
    measIX = gIX;
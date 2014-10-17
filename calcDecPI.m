function [Nexits, NtowardLaser] = calcDecPI(tA, tAIX)

    samplePeriod = .05;
    nTraces = size(tAIX, 1);
    sampleWindow = [60 90]./samplePeriod;
    
    % headPosX = bodyX + headX;
    headPosXs = squeeze(tA(:,sampleWindow(1):sampleWindow(2),1) +...
                       tA(:,sampleWindow(1):sampleWindow(2),3));
                   
    for traceN = 1:nTraces               
                   
        headPosX = headPosXs(traceN,:);

        midIX = find(abs(headPosX) <= 5);
        leftIX = find(headPosX < -5);
        rightIX = find(headPosX > 5);
        
        posCat(midIX) = 0;
        posCat(leftIX) = -1;
        posCat(rightIX) = 1;
        
        thisSamp = posCat(1:(end-1));
        nextSamp = posCat(2:end);
        
        numL = length(find((thisSamp == 0)&(nextSamp == -1)));
        numR = length(find((thisSamp == 0)&(nextSamp ==  1)));
        
        Nexits(traceN) = numL + numR;
        if tAIX(traceN,2) == 1
            NtowardLaser(traceN) = numL;
        else
            NtowardLaser(traceN) = numR;
        end

    end
    

    
   
function out = fcnOccupancy(tA, tAIX)

    samplePeriod = .05;

    % headPosX = bodyX + headX;
    headPosX = squeeze(tA(:,:,1) +...
                       tA(:,:,3));
   
    % Flip traces in X if necessary               
    posSign = -tAIX(:,2);
    oneVec = ones(1,size(headPosX,2));
    signedPos = headPosX.*(posSign*oneVec);
    out = sign(signedPos);
%%
%      Calculates head angle. 0 is towards laser side.
%
function out = fcnHeadAngle( tA, tAIX)

    samplePeriod = .05;

    % headPosX = bodyX + headX;
    headRelX = squeeze(tA(:,:,3));
    headRelY = squeeze(tA(:,:,4));
    
    posSign = -tAIX(:,2);
    oneVec = ones(1,size(headRelX,2));
    signedRelX = headRelX.*(posSign*oneVec);
    
    out = atan2(headRelY,signedRelX);
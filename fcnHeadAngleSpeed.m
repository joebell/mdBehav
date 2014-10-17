%%
%      Calculates head angle. 0 is towards laser side.
%
function out = fcnHeadAngleSpeed( tA, tAIX) 

    samplePeriod = .05;
%    smoothSamples = 3;

    % headPosX = bodyX + headX;
    headRelX = squeeze(tA(:,:,3));
    headRelY = squeeze(tA(:,:,4));
    
%     % Smooth the head traces
%     for traceN = 1:size(headRelX,1)
%         headRelX(traceN,:) = smooth(headRelX(traceN,:),smoothSamples);
%         headRelY(traceN,:) = smooth(headRelY(traceN,:),smoothSamples);
%     end
    
    posSign = -tAIX(:,2);
    oneVec = ones(1,size(headRelX,2));
    signedRelX = headRelX.*(posSign*oneVec);
    
    headAngle = atan2(headRelY,signedRelX);
    unwrappedAngle = unwrap(headAngle,[],2);
    
    dHeadAngle = diff(unwrappedAngle,1,2)./samplePeriod; dHeadAngle(:,end+1) = 0;
    out = abs(dHeadAngle);
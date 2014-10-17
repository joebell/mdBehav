%%
% Calculates side speed
function out = fcnSideSpeed( tA, tAIX)

    samplePeriod = .05;

    % headPosX = bodyX + headX;
    bodyX = squeeze(tA(:,:,1));
    bodyY = squeeze(tA(:,:,2));
                     
    % Flip traces in X if necessary               
    posSign = -tAIX(:,2);
    oneVec = ones(1,size(bodyX,2));
    headPosX = bodyX.*(posSign*oneVec);
    
    dX = diff(bodyX,1,2)./samplePeriod; dX(:,end+1) = 0;
    dY = diff(bodyX,1,2)./samplePeriod; dY(:,end+1) = 0;
    headAngle = fcnHeadAngle( tA, tAIX);
    
    out = abs(dX.*cos(headAngle + pi/2) + dY.*sin(headAngle + pi/2));
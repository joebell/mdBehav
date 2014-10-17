%%
%
%   Head velocity in X
%
function out = fcnXVel( tA, tAIX)

    samplePeriod = .05;

    % headPosX = bodyX + headX;
    headPosX = squeeze(tA(:,:,1) +...
                       tA(:,:,3));
    headPosY = squeeze(tA(:,:,2) +...
                       tA(:,:,4));
    
    % Flip traces in X if necessary               
    posSign = -tAIX(:,2);
    oneVec = ones(1,size(headPosX,2));
    out = diff(headPosX.*(posSign*oneVec),1,2)./samplePeriod;
    out(:,end+1) = 0;
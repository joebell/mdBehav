%%
%
%   Head velocity in Y
%
function out = fcnYSpeed( tA, tAIX)

    samplePeriod = .05;

    % headPosX = bodyX + headX;
    headPosY = squeeze(tA(:,:,2) +...
                       tA(:,:,4));
    
    out = abs(diff(headPosY,1,2))./samplePeriod;
    out(:,end+1) = 0;
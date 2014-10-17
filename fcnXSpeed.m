%%
%
%   Head speed in X (Abs. val!)
%
function out = fcnXSpeed( tA, tAIX)

    samplePeriod = .05;

    % headPosX = bodyX + headX;
    headPosX = squeeze(tA(:,:,1) +...
                       tA(:,:,3));
    
    out = abs(diff(headPosX,1,2))./samplePeriod;
    out(:,end+1) = 0;
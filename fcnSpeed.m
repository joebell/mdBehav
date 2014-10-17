%%
%
%   Head speed in any direction. (Abs value!)
%
function out = fcnSpeed( tA, tAIX)

    samplePeriod = .05;

    % headPosX = bodyX + headX;
    headPosX = squeeze(tA(:,:,1) +...
                       tA(:,:,3));
    headPosY = squeeze(tA(:,:,2) +...
                       tA(:,:,4));
       
    out = sqrt(diff(headPosX,1,2).^2 + diff(headPosY,1,2).^2)./samplePeriod;
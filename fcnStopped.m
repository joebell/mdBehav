%%
% Calculates whether fly is backing up
%
function out = fcnStopped( tA, tAIX)

    headPosX = squeeze(tA(:,:,1) +...
                       tA(:,:,3));

    for trackN=1:size(tA,1)
        % trackN
        stateSequence(trackN,:) = identifyStates(headPosX(trackN,:));  
    end
    out = (stateSequence == 2);
   
%     smoothSamples = 5;
%     velThresh = 1;
%     
%     speed = fcnSpeed( tA, tAIX);
%     
%     for traceN = 1:size(speed,1)
%         speed(traceN, :) = smooth(speed(traceN,:), smoothSamples);
%     end
% 
%     out = (speed <= velThresh);
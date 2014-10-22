%%
% Calculates whether fly is stopped
%
function starts = fcnStartFromStop( tA, tAIX)

    headPosX = squeeze(tA(:,:,1) +...
                       tA(:,:,3));

    for trackN=1:size(tA,1)
        % trackN
        stateSequence = identifyStates(headPosX(trackN,:)); 

        thisState = stateSequence(1:(end-1));
        nextState = stateSequence(2:end);
        
        ix = find(stateSequence ~= 2);
        starts(trackN,ix) = NaN;        
        ix = find(stateSequence == 2);
        starts(trackN,ix) = 0;    
        ix = find(((thisState == 2) & (nextState ~= 2)));
        starts(trackN,ix) = 1;
    end
    
   
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
%%
% Calculates whether fly is backing up
%
function out = fcnBacking( tA, tAIX)
   
    smoothSamples = 5;
    velThresh = -.5;
    
    forwardVel = fcnForwardVel( tA, tAIX);
    
    for traceN = 1:size(forwardVel,1)
        forwardVel(traceN, :) = smooth(forwardVel(traceN,:), smoothSamples);
    end

    out = (forwardVel <= velThresh);
    
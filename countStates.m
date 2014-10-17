% Calculated in 5 spatial zones, z5 on odor size
%
% fromCount gives the # of fromState occurrences in each zone
% toCount gives the # of those fromState occurrences that go to toState
%
function [toCount fromCount] = countStates(tA, tAIX, timeWindow, fromToList)

    zoneBounds = [-Inf,-15,-5,5,15,Inf];

    samplePeriod = .05;
    nTraces = size(tAIX, 1);
    
    sampleWindow = timeWindow./samplePeriod;
    
    % headPosX = bodyX + headX;
    headPosX = squeeze(tA(:,:,1) +...
                       tA(:,:,3));
                   
    toCount = zeros(nTraces, 5);
    fromCount = zeros(nTraces, 5);
    for traceN = 1:nTraces
        % Flip for laser on left if necessary
        oneTrack = (-tAIX(traceN,2))*headPosX(traceN,:);
        stateTrack = identifyStates(oneTrack);
        subStateTrack = stateTrack(sampleWindow(1):sampleWindow(2));
        subTrack = oneTrack(sampleWindow(1):sampleWindow(2));
        
        % Find the indices of all turns in the subTrack
        thisState = subStateTrack(1:(end-1));
        nextState = subStateTrack(2:end);
        transIX = [];
        stateIX = [];
        for pairN = 1:size(fromToList,1)
            thisTarget = fromToList(pairN,1);
            nextTarget = fromToList(pairN,2);
            
            transIX = cat(1,transIX, find((thisState == thisTarget) &...
                                          (nextState == nextTarget)));
            stateIX = cat(1, stateIX, find(thisState == thisTarget));                        
        end
        
        % Count the turns in each zone, and the zone occupancy
        N = histc(subTrack(transIX), zoneBounds);
        toCount(traceN,:) = N(1:5);
        N = histc(subTrack(stateIX), zoneBounds);
        fromCount(traceN,:) = N(1:5);
    end
    

                   

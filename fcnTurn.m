%%
% Calculates any turn
%
function out = fcnTurn( tA, tAIX)
   
    headPosX = squeeze(tA(:,:,1) +...
                       tA(:,:,3));

    for trackN=1:size(tA,1)
        % trackN
        stateSequence(trackN,:) = identifyStates(headPosX(trackN,:));  
    end
    dS = diff(stateSequence,1,2); dS(:,end+1) = 0;
    
    out = (abs(dS) > 1);
    
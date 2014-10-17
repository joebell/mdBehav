%%
%  Uses reflected X coords, so laser is always on positive side. Entries
%  are always paired with exits.
%
%   if (firstOnly) -> Return only the first entry.
%
%   if (~timeEntries) -> Don't take being in the zone at start of
%   timeWindow as a valid entry.
%
%   if (~timeExits) -> Don't take being in the zone at the end of
%   time Window as a valid exit
%
function [gIX, stSamp, enSamp] = gateOnXPosition(tA, tAIX, timeWindow, gatePosition, firstOnly, timeEntries, timeExits)
    
    samplePeriod = .05;
    sampleWindow = timeWindow./samplePeriod;
    nTraces = size(tAIX, 1);
    
    % headPosX = bodyX + headX;
    headPosX = squeeze(tA(:,:,1) +...
                       tA(:,:,3));
    headPosY = squeeze(tA(:,:,2) +...
                       tA(:,:,4));
    gIX = [];
    stSamp = [];
    enSamp = [];
    for traceN = 1:size(tAIX,1)
        
        % Flip the trace so lasered side is always positive.
        oneTrace = -tAIX(traceN,2)*headPosX(traceN,:);
        
        % Find when the laser is in the gate-zone
        inZone = zeros(length(oneTrace),1);
        windowedZone = zeros(length(oneTrace),1);
        zIX = find((oneTrace >= gatePosition(1)) & (oneTrace < gatePosition(2)));
        inZone(zIX) = 1;
        
        % Take only the parts that are in the sample window
        ix = find((zIX >= sampleWindow(1)) & (zIX < sampleWindow(2)));
        windowedZone(zIX(ix)) = 1;
        
        % Find entries and exits
        thisWZ = windowedZone(1:(end-1));
        nextWZ = windowedZone(2:end);
        entries = find((thisWZ == 0) & (nextWZ == 1)) + 1;
        exits   = find((thisWZ == 1) & (nextWZ == 0)) + 1;
        
        % Take only first entry?
        if firstOnly
            entries(2:end) = [];
            exits(2:end) = [];
        end
                     
        % If fly was in the zone at the start of the timeWindow,
        % throw it out if ~timeEntries
        if length(entries) > 0
            if ~timeEntries && (inZone(entries(1) - 1) == 1)
                % disp('Rem entry.');
                entries(1) = [];
                exits(1) = [];
            end
        end
        
        % If fly was in the zone at the end of the timeWindow,
        % throw it out if ~timeEntries
        if length(exits) > 0
            if ~timeExits && (inZone(exits(end) + 1) == 1)
                % disp('Rem. exit');
                entries(end) = [];
                exits (end) = [];
            end
        end
        
%         clf;
%         plot(oneTrace,'b.-'); hold on;
%         scatter(entries,oneTrace(entries),'go');
%         scatter(exits,oneTrace(exits),'ro');
%         plot(xlim(),gatePosition(1).*[1 1],'k');
%         plot(xlim(),gatePosition(2).*[1 1],'k');
%         plot(sampleWindow(1).*[1 1],ylim,'k');
%         plot(sampleWindow(2).*[1 1],ylim,'k');
%         pause;
%         disp('-');
        
        gIX = cat(1,gIX,traceN*ones(length(entries),1));
        stSamp = cat(1, stSamp, entries(:));
        enSamp = cat(1, enSamp, exits(:));

    end
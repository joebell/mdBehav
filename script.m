 
% PI measurement
% gateWindow = [60 90];
% [gIX, stSamp, enSamp] = gateOnTime(tAIX, gateWindow);
% calcFcn = @fcnOccupancy;
% [perGateMeas, measIX] = calcFcnOnGate(tA, tAIX, gIX, stSamp, enSamp, calcFcn);

% decPI measurement (avg. occupancy on mid-zone exit)
% gatePosition = [-5 5];
% firstOnly = false; timeEntries = true; timeExits = false;
% [gIX, stSamp, exSamp] = gateOnXPosition(tA, tAIX, timeWindow, gatePosition, firstOnly, timeEntries, timeExits);
% calcFcn = @fcnOccupancy;
% [perGateMeas, measIX] = calcFcnOnGate( tA, tAIX, gIX, exSamp, exSamp + 1, calcFcn);


% % Speed on first Laser Entry + [0 -> 1sec]
% timeWindow = [60 90];
% firstOnly = true;
% timeEntries = false;
% timeExits = true;
% gatePosition = [0 30];
% [gIX, stSamp, enSamp] = gateOnXPosition(tA, tAIX, timeWindow, gatePosition, firstOnly, timeEntries, timeExits);
% calcFcn = @fcnHeadAngleSpeed;
% enSamp = stSamp + round(.5/.05);
% [perGateMeas, measIX] = calcFcnOnGate(tA, tAIX, gIX, stSamp, enSamp, calcFcn);
% 
% plotWindow = [-2 2];
% plotOnGate( tA, tAIX, gIX, stSamp, plotWindow, calcFcn);

% Speed in lasered zone
% timeWindow = [60 90];
% firstOnly = false;
% timeEntries = true;
% timeExits = true;
% gatePosition = [0 30];
% [gIX, stSamp, enSamp] = gateOnXPosition(tA, tAIX, timeWindow, gatePosition, firstOnly, timeEntries, timeExits);
% calcFcn = @fcnSpeed;
% [perGateMeas, measIX] = calcFcnOnGate(tA, tAIX, gIX, stSamp, enSamp, calcFcn);
    
% P(backing) in 1 sec after first laser
% timeWindow = [60 90];
% firstOnly = true;
% timeEntries = false;
% timeExits = true;
% gatePosition = [0 30];
% [gIX, stSamp, enSamp] = gateOnXPosition(tA, tAIX, timeWindow, gatePosition, firstOnly, timeEntries, timeExits);
% calcFcn = @fcnTurn;
% stSamp = enSamp;
% enSamp = stSamp + round(1/.05);
% [perGateMeas, measIX] = calcMaxFcnOnGate(tA, tAIX, gIX, stSamp, enSamp, calcFcn);
% [meanMetrics, meanIX] = stratifyByFly(perGateMeas, measIX, tAIX);

timeStart = 90;
gatePosition = [0 30];
upLaser = false;
[gIX, stSamp] = gateFlashEncounterByDirection(tA, tAIX, timeStart, gatePosition, upLaser);
plotWindow = [-2 2];
calcFcn = @fcnTurn;
plotOnGate( tA, tAIX, gIX, stSamp, plotWindow, calcFcn);

% [meanMetrics, meanIX] = stratifyByFly(perGateMeas, measIX, tAIX);
% plotMeanMetrics(meanMetrics, meanIX, 'b'); hold on;



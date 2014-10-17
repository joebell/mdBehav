function calcAllMetrics(genoN)

	load(['~/derived/geno',num2str(genoN,'%03d'),'.mat']);

	tA = trackArray;
	tAIX = trackIndex;

    allMetrics = [];
    metricLabels = {};
    
    % PI
    gateWindow = [60 90];
    [gIX, stSamp, enSamp] = gateOnTime(tAIX, gateWindow);
    calcFcn = @fcnOccupancy;
    [perGateMeas, measIX] = calcFcnOnGate(tA, tAIX, gIX, stSamp, enSamp, calcFcn);
    [meanMetrics, meanIX] = stratifyByFly(perGateMeas, measIX, tAIX);
    allMetrics = cat(2,allMetrics,meanMetrics);
    metricLabels{end+1} = 'PI';
    
    % decPI
    gatePosition = [-5 5];
    gateWindow = [60 90];
    firstOnly = false; timeEntries = true; timeExits = false;
    [gIX, stSamp, exSamp] = gateOnXPosition(tA, tAIX, gateWindow, gatePosition, firstOnly, timeEntries, timeExits);
    calcFcn = @fcnOccupancy;
    [perGateMeas, measIX] = calcFcnOnGate( tA, tAIX, gIX, exSamp, exSamp + 1, calcFcn);
    [meanMetrics, meanIX] = stratifyByFly(perGateMeas, measIX, tAIX);
    allMetrics = cat(2,allMetrics,meanMetrics);
    metricLabels{end+1} = 'decPI';
    
    % Speed in lasered zone
    timeWindow = [60 90];
    firstOnly = false;
    timeEntries = true;
    timeExits = true;
    gatePosition = [0 30];
    [gIX, stSamp, enSamp] = gateOnXPosition(tA, tAIX, timeWindow, gatePosition, firstOnly, timeEntries, timeExits);
    calcFcn = @fcnSpeed;
    [perGateMeas, measIX] = calcFcnOnGate(tA, tAIX, gIX, stSamp, enSamp, calcFcn);
    [meanMetrics, meanIX] = stratifyByFly(perGateMeas, measIX, tAIX);
    allMetrics = cat(2,allMetrics,meanMetrics);
    metricLabels{end+1} = 'Speed in laser';
    
    % Speed in non-lasered zone
    timeWindow = [60 90];
    firstOnly = false;
    timeEntries = true;
    timeExits = true;
    gatePosition = [-30 0];
    [gIX, stSamp, enSamp] = gateOnXPosition(tA, tAIX, timeWindow, gatePosition, firstOnly, timeEntries, timeExits);
    calcFcn = @fcnSpeed;
    [perGateMeas, measIX] = calcFcnOnGate(tA, tAIX, gIX, stSamp, enSamp, calcFcn);
    [meanMetrics, meanIX] = stratifyByFly(perGateMeas, measIX, tAIX);
    allMetrics = cat(2,allMetrics,meanMetrics);
    metricLabels{end+1} = 'Speed in non-laser';
    
    % Forward speed on first Laser Entry + [0 -> 1sec]
    timeWindow = [60 90];
    firstOnly = true;
    timeEntries = false;
    timeExits = true;
    gatePosition = [0 30];
    [gIX, stSamp, enSamp] = gateOnXPosition(tA, tAIX, timeWindow, gatePosition, firstOnly, timeEntries, timeExits);
    calcFcn = @fcnForwardVel;
    enSamp = stSamp + round(1/.05);
    [perGateMeas, measIX] = calcFcnOnGate(tA, tAIX, gIX, stSamp, enSamp, calcFcn);
    [meanMetrics, meanIX] = stratifyByFly(perGateMeas, measIX, tAIX);
    allMetrics = cat(2,allMetrics,meanMetrics);
    metricLabels{end+1} = 'Forward speed on first entry';
    
    % Side speed on first Laser Entry + [0 -> 1sec]
    timeWindow = [60 90];
    firstOnly = true;
    timeEntries = false;
    timeExits = true;
    gatePosition = [0 30];
    [gIX, stSamp, enSamp] = gateOnXPosition(tA, tAIX, timeWindow, gatePosition, firstOnly, timeEntries, timeExits);
    calcFcn = @fcnSideSpeed;
    enSamp = stSamp + round(1/.05);
    [perGateMeas, measIX] = calcFcnOnGate(tA, tAIX, gIX, stSamp, enSamp, calcFcn);
    [meanMetrics, meanIX] = stratifyByFly(perGateMeas, measIX, tAIX);
    allMetrics = cat(2,allMetrics,meanMetrics);
    metricLabels{end+1} = 'Side speed on first entry';
    
    % Head angle speed on first Laser Entry + [0 -> 1sec]
    timeWindow = [60 90];
    firstOnly = true;
    timeEntries = false;
    timeExits = true;
    gatePosition = [0 30];
    [gIX, stSamp, enSamp] = gateOnXPosition(tA, tAIX, timeWindow, gatePosition, firstOnly, timeEntries, timeExits);
    calcFcn = @fcnHeadAngleSpeed;
    enSamp = stSamp + round(1/.05);
    [perGateMeas, measIX] = calcFcnOnGate(tA, tAIX, gIX, stSamp, enSamp, calcFcn);
    [meanMetrics, meanIX] = stratifyByFly(perGateMeas, measIX, tAIX);
    allMetrics = cat(2,allMetrics,meanMetrics);
    metricLabels{end+1} = 'Head angle speed on first entry';
    
    % P(backing) on first Laser Entry + [0 -> 1 sec]
    timeWindow = [60 90];
    firstOnly = true;
    timeEntries = false;
    timeExits = true;
    gatePosition = [0 30];
    [gIX, stSamp, enSamp] = gateOnXPosition(tA, tAIX, timeWindow, gatePosition, firstOnly, timeEntries, timeExits);
    calcFcn = @fcnBacking;
    enSamp = stSamp + round(1/.05);
    [perGateMeas, measIX] = calcMaxFcnOnGate(tA, tAIX, gIX, stSamp, enSamp, calcFcn);
    [meanMetrics, meanIX] = stratifyByFly(perGateMeas, measIX, tAIX);
    allMetrics = cat(2,allMetrics,meanMetrics);
    metricLabels{end+1} = 'P(backing) on first entry';
    
    % P(stopped) on first Laser Entry + [0 -> 1 sec]
    timeWindow = [60 90];
    firstOnly = true;
    timeEntries = false;
    timeExits = true;
    gatePosition = [0 30];
    [gIX, stSamp, enSamp] = gateOnXPosition(tA, tAIX, timeWindow, gatePosition, firstOnly, timeEntries, timeExits);
    calcFcn = @fcnStopped;
    enSamp = stSamp + round(1/.05);
    [perGateMeas, measIX] = calcMaxFcnOnGate(tA, tAIX, gIX, stSamp, enSamp, calcFcn);
    [meanMetrics, meanIX] = stratifyByFly(perGateMeas, measIX, tAIX);
    allMetrics = cat(2,allMetrics,meanMetrics);
    metricLabels{end+1} = 'P(stopped) on first entry';
    
    % P(turn) on first Laser Entry + [0 -> 1 sec]
    timeWindow = [60 90];
    firstOnly = true;
    timeEntries = false;
    timeExits = true;
    gatePosition = [0 30];
    [gIX, stSamp, enSamp] = gateOnXPosition(tA, tAIX, timeWindow, gatePosition, firstOnly, timeEntries, timeExits);
    calcFcn = @fcnTurn;
    enSamp = stSamp + round(1/.05);
    [perGateMeas, measIX] = calcMaxFcnOnGate(tA, tAIX, gIX, stSamp, enSamp, calcFcn);
    [meanMetrics, meanIX] = stratifyByFly(perGateMeas, measIX, tAIX);
    allMetrics = cat(2,allMetrics,meanMetrics);
    metricLabels{end+1} = 'P(turn) on first entry';
    
    
    
    %% Laser exits
          
    % Forward speed on laser exit + [0 -> 1sec]
    timeWindow = [60 90];
    firstOnly = false;
    timeEntries = true;
    timeExits = false;
    gatePosition = [0 30];
    [gIX, stSamp, enSamp] = gateOnXPosition(tA, tAIX, timeWindow, gatePosition, firstOnly, timeEntries, timeExits);
    calcFcn = @fcnForwardVel;
    stSamp = enSamp;
    enSamp = stSamp + round(1/.05);
    [perGateMeas, measIX] = calcFcnOnGate(tA, tAIX, gIX, stSamp, enSamp, calcFcn);
    [meanMetrics, meanIX] = stratifyByFly(perGateMeas, measIX, tAIX);
    allMetrics = cat(2,allMetrics,meanMetrics);
    metricLabels{end+1} = 'Forward speed on exit';
    
    % Side speed on Laser Exit + [0 -> 1sec]
    timeWindow = [60 90];
    firstOnly = false;
    timeEntries = true;
    timeExits = false;
    gatePosition = [0 30];
    [gIX, stSamp, enSamp] = gateOnXPosition(tA, tAIX, timeWindow, gatePosition, firstOnly, timeEntries, timeExits);
    calcFcn = @fcnSideSpeed;
    stSamp = enSamp;
    enSamp = stSamp + round(1/.05);
    [perGateMeas, measIX] = calcFcnOnGate(tA, tAIX, gIX, stSamp, enSamp, calcFcn);
    [meanMetrics, meanIX] = stratifyByFly(perGateMeas, measIX, tAIX);
    allMetrics = cat(2,allMetrics,meanMetrics);
    metricLabels{end+1} = 'Side speed on exit';
    
    % Head angle speed on Laser Exit + [0 -> 1sec]
    timeWindow = [60 90];
    firstOnly = false;
    timeEntries = true;
    timeExits = false;
    gatePosition = [0 30];
    [gIX, stSamp, enSamp] = gateOnXPosition(tA, tAIX, timeWindow, gatePosition, firstOnly, timeEntries, timeExits);
    calcFcn = @fcnHeadAngleSpeed;
    stSamp = enSamp;
    enSamp = stSamp + round(1/.05);
    [perGateMeas, measIX] = calcFcnOnGate(tA, tAIX, gIX, stSamp, enSamp, calcFcn);
    [meanMetrics, meanIX] = stratifyByFly(perGateMeas, measIX, tAIX);
    allMetrics = cat(2,allMetrics,meanMetrics);
    metricLabels{end+1} = 'Head angle speed on exit';
    
    % P(backing) on Laser Exit + [0 -> 1 sec]
    timeWindow = [60 90];
    firstOnly = false;
    timeEntries = true;
    timeExits = false;
    gatePosition = [0 30];
    [gIX, stSamp, enSamp] = gateOnXPosition(tA, tAIX, timeWindow, gatePosition, firstOnly, timeEntries, timeExits);
    calcFcn = @fcnBacking;
    stSamp = enSamp;
    enSamp = stSamp + round(1/.05);
    [perGateMeas, measIX] = calcMaxFcnOnGate(tA, tAIX, gIX, stSamp, enSamp, calcFcn);
    [meanMetrics, meanIX] = stratifyByFly(perGateMeas, measIX, tAIX);
    allMetrics = cat(2,allMetrics,meanMetrics);
    metricLabels{end+1} = 'P(backing) on exit';
    
    % P(stopped) on Laser Exit + [0 -> 1 sec]
    timeWindow = [60 90];
    firstOnly = false;
    timeEntries = true;
    timeExits = false;
    gatePosition = [0 30];
    [gIX, stSamp, enSamp] = gateOnXPosition(tA, tAIX, timeWindow, gatePosition, firstOnly, timeEntries, timeExits);
    calcFcn = @fcnStopped;
    stSamp = enSamp;
    enSamp = stSamp + round(1/.05);
    [perGateMeas, measIX] = calcMaxFcnOnGate(tA, tAIX, gIX, stSamp, enSamp, calcFcn);
    [meanMetrics, meanIX] = stratifyByFly(perGateMeas, measIX, tAIX);
    allMetrics = cat(2,allMetrics,meanMetrics);
    metricLabels{end+1} = 'P(stopped) on exit';
    
        
    % P(turn) on Laser Exit + [0 -> 1 sec]
    timeWindow = [60 90];
    firstOnly = false;
    timeEntries = true;
    timeExits = false;
    gatePosition = [0 30];
    [gIX, stSamp, enSamp] = gateOnXPosition(tA, tAIX, timeWindow, gatePosition, firstOnly, timeEntries, timeExits);
    calcFcn = @fcnTurn;
    stSamp = enSamp;
    enSamp = stSamp + round(1/.05);
    [perGateMeas, measIX] = calcMaxFcnOnGate(tA, tAIX, gIX, stSamp, enSamp, calcFcn);
    [meanMetrics, meanIX] = stratifyByFly(perGateMeas, measIX, tAIX);
    allMetrics = cat(2,allMetrics,meanMetrics);
    metricLabels{end+1} = 'P(turn) on exit';
    
    %% Laser Flash Ons Upwind
    
    % Forward speed on laser flash on + [0 -> 1sec]
    timeStart = 60;
    gatePosition = [0 30]; upLaser = true;
    [gIX, stSamp] = gateFlashEncounterByDirection(tA, tAIX, timeStart, gatePosition, upLaser);
    calcFcn = @fcnForwardVel;
    enSamp = stSamp + round(1/.05);
    [perGateMeas, measIX] = calcFcnOnGate(tA, tAIX, gIX, stSamp, enSamp, calcFcn);
    [meanMetrics, meanIX] = stratifyByFly(perGateMeas, measIX, tAIX);
    allMetrics = cat(2,allMetrics,meanMetrics);
    metricLabels{end+1} = 'Forward speed on upwind flash-on';
    
    % Side speed on Laser flash on + [0 -> 1sec]
    timeStart = 60;
    gatePosition = [0 30]; upLaser = true;
    [gIX, stSamp] = gateFlashEncounterByDirection(tA, tAIX, timeStart, gatePosition, upLaser);
    calcFcn = @fcnSideSpeed;
    enSamp = stSamp + round(1/.05);
    [perGateMeas, measIX] = calcFcnOnGate(tA, tAIX, gIX, stSamp, enSamp, calcFcn);
    [meanMetrics, meanIX] = stratifyByFly(perGateMeas, measIX, tAIX);
    allMetrics = cat(2,allMetrics,meanMetrics);
    metricLabels{end+1} = 'Side speed on upwind flash-on';
    
    % Head angle speed on Laser flash on + [0 -> 1sec]
    timeStart = 60;
    gatePosition = [0 30]; upLaser = true;
    [gIX, stSamp] = gateFlashEncounterByDirection(tA, tAIX, timeStart, gatePosition, upLaser);
    calcFcn = @fcnHeadAngleSpeed;
    enSamp = stSamp + round(1/.05);
    [perGateMeas, measIX] = calcFcnOnGate(tA, tAIX, gIX, stSamp, enSamp, calcFcn);
    [meanMetrics, meanIX] = stratifyByFly(perGateMeas, measIX, tAIX);
    allMetrics = cat(2,allMetrics,meanMetrics);
    metricLabels{end+1} = 'Head angle speed on upwind flash-on';
    
    % P(backing) on Laser flash on + [0 -> 1 sec]
    timeStart = 60;
    gatePosition = [0 30]; upLaser = true;
    [gIX, stSamp] = gateFlashEncounterByDirection(tA, tAIX, timeStart, gatePosition, upLaser);
    calcFcn = @fcnBacking;
    enSamp = stSamp + round(1/.05);
    [perGateMeas, measIX] = calcMaxFcnOnGate(tA, tAIX, gIX, stSamp, enSamp, calcFcn);
    [meanMetrics, meanIX] = stratifyByFly(perGateMeas, measIX, tAIX);
    allMetrics = cat(2,allMetrics,meanMetrics);
    metricLabels{end+1} = 'P(backing) on upwind flash-on';
    
    % P(stopped) on Laser flash on + [0 -> 1 sec]
    timeStart = 60;
    gatePosition = [0 30]; upLaser = true;
    [gIX, stSamp] = gateFlashEncounterByDirection(tA, tAIX, timeStart, gatePosition, upLaser);
    calcFcn = @fcnStopped;
    enSamp = stSamp + round(1/.05);
    [perGateMeas, measIX] = calcMaxFcnOnGate(tA, tAIX, gIX, stSamp, enSamp, calcFcn);
    [meanMetrics, meanIX] = stratifyByFly(perGateMeas, measIX, tAIX);
    allMetrics = cat(2,allMetrics,meanMetrics);
    metricLabels{end+1} = 'P(stopped) on upwind flash-on';
    
        
    % P(turn) on Laser flash on + [0 -> 1 sec]
    timeStart = 60;
    gatePosition = [0 30]; upLaser = true;
    [gIX, stSamp] = gateFlashEncounterByDirection(tA, tAIX, timeStart, gatePosition, upLaser);
    calcFcn = @fcnTurn;
    enSamp = stSamp + round(1/.05);
    [perGateMeas, measIX] = calcMaxFcnOnGate(tA, tAIX, gIX, stSamp, enSamp, calcFcn);
    [meanMetrics, meanIX] = stratifyByFly(perGateMeas, measIX, tAIX);
    allMetrics = cat(2,allMetrics,meanMetrics);
    metricLabels{end+1} = 'P(turn) on upwind flash-on';
    
    %% Laser Flash Ons Downwind
    
    % Forward speed on laser flash on + [0 -> 1sec]
    timeStart = 60;
    gatePosition = [0 30]; upLaser = false;
    [gIX, stSamp] = gateFlashEncounterByDirection(tA, tAIX, timeStart, gatePosition, upLaser);
    calcFcn = @fcnForwardVel;
    enSamp = stSamp + round(1/.05);
    [perGateMeas, measIX] = calcFcnOnGate(tA, tAIX, gIX, stSamp, enSamp, calcFcn);
    [meanMetrics, meanIX] = stratifyByFly(perGateMeas, measIX, tAIX);
    allMetrics = cat(2,allMetrics,meanMetrics);
    metricLabels{end+1} = 'Forward speed on downwind flash-on';
    
    % Side speed on Laser flash on + [0 -> 1sec]
    timeStart = 60;
    gatePosition = [0 30]; upLaser = false;
    [gIX, stSamp] = gateFlashEncounterByDirection(tA, tAIX, timeStart, gatePosition, upLaser);
    calcFcn = @fcnSideSpeed;
    enSamp = stSamp + round(1/.05);
    [perGateMeas, measIX] = calcFcnOnGate(tA, tAIX, gIX, stSamp, enSamp, calcFcn);
    [meanMetrics, meanIX] = stratifyByFly(perGateMeas, measIX, tAIX);
    allMetrics = cat(2,allMetrics,meanMetrics);
    metricLabels{end+1} = 'Side speed on downwind flash-on';
    
    % Head angle speed on Laser flash on + [0 -> 1sec]
    timeStart = 60;
    gatePosition = [0 30]; upLaser = false;
    [gIX, stSamp] = gateFlashEncounterByDirection(tA, tAIX, timeStart, gatePosition, upLaser);
    calcFcn = @fcnHeadAngleSpeed;
    enSamp = stSamp + round(1/.05);
    [perGateMeas, measIX] = calcFcnOnGate(tA, tAIX, gIX, stSamp, enSamp, calcFcn);
    [meanMetrics, meanIX] = stratifyByFly(perGateMeas, measIX, tAIX);
    allMetrics = cat(2,allMetrics,meanMetrics);
    metricLabels{end+1} = 'Head angle speed on downwind flash-on';
    
    % P(backing) on Laser flash on + [0 -> 1 sec]
    timeStart = 60;
    gatePosition = [0 30]; upLaser = false;
    [gIX, stSamp] = gateFlashEncounterByDirection(tA, tAIX, timeStart, gatePosition, upLaser);
    calcFcn = @fcnBacking;
    enSamp = stSamp + round(1/.05);
    [perGateMeas, measIX] = calcMaxFcnOnGate(tA, tAIX, gIX, stSamp, enSamp, calcFcn);
    [meanMetrics, meanIX] = stratifyByFly(perGateMeas, measIX, tAIX);
    allMetrics = cat(2,allMetrics,meanMetrics);
    metricLabels{end+1} = 'P(backing) on downwind flash-on';
    
    % P(stopped) on Laser flash on + [0 -> 1 sec]
    timeStart = 60;
    gatePosition = [0 30]; upLaser = false;
    [gIX, stSamp] = gateFlashEncounterByDirection(tA, tAIX, timeStart, gatePosition, upLaser);
    calcFcn = @fcnStopped;
    enSamp = stSamp + round(1/.05);
    [perGateMeas, measIX] = calcMaxFcnOnGate(tA, tAIX, gIX, stSamp, enSamp, calcFcn);
    [meanMetrics, meanIX] = stratifyByFly(perGateMeas, measIX, tAIX);
    allMetrics = cat(2,allMetrics,meanMetrics);
    metricLabels{end+1} = 'P(stopped) on downwind flash-on';
    
        
    % P(turn) on Laser flash on + [0 -> 1 sec]
    timeStart = 60;
    gatePosition = [0 30]; upLaser = false;
    [gIX, stSamp] = gateFlashEncounterByDirection(tA, tAIX, timeStart, gatePosition, upLaser);
    calcFcn = @fcnTurn;
    enSamp = stSamp + round(1/.05);
    [perGateMeas, measIX] = calcMaxFcnOnGate(tA, tAIX, gIX, stSamp, enSamp, calcFcn);
    [meanMetrics, meanIX] = stratifyByFly(perGateMeas, measIX, tAIX);
    allMetrics = cat(2,allMetrics,meanMetrics);
    metricLabels{end+1} = 'P(turn) on downwind flash-on';
    
    %% Laser Flash Offs Upwind
    
    % Forward speed on laser flash off + [0 -> 1sec]
    timeStart = 90;
    gatePosition = [0 30]; upLaser = true;
    [gIX, stSamp] = gateFlashEncounterByDirection(tA, tAIX, timeStart, gatePosition, upLaser);
    calcFcn = @fcnForwardVel;
    enSamp = stSamp + round(1/.05);
    [perGateMeas, measIX] = calcFcnOnGate(tA, tAIX, gIX, stSamp, enSamp, calcFcn);
    [meanMetrics, meanIX] = stratifyByFly(perGateMeas, measIX, tAIX);
    allMetrics = cat(2,allMetrics,meanMetrics);
    metricLabels{end+1} = 'Forward speed on upwind flash-off';
    
    % Side speed on Laser flash off + [0 -> 1sec]
    timeStart = 90;
    gatePosition = [0 30]; upLaser = true;
    [gIX, stSamp] = gateFlashEncounterByDirection(tA, tAIX, timeStart, gatePosition, upLaser);
    calcFcn = @fcnSideSpeed;
    enSamp = stSamp + round(1/.05);
    [perGateMeas, measIX] = calcFcnOnGate(tA, tAIX, gIX, stSamp, enSamp, calcFcn);
    [meanMetrics, meanIX] = stratifyByFly(perGateMeas, measIX, tAIX);
    allMetrics = cat(2,allMetrics,meanMetrics);
    metricLabels{end+1} = 'Side speed on upwind flash-off';
    
    % Head angle speed on Laser flash off + [0 -> 1sec]
    timeStart = 90;
    gatePosition = [0 30]; upLaser = true;
    [gIX, stSamp] = gateFlashEncounterByDirection(tA, tAIX, timeStart, gatePosition, upLaser);
    calcFcn = @fcnHeadAngleSpeed;
    enSamp = stSamp + round(1/.05);
    [perGateMeas, measIX] = calcFcnOnGate(tA, tAIX, gIX, stSamp, enSamp, calcFcn);
    [meanMetrics, meanIX] = stratifyByFly(perGateMeas, measIX, tAIX);
    allMetrics = cat(2,allMetrics,meanMetrics);
    metricLabels{end+1} = 'Head angle speed on upwind flash-off';
    
    % P(backing) on Laser flash off + [0 -> 1 sec]
    timeStart = 90;
    gatePosition = [0 30]; upLaser = true;
    [gIX, stSamp] = gateFlashEncounterByDirection(tA, tAIX, timeStart, gatePosition, upLaser);
    calcFcn = @fcnBacking;
    enSamp = stSamp + round(1/.05);
    [perGateMeas, measIX] = calcMaxFcnOnGate(tA, tAIX, gIX, stSamp, enSamp, calcFcn);
    [meanMetrics, meanIX] = stratifyByFly(perGateMeas, measIX, tAIX);
    allMetrics = cat(2,allMetrics,meanMetrics);
    metricLabels{end+1} = 'P(backing) on upwind flash-off';
    
    % P(stopped) on Laser flash off + [0 -> 1 sec]
    timeStart = 90;
    gatePosition = [0 30]; upLaser = true;
    [gIX, stSamp] = gateFlashEncounterByDirection(tA, tAIX, timeStart, gatePosition, upLaser);
    calcFcn = @fcnStopped;
    enSamp = stSamp + round(1/.05);
    [perGateMeas, measIX] = calcMaxFcnOnGate(tA, tAIX, gIX, stSamp, enSamp, calcFcn);
    [meanMetrics, meanIX] = stratifyByFly(perGateMeas, measIX, tAIX);
    allMetrics = cat(2,allMetrics,meanMetrics);
    metricLabels{end+1} = 'P(stopped) on upwind flash-off';
    
        
    % P(turn) on Laser flash off + [0 -> 1 sec]
    timeStart = 90;
    gatePosition = [0 30]; upLaser = true;
    [gIX, stSamp] = gateFlashEncounterByDirection(tA, tAIX, timeStart, gatePosition, upLaser);
    calcFcn = @fcnTurn;
    enSamp = stSamp + round(1/.05);
    [perGateMeas, measIX] = calcMaxFcnOnGate(tA, tAIX, gIX, stSamp, enSamp, calcFcn);
    [meanMetrics, meanIX] = stratifyByFly(perGateMeas, measIX, tAIX);
    allMetrics = cat(2,allMetrics,meanMetrics);
    metricLabels{end+1} = 'P(turn) on upwind flash-off';
    
    %% Laser Flash Offs Downwind
    
    % Forward speed on laser flash off + [0 -> 1sec]
    timeStart = 90;
    gatePosition = [0 30]; upLaser = false;
    [gIX, stSamp] = gateFlashEncounterByDirection(tA, tAIX, timeStart, gatePosition, upLaser);
    calcFcn = @fcnForwardVel;
    enSamp = stSamp + round(1/.05);
    [perGateMeas, measIX] = calcFcnOnGate(tA, tAIX, gIX, stSamp, enSamp, calcFcn);
    [meanMetrics, meanIX] = stratifyByFly(perGateMeas, measIX, tAIX);
    allMetrics = cat(2,allMetrics,meanMetrics);
    metricLabels{end+1} = 'Forward speed on downwind flash-off';
    
    % Side speed on Laser flash off + [0 -> 1sec]
    timeStart = 90;
    gatePosition = [0 30]; upLaser = false;
    [gIX, stSamp] = gateFlashEncounterByDirection(tA, tAIX, timeStart, gatePosition, upLaser);
    calcFcn = @fcnSideSpeed;
    enSamp = stSamp + round(1/.05);
    [perGateMeas, measIX] = calcFcnOnGate(tA, tAIX, gIX, stSamp, enSamp, calcFcn);
    [meanMetrics, meanIX] = stratifyByFly(perGateMeas, measIX, tAIX);
    allMetrics = cat(2,allMetrics,meanMetrics);
    metricLabels{end+1} = 'Side speed on downwind flash-off';
    
    % Head angle speed off Laser flash on + [0 -> 1sec]
    timeStart = 90;
    gatePosition = [0 30]; upLaser = false;
    [gIX, stSamp] = gateFlashEncounterByDirection(tA, tAIX, timeStart, gatePosition, upLaser);
    calcFcn = @fcnHeadAngleSpeed;
    enSamp = stSamp + round(1/.05);
    [perGateMeas, measIX] = calcFcnOnGate(tA, tAIX, gIX, stSamp, enSamp, calcFcn);
    [meanMetrics, meanIX] = stratifyByFly(perGateMeas, measIX, tAIX);
    allMetrics = cat(2,allMetrics,meanMetrics);
    metricLabels{end+1} = 'Head angle speed on downwind flash-off';
    
    % P(backing) on Laser flash on + [0 -> 1 sec]
    timeStart = 90;
    gatePosition = [0 30]; upLaser = false;
    [gIX, stSamp] = gateFlashEncounterByDirection(tA, tAIX, timeStart, gatePosition, upLaser);
    calcFcn = @fcnBacking;
    enSamp = stSamp + round(1/.05);
    [perGateMeas, measIX] = calcMaxFcnOnGate(tA, tAIX, gIX, stSamp, enSamp, calcFcn);
    [meanMetrics, meanIX] = stratifyByFly(perGateMeas, measIX, tAIX);
    allMetrics = cat(2,allMetrics,meanMetrics);
    metricLabels{end+1} = 'P(backing) on downwind flash-off';
    
    % P(stopped) on Laser flash off + [0 -> 1 sec]
    timeStart = 90;
    gatePosition = [0 30]; upLaser = false;
    [gIX, stSamp] = gateFlashEncounterByDirection(tA, tAIX, timeStart, gatePosition, upLaser);
    calcFcn = @fcnStopped;
    enSamp = stSamp + round(1/.05);
    [perGateMeas, measIX] = calcMaxFcnOnGate(tA, tAIX, gIX, stSamp, enSamp, calcFcn);
    [meanMetrics, meanIX] = stratifyByFly(perGateMeas, measIX, tAIX);
    allMetrics = cat(2,allMetrics,meanMetrics);
    metricLabels{end+1} = 'P(stopped) on downwind flash-off';
    
        
    % P(turn) on Laser flash off + [0 -> 1 sec]
    timeStart = 90;
    gatePosition = [0 30]; upLaser = false;
    [gIX, stSamp] = gateFlashEncounterByDirection(tA, tAIX, timeStart, gatePosition, upLaser);
    calcFcn = @fcnTurn;
    enSamp = stSamp + round(1/.05);
    [perGateMeas, measIX] = calcMaxFcnOnGate(tA, tAIX, gIX, stSamp, enSamp, calcFcn);
    [meanMetrics, meanIX] = stratifyByFly(perGateMeas, measIX, tAIX);
    allMetrics = cat(2,allMetrics,meanMetrics);
    metricLabels{end+1} = 'P(turn) on downwind flash-off';
    
    allMetricIX = meanIX;

	save(['~/derived/allMetrics',num2str(genoN,'%03d'),'.mat'],'allMetrics','allMetricIX','metricLabels');

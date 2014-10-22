% Gr63a script

clear all;
genoN = 12;
load(['~/Desktop/Code/derived/geno',num2str(genoN,'%03d'),'.mat']);
tA = trackArray; tAIX = trackIndex;


% % PI
%     figure();
%     gateWindow = [60 90];
%     [gIX, stSamp, enSamp] = gateOnTime(tAIX, gateWindow);
%     calcFcn = @fcnOccupancy;
%     [perGateMeas, measIX] = calcFcnOnGate(tA, tAIX, gIX, stSamp, enSamp, calcFcn);
%     [meanMetrics, meanIX] = stratifyByFly(perGateMeas, measIX, tAIX);
% plotMeanMetrics(meanMetrics, meanIX,'b'); title('PI');

% Speed in lasered zone
timeWindow = [60 90];
firstOnly = true;
timeEntries = true;
timeExits = true;
gatePosition = [0 30];
[gIX, stSamp, enSamp] = gateOnXPosition(tA, tAIX, timeWindow, gatePosition, firstOnly, timeEntries, timeExits);
calcFcn = @fcnStopped;
[perGateMeas, measIX] = calcFcnOnGate(tA, tAIX, gIX, stSamp, enSamp, calcFcn);
plotWindow = [-5 45];
plotOnGate( tA, tAIX, gIX, stSamp, plotWindow, calcFcn);

% [perGateMeas, measIX] = calcFcnOnGate(tA, tAIX, gIX, stSamp, enSamp, calcFcn);
% [meanMetrics, meanIX] = stratifyByFly(perGateMeas, measIX, tAIX);
% plotMeanMetrics(meanMetrics, meanIX,'b');
    

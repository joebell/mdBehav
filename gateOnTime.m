function [gIX, stSamp, enSamp] = gateOnTime(tAIX, gateWindow)
    
    samplePeriod = .05;

    gIX = [1:size(tAIX,1)];
    stSamp = ones(length(gIX),1)*round(gateWindow(1)/.05);
    enSamp = ones(length(gIX),1)*round(gateWindow(2)/.05);
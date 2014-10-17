function plotOnGate( tA, tAIX, gIX, gSamp, plotWindow, calcFcn)

    samplePeriod = .05;
    sampWindow = [(plotWindow(1)./samplePeriod):(plotWindow(2)./samplePeriod)];

    powerList = unique(tAIX(:,1));
    flyList = unique(tAIX(:,8));
    Npowers = length(powerList);
    Nflies = length(flyList);
    
    plotQty = calcFcn(tA, tAIX);
       
    snippetArray = zeros(Npowers,Nflies,length(sampWindow));
    snippetCount = zeros(Npowers,Nflies);
    
    % Take the snippets from each gating event.
    for gateN = 1:length(gIX)
        IX = gIX(gateN);
        gateSample = gSamp(gateN);
        
        flyN   = tAIX(IX,8);
        powerN = tAIX(IX,1);
             
        snippet = plotQty(IX, gateSample + sampWindow);
%         subplot(4,2,powerN);
%         plot(sampWindow.*samplePeriod,snippet); hold on;
        snippetArray(powerN,flyN,:) = squeeze(snippetArray(powerN,flyN,:)) + snippet(:);
        snippetCount(powerN,flyN) = snippetCount(powerN,flyN) + 1;
    end
    
    % Average them by fly, by power
    for powerN = 1:Npowers
        for flyN = 1:Nflies          
            snippetAvg(powerN,flyN,:) = snippetArray(powerN,flyN,:)./snippetCount(powerN,flyN);
            % subplot(4,2,powerN);
            % plot(sampWindow.*samplePeriod,squeeze(snippetAvg(powerN,flyN,:))); hold on;
        end
    end  
    snipPowerMean = squeeze(nanmean(snippetAvg,2));
    snipPowerStd  = squeeze(nanstd(snippetAvg,0,2));
    
    % Plot the mean over those for each power
    for powerNplot = 1:Npowers
        
        subplot(4,2,powerNplot);
        
        for powerN = [1];
            h = joeArea(sampWindow.*samplePeriod, snipPowerMean(powerN,:) - snipPowerStd(powerN,:), ...
                snipPowerMean(powerN,:) + snipPowerStd(powerN,:)); hold on;
            set(h,'EdgeColor','none','FaceColor',pretty(9 - powerN),'FaceAlpha',.25);
            plot(sampWindow.*samplePeriod,snipPowerMean(powerN,:),'Color',pretty(9 - powerN)); hold on;
        end
        if (powerNplot ~= 1) 
            powerN = powerNplot;
            
            h = joeArea(sampWindow.*samplePeriod, snipPowerMean(powerN,:) - snipPowerStd(powerN,:), ...
                snipPowerMean(powerN,:) + snipPowerStd(powerN,:)); hold on;
            set(h,'EdgeColor','none','FaceColor',pretty(9 - powerN),'FaceAlpha',.4);
            plot(sampWindow.*samplePeriod,snipPowerMean(powerN,:),'Color',pretty(9 - powerN)); hold on;
        end
    end
    
    
    
    
function MIplot(grandMetrics, grandIX, MI, metricLabels)

    genoList = unique(grandIX(:,3));
    powerList = unique(grandIX(:,1));

    [B, IX] = sort(MI,'descend');
    % printMetricLabels(metricLabels, IX);
    
    figure;
    plot(B);


    
%     subplot(1,2,1);
%     plot(MI);
%     
%     subplot(1,2,2);
% 	 
%     plot(B);
    
    [genoMetrics, genoIX] = stratifyByGenotype(grandMetrics, grandIX);
    Z = zscore(genoMetrics,0,1);
    
    for genoNn=1:length(genoList)
        genoN = genoList(genoNn);
        
        ix = find(genoIX(:,3) == genoN);
        meanPI(genoNn) = mean(genoMetrics(ix,2));
    end
    [A,genoOrder] = sort(meanPI,'descend');
    
    figure
    plotList = 1:20;
    metricList = IX(plotList);
    for metricNnn = 1:length(plotList)
        metricNn = plotList(metricNnn);
        metricN = metricList(metricNn);
        ffsubplot(4,5,metricNnn)
        
        gpArray = pullGenoPower(Z,genoIX,metricN);
        %[A,genoOrder] = sort(mean(gpArray,2),'descend');
        image(gpArray(genoOrder,:),'CDataMapping','scaled');
        title(['#',num2str(metricNn),': ',metricLabels{metricN}]);
        caxis([-3,3]);  
        set(gca,'XTick',[],'YTick',[]);
        xlabel('Power'); ylabel('Genotype');
    end
    
    figure
    plotList = [21:40];
    metricList = IX(plotList);
    for metricNnn = 1:length(plotList)
        metricNn = plotList(metricNnn);
        metricN = metricList(metricNnn);
        ffsubplot(4,5,metricNnn)
        
        gpArray = pullGenoPower(Z,genoIX,metricN);
        %[A,genoOrder] = sort(mean(gpArray,2),'descend');
        image(gpArray(genoOrder,:),'CDataMapping','scaled');
        title(['#',num2str(metricNn),': ',metricLabels{metricN}]);
        caxis([-3,3]);   
        set(gca,'XTick',[],'YTick',[]);
        xlabel('Power'); ylabel('Genotype');
    end
    
    
   
    


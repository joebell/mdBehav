function plotCovariance(IX, MI, MIshuff, metricLabels, varargin)

     % [B, IX] = sort(MIshuff(:,1),'descend');
     
     for n=1:length(IX)
         orderedLabels{n} = metricLabels{IX(n)};
     end
  
     ffsubplot(1,3,1:2);
     image(MI(IX,IX),'CDataMapping','scaled');
     title('Sorted by #1');
     set(gca,'YTick',1:40,'YTickLabel',orderedLabels);
     colorbar;
     
     ffsubplot(1,3,3);
     image(MIshuff(IX,IX),'CDataMapping','scaled');
     title('Sorted by #1');
     colorbar;

function plotCovariance(MI, metricLabels, varargin)

     [B, IX] = sort(MI(:,31),'descend');
     
     for n=1:length(IX)
         orderedLabels{n} = metricLabels{IX(n)};
     end
  
     ffsubplot(1,1,1);
     image(MI(IX,IX),'CDataMapping','scaled');
     title('Sorted by #1');
     set(gca,'YTick',1:40,'YTickLabel',orderedLabels);

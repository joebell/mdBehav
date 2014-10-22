function printMetricLabels(metricLabels, varargin)

    if nargin > 1
        labelList = varargin{1};
    else
        labelList = 1:length(metricLabels)
    end

    for Nn=1:length(labelList)
        N = labelList(Nn);
        
        disp([num2str(N,'%02d'),': ',metricLabels{N}]);
        
    end
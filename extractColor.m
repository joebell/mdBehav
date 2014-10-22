function out = extractColor(colorMap, target, cRange)

    nColor = size(colorMap,1);
    binning = linspace(cRange(1),cRange(2),nColor);
    IX = dsearchn(binning(:), target(:));
    out = colorMap(IX,:);
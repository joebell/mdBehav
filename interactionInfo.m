function I = interactionInfo(X, Y, Z, nBins)

    CMI = condMutualInfo(X, Y, Z, nBins);
    MI = mutualInfo(X, Y, nBins);
         
    I = CMI - MI;
    
    [I, CMI, MI]

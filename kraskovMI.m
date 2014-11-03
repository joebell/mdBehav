function MI = kraskovMI(X, Y, k)

    javaaddpath('../../../MItoolbox/infodynamics.jar');
    miCalc=javaObject('infodynamics.measures.continuous.kraskov.MutualInfoCalculatorMultiVariateKraskov1');
    miCalc.initialise();
    miCalc.setProperty('k', num2str(k));
    miCalc.setObservations(X, Y);
    
    MI =  miCalc.computeAverageLocalOfObservations();

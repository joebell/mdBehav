function MI = MIbins(grandMetrics, grandIX)

    Nlist = [16,32,64,128,256,512,1024,2048,4096];
    
    for Nn = 1:length(Nlist)
        nBins = Nlist(Nn);
        
        MI(Nn,:) = measureMI(grandMetrics, grandIX, nBins);
        
    end
    
    image(MI','CDataMapping','scaled');
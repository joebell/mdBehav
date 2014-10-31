function plotCorrelations(grandMetrics, grandIX)

    ix = find(isnan(grandMetrics));
    grandMetrics(ix) = 0;
    Z = zscore(grandMetrics,0,1);
    
    IX1 = 31;
    IX2 = 31;
    nBins = 1024;
    
    nSplits = 1;
    classIX = uniqueTypes(grandIX);
    MI = crossValContMI(grandMetrics(:,IX1),grandMetrics(:,IX2),nBins,classIX,nSplits)
    
    [N, ctrs] = hist3([grandMetrics(:,IX1),grandMetrics(:,IX2)],[nBins nBins]);   
    Pxy = N./sum(N(:));
    Px = sum(N,2)./sum(N(:));
    Py = sum(N,1)./sum(N(:));
        
    subplot(2,2,1);
    margProd = Px*Py;
    Imap = Pxy.*log2(Pxy./(Px*Py));
    image(ctrs{1},ctrs{2},Imap,'CDataMapping','scaled');
    set(gca,'YDir','normal');
    MI = nansum(Imap(:));
    title(['Raw infomap: ',num2str(MI)]); caxis([-.1 1]*10^-3);
    

    uniqueClasses = unique(classIX);
    for classNn = 1:length(uniqueClasses)
        ix = find(classIX == uniqueClasses(classNn));  
        newOrderY = ix(randperm(length(ix)));
        Yshuff(newOrderY) = grandMetrics(ix,IX2);
    end
    
    [N, ctrs] = hist3([grandMetrics(:,IX1),Yshuff(:)],[nBins nBins]);   
    Pxy = N./sum(N(:));
    Px = sum(N,2)./sum(N(:));
    Py = sum(N,1)./sum(N(:));
    
    subplot(2,2,2);
    margProd = Px*Py;
    Imap = Pxy.*log2(Pxy./(Px*Py));
    image(ctrs{1},ctrs{2},Imap,'CDataMapping','scaled');
    set(gca,'YDir','normal');
    MI = nansum(Imap(:));
    title(['Shuffled infomap: ',num2str(MI)]); caxis([-.1 1]*10^-3);
    
    
    


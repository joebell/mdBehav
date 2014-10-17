function plotGrandMetrics()

    load('grandGenoMetrics.mat');
    ix = find(isnan(grandMetrics) | isinf(grandMetrics));
    grandMetrics(ix) = 0;
    
    nDims = 22; perplexity = 30; theta = .6;
    tsneX = fast_tsne(grandMetrics,nDims,perplexity,theta, true);
    [coeff,pcaX] = princomp(grandMetrics);       
    
    powerList = unique(grandIX(:,1));
    genoList  = unique(grandIX(:,3));
    for genoNn = 1:length(genoList)
        genoN = genoList(genoNn);
        
        ix = find(grandIX(:,3) == genoN);
        flyList = unique(grandIX(ix,2));
        
        for flyNn = 1:length(flyList)
            flyN = flyList(flyNn);
            
            for powerNn = 1:8
                powerN = powerList(powerNn);
                
                pix(powerNn) = find((grandIX(:,1) == powerN) &...
                             (grandIX(:,2) == flyN) &...
                             (grandIX(:,3) == genoN) );             
                                
            end     
            subplot(1,2, 1);
            %plot(tsneX(pix,1),tsneX(pix,2),'.-','Color',pretty(genoNn)); hold on;
            scatter(tsneX(pix,1),tsneX(pix,2),'.','MarkerEdgeColor',pretty(genoNn)); hold on;
            %xlim([-75 75]);
            subplot(1,2,2);
            plot(pcaX(pix,1),pcaX(pix,2),'.-','Color',pretty(genoNn)); hold on;
        end
    end
        
    
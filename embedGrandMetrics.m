function embedGrandMetrics()

    %genoList = [13,18,24,75];
    genoList = [1:76];
    load('grandResults.mat');
    
    ix = find(isnan(grandMetrics));
    grandMetrics(ix) = 0;
    
    ix = find(ismember(grandIX(:,3),genoList)); 
    subIX = grandIX(ix,:);
    subMetrics = grandMetrics(ix,:);
    powerList = unique(subIX(:,1));
    
    [subMetrics, subIX] = stratifyByGenotype(subMetrics, subIX);
    

    
    
    Z = zscore(subMetrics,0,1);
     [coeff, score, latent] = princomp(Z);
%     plot(cumsum(latent)./sum(latent));
%     figure
%    score = fast_tsne(Z,20,100,.2,true);
        
    for genoNn = 1:length(genoList)
        genoN = genoList(genoNn);
        row = summaryResults{genoN};
        disp(row{1});
        for powerNn = 1:length(powerList)
            powerN = powerList(powerNn);
            
            ix = find((subIX(:,1) == powerN) & (subIX(:,3) == genoN));
            mean1(powerNn) = nanmean(score(ix,1));
            mean2(powerNn) = nanmean(score(ix,2));
            
            scatter(score(ix,1),score(ix,2),'.','MarkerEdgeColor',pretty(mod(genoNn,8)+1)); hold on;
        end
        
        plot(mean1,mean2,'.-','Color',pretty(mod(genoNn,8)+1));
    end
            
   
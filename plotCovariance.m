function coeff = plotCovariance(grandMetrics, grandIX, metricLabels)

    ix = find(isnan(grandMetrics));
    grandMetrics(ix) = 0;
    
    Z = zscore(grandMetrics,0,1);
    % [coeff, score, latent] = princomp(Z);
    % coeff = corr(Z);
    for metricN1 = 1:40
        metricN1
        parfor metricN2 = 1:40
            metricN2
            coeff(metricN1,metricN2) = contMutualInfo(Z(:,metricN1),Z(:,metricN2),1024);
            nSplits = 4; 
            coeff2(metricN1,metricN2) = crossValMI(Z(:,metricN1), Z(:,metricN2), grandIX, 1024, nSplits);
        end
    end
    
%     for metricN1 = 1:40
%         orderCorr(metricN1) = contMutualInfo(Z(:,metricN1),Z(:,2),1024);
%     end

    orderCorr = coeff(:,31);
    [B,IX] = sort(orderCorr,'descend');

    
    
    % mappedCoeff = compute_mapping(coeff','tSNE',1);
    % [B, IX] = sort(mappedCoeff,'ascend');
    
    for n=1:40
        orderedLabels{n} = metricLabels{IX(n)};
    end
    
    ffsubplot(2,2,1);
    image(coeff(IX,IX),'CDataMapping','scaled');
    ffsubplot(2,2,2);
    image(coeff2(IX,IX),'CDataMapping','scaled');
    ffsubplot(2,2,3);
    image(coeff(IX,IX) - coeff2(IX,IX),'CDataMapping','scaled');
    %title('Mutual information, sorted by MI with decPI');
    %set(gca,'YTick',1:40,'YTickLabel',orderedLabels);

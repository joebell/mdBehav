function MIcoeffDiffs(coeff2)

 [B,IX] = sort(coeff2(:,31),'descend');
 MI = coeff2(IX,IX);
 
 for ix1 = 1:size(MI,1)
     for ix2 = 1:size(MI,2)
         
         MID(ix1,ix2) = MI(ix1,ix2) - MI(max([ix1 ix2]),max([ix1 ix2]));
         
     end
 end
 
 subplot(1,2,1);
 image(MI,'CDataMapping','scaled');
 
 subplot(1,2,2);
 image(MID,'CDataMapping','scaled');
 
figure;

[V,D] = eig(MI);
diag(D)
plot(real(cumsum(diag(D))./sum(diag(D))),'b.-');
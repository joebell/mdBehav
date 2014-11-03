function assembleMI()

	MItot      = zeros(40,40);
	MIshuffTot = zeros(40,40);

	for metricN1=1:40

		load(['MI4-',num2str(metricN1,'%02d'),'.mat']);
		
		for metricN2 = metricN1:40

			MItot(metricN1,metricN2) = MI(metricN1,metricN2);
			MIshuffTot(metricN1,metricN2) = MIshuff(metricN1,metricN2);
			MItot(metricN2,metricN1) = MI(metricN1,metricN2);
			MIshuffTot(metricN2,metricN1) = MIshuff(metricN1,metricN2);

		end
	end

	MI = MItot;
	MIshuff = MIshuffTot;

	save('MI4-kraskov.mat','MI','MIshuff');

	[B,IX] = sort(MIshuff(:,2),'descend');
	IX

	ffsubplot(1,2,1);
	image(MItot(IX,IX),'CDataMapping','scaled');

	ffsubplot(1,2,2);
	image(MIshuff(IX,IX),'CDataMapping','scaled');





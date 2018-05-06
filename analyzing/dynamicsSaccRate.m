% dymanicsSaccRate

subjects= {'SM','LS','LB','RW','AS', 'ALL' };
figure(10)


saccRate_byType={};
for type=1:4%1:4 for 3c
    ALLsub_saccRates=[];
    for sub_i=1:length(subjects)
        saccRates=nan(size(1,50));
        sub=subjects(sub_i);
        sub=sub{1,1};
        if strcmp(sub, 'ALL')==0
            if type==1
                load(['C:\Users\bnapp\Documents\tunnelledVisionPaper\analyzing\resultsVectors\' sub '\allShapeBAnalogallSessionallTrialcAnswer.mat']);
                subFig_num=sub_i;
                color='b';
                textY=0.7;
            else
                if type==2
                    load(['C:\Users\bnapp\Documents\tunnelledVisionPaper\analyzing\resultsVectors\' sub '\allShapeSAnalogallSessionallTrialcAnswer.mat']);
                    subFig_num=sub_i+6;
                    color='m';
                    textY=0.9;
                end
            end
            if type==3
                load(['C:\Users\bnapp\Documents\tunnelledVisionPaper\analyzing\resultsVectors\' sub '\allShapeNBAnalogallSessionallTrialcAnswer.mat']);
                subFig_num=sub_i;
                color='b';
                textY=0.7;
            else
                if type==4
                    load(['C:\Users\bnapp\Documents\tunnelledVisionPaper\analyzing\resultsVectors\' sub '\allShapeNSAnalogallSessionallTrialcAnswer.mat']);
                    subFig_num=sub_i+6;
                    color='m';
                    textY=0.9;
                end
            end
            numOftrials=length(labeled_saccade_vecs);
            relt=0;
            for t=1:numOftrials
                saccRate=nan(1,60);
                labeled_saccade_vec=labeled_saccade_vecs{1,t};
                if size(labeled_saccade_vec,2)>2 
                    XY_vec_deg=XY_vecs_deg{1,t};
                    trialLength=size(XY_vec_deg,2); 
                    if trialLength>290
                        relt=relt+1;
                        bin=100; % 100*10 ms =1 sec
                        bins=0:bin:floor(trialLength);
                        for i=1:size(bins,2)-1
                            temp1=find(labeled_saccade_vec(1,:)>bins(i));
                            temp2=find(labeled_saccade_vec(1,:)<bins(i+1));
                            saccRate(i)=size(intersect(temp1,temp2),2); 
                        end
                        saccRates(relt,1:size(saccRate,2))=saccRate;
                    end
                end
            end
            saccRate_bySub{type,sub_i}=saccRates;
            ALLsub_saccRates=[ALLsub_saccRates ; saccRates];
        else
            saccRate_bySub{type,sub_i}=ALLsub_saccRates;
            if type==1 || type==3
                subFig_num=sub_i;
                color='b';
                textY=0.7;
            else
                if type==2 || type==4
                    subFig_num=sub_i+6;
                    color='m';
                    textY=0.9;
                end
            end
            
        end

    end
saccRate_byType{1,type}=ALLsub_saccRates;
end

colors=['b', 'm', 'k','k'];
figure(10)
fig=0;
for type=1:4%1:4 for 3c
    for sub_i=1:length(subjects)
        fig=fig+1;
        subplot(4,6,fig)
        for i=1:size(saccRate_bySub{type,sub_i},1)
        plot(saccRate_bySub{type,sub_i}(i,:))
        hold all
        end
        plot(nanmean(saccRate_bySub{type,sub_i}),colors(type),'LineWidth',1)
        errorbar(nanmean(saccRate_bySub{type,sub_i}),nanstd(saccRate_bySub{type,sub_i})/sqrt(size(saccRate_bySub{type,sub_i},1)),colors(type),'LineWidth',3)
        title(subjects(sub_i))
        axis([1 3 0 15])
    end
end
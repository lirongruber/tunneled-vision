% convergence of velocity and var of velocity - PER SUBJECT 100+300

subjects={'SM','LS','LB','RW','AS'};
windowAvSize_forMean=2;%1
windowAvSize_forStd=5;%3
figure(333)
set(gcf,'units','normalized','outerposition',[0 0 1 1])

for type=1:4
    allSub_MeanVel=nan(1,300);%[];
    allSub_durDrift=[];
    allSub_MeanVar=nan(1,300);%[];
    
    if type==1
        color='k';
    else
        if type==2
            color='b';
        else
            if type==3
                color='r';
            else
                if type==4
                    color='m';
                end
            end
        end
    end
    
    for sub_i=1:length(subjects)
        MeanVel=[];
        MeanVar=[];
        durDrift=[];
        sub=subjects(sub_i);
        sub=sub{1,1};
        if type==1
            load(['C:\Users\bnapp\Documents\tunnelledVisionPaper\analyzing\resultsVectors_forXY\' sub '\allShapeNBAnalogallSessionallTrialcAnswer.mat']);
        else
            if type==2
                load(['C:\Users\bnapp\Documents\tunnelledVisionPaper\analyzing\resultsVectors_forXY\' sub '\allShapeBAnalogallSessionallTrialcAnswer.mat']);
            else
                if type==3
                    load(['C:\Users\bnapp\Documents\tunnelledVisionPaper\analyzing\resultsVectors_forXY\' sub '\allShapeNSAnalogallSessionallTrialcAnswer.mat']);
                else
                    if type==4
                        load(['C:\Users\bnapp\Documents\tunnelledVisionPaper\analyzing\resultsVectors_forXY\' sub '\allShapeSAnalogallSessionallTrialcAnswer.mat']);
                    end
                end
            end
        end
        relD=0;
        relT=0;
        
        for t=1:length(labeled_saccade_vecs)
            labeled_saccade_vec=labeled_saccade_vecs{1,t};
            XY_vec_deg=XY_vecs_deg{1,t};
            
            for i =1:size(labeled_saccade_vec,2)-1
                temp=(XY_vec_deg(:,((labeled_saccade_vec(1,i)+labeled_saccade_vec(2,i)):labeled_saccade_vec(1,i+1)))');
                if length(temp)>10 && size(labeled_saccade_vec,2)>2
                    currAmp=[];
                    for j=2:length(temp)
                        currAmp(j-1) = sqrt((temp(j,1)-temp(j-1,1))^2+(temp(j,2)-temp(j-1,2))^2);
                    end
                    if isempty(find(currAmp==0)) && sum(currAmp)<10
                        relD=relD+1;
                        %for any given drift
                        M=movmean(currAmp.*100,windowAvSize_forMean);
                        V=movvar(currAmp.*100,windowAvSize_forStd);
                        
%                         M=M(1:10);
%                         V=V(1:10);
                        
                        MeanVel(relD,1:length(M))=M;%(1:10);
                        durDrift(relD)=length(M);
                        MeanVar(relD,1:length(M))=V;%(1:10);
                    end
                    
                end
            end
        end
        MeanVel(MeanVel==0)=nan;
        MeanVel=[MeanVel nan(size(MeanVel,1), 300-size(MeanVel,2))];
        durDrift(durDrift==0)=nan;
        MeanVar(MeanVar==0)=nan;
        MeanVar=[MeanVar nan(size(MeanVar,1), 300-size(MeanVar,2))];
        
        allSub_MeanVel=[allSub_MeanVel; MeanVel(:,1:min(length(MeanVel),300))];
        allSub_MeanVar=[allSub_MeanVar ; MeanVar(:,1:min(length(MeanVar),300))];
        
        
        axes(ha333(sub_i));
        
        %         subplot(2,6,sub_i)
        errorbar(10:10:10*size(MeanVel,2),nanmean(MeanVel),nanstd(MeanVel)./sqrt(size(MeanVel,1)-sum(isnan(MeanVel))),'color',color)
        hold on
        axis([0 110 0 11])
        title(sub,'FontSize', 25)
        xlabel('ms','FontSize', 20)
        ylabel('Velocity [deg/sec]','FontSize', 20)
        set(gca,'box','off')
        
        axes(ha333(sub_i+6));
        %         %         subplot(2,6,sub_i+6)
        %         errorbar(10:10:10*size(MeanVar,2),nanmean(MeanVar),nanstd(MeanVar)./sqrt(size(MeanVar,1)-sum(isnan(MeanVar))),'color',color)
        %         hold on
        %         axis([0 310 0 40])
        %         xlabel('ms')
        %         ylabel('VAR(vel)')
        %         set(gca,'box','off')
        
        errorbar(10:10:10*size(MeanVel,2),nanmean(MeanVel),nanstd(MeanVel)./sqrt(size(MeanVel,1)-sum(isnan(MeanVel))),'color',color)
        hold on
        axis([0 400 0 11])
        title('')
        xlabel('ms','FontSize', 20)
        ylabel('Velocity [deg/sec]','FontSize', 20)
        set(gca,'box','off')
        
    end
    
    axes(ha333(6));
    %     subplot(2,6,6)
    errorbar(10:10:10*size(allSub_MeanVel,2),nanmean(allSub_MeanVel),nanstd(allSub_MeanVel)./sqrt(size(allSub_MeanVel,1)-sum(isnan(allSub_MeanVel))),'color',color)
    hold on
    axis([0 110 0 11])
    title('ALL','FontSize', 25)
    xlabel('ms','FontSize', 20)
    ylabel('Velocity [deg/sec]','FontSize', 20)
    set(gca,'box','off')
    
    axes(ha333(12));
%     %  subplot(2,6,12)
%     errorbar(10:10:10*size(allSub_MeanVar,2),nanmean(allSub_MeanVar),nanstd(allSub_MeanVar)./sqrt(size(allSub_MeanVar,1)-sum(isnan(allSub_MeanVar))),'color',color)
%     hold on
%     axis([0 310 0 40])
%     xlabel('ms')
%     ylabel('VAR(vel)')
%     set(gca,'box','off')
    
        errorbar(10:10:10*size(allSub_MeanVel,2),nanmean(allSub_MeanVel),nanstd(allSub_MeanVel)./sqrt(size(allSub_MeanVel,1)-sum(isnan(allSub_MeanVel))),'color',color)
    hold on
        axis([0 400 0 11])
    title('')
    xlabel('ms','FontSize', 20)
    ylabel('Velocity [deg/sec]','FontSize', 20)
    set(gca,'box','off')
end
leg=legend('Natural Large','Tunneled Large','Natural Small','Tunneled Small');
set(leg,'FontSize', 15,'Position',[0.8890    0.8263    0.0556    0.0551]);
legend boxoff

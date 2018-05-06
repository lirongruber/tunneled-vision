% convergence of velocity and var of velocity - borders not borders!!!!!!!!

% NOT SEPERATING HORIZONTAL AND VERTICAL
% clear
% close all
subjects={'SM','LS','LB','RW','AS'};
windowAvSize_forMean=2;%1
windowAvSize_forStd=5;%3

c2=[0 .45 .7];%'c';
c2=[.8 .4 0];%'m';
c3=[.8 .6 .7];%'k';

figure(300)
set(gcf,'units','normalized','outerposition',[0 0 1 1])

for type=1:4
    allSub_MeanVel=nan(1,300);%[];
    allSub_durDrift=[];
    allSub_MeanVar=nan(1,300);%[];
    
    allSub_MeanVel_B=nan(1,300);%[];
    allSub_durDrift_B=[];
    allSub_MeanVar_B=nan(1,300);%[];
    
    if type==1
        color='k';
    else
        if type==2
            color='b';
        else
            if type==3
                color='k';
            else
                if type==4
                    color='m';
                end
            end
        end
    end
    
    %     AllTsignAmpCorr=[];
    
    for sub_i=1:length(subjects)
        MeanVel=[];
        MeanVar=[];
        durDrift=[];
        MeanVel_B=[];
        MeanVar_B=[];
        durDrift_B=[];
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
        relD_B=0;
        
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
                        %for any given drift
                        M=movmean(currAmp.*100,windowAvSize_forMean);
                        V=movvar(currAmp.*100,windowAvSize_forStd);
                        
                        %                         M=M(1:10);
                        %                         V=V(1:10);
                        flag=labeled_saccade_vec(9,i);
                        if flag==1
                            relD_B=relD_B+1;
                            MeanVel_B(relD_B,1:length(M))=M;%(1:10);
                            durDrift_B(relD_B)=length(M);
                            MeanVar_B(relD_B,1:length(M))=V;%(1:10);
                        else
                            relD=relD+1;
                            MeanVel(relD,1:length(M))=M;%(1:10);
                            durDrift(relD)=length(M);
                            MeanVar(relD,1:length(M))=V;%(1:10);
                        end
                    end
                    
                end
            end
        end
        
        MeanVel(MeanVel==0)=nan;
        MeanVel=[MeanVel nan(size(MeanVel,1), 300-size(MeanVel,2))];
        durDrift(durDrift==0)=nan;
        MeanVar(MeanVar==0)=nan;
        MeanVar=[MeanVar nan(size(MeanVar,1), 300-size(MeanVar,2))];
        
        MeanVel_B(MeanVel_B==0)=nan;
        MeanVel_B=[MeanVel_B nan(size(MeanVel_B,1), 300-size(MeanVel_B,2))];
        durDrift_B(durDrift_B==0)=nan;
        MeanVar_B(MeanVar_B==0)=nan;
        MeanVar_B=[MeanVar_B nan(size(MeanVar_B,1), 300-size(MeanVar_B,2))];
        
        allSub_MeanVel=[allSub_MeanVel; MeanVel(:,1:min(length(MeanVel),300))];
        allSub_MeanVar=[allSub_MeanVar ; MeanVar(:,1:min(length(MeanVar),300))];
        
        allSub_MeanVel_B=[allSub_MeanVel_B; MeanVel_B(:,1:min(length(MeanVel_B),300))];
        allSub_MeanVar_B=[allSub_MeanVar_B ; MeanVar_B(:,1:min(length(MeanVar_B),300))];
        
        
        %         figure(type+5)
        %         subplot(2,6,sub_i)
        %         subplot(2,6,6)
        %
        figure(300)
        axes(ha300(type));
        if type==1
            figure(30)
            axes(ha30(3));
        end
        if  type==3
            figure(30)
            axes(ha30(4));
        end
        %         subplot(2,4,type)
        %         errorbar(10:10:10*size(MeanVel,2),nanmean(MeanVel),nanstd(MeanVel)./sqrt(size(MeanVel,1)-sum(isnan(MeanVel))),'color',color)
        %         errorbar(10:10:10*size(MeanVel_B,2),nanmean(MeanVel_B),nanstd(MeanVel_B)./sqrt(size(MeanVel_B,1)-sum(isnan(MeanVel_B))),'color','g')
        
        p2=plot(10:10:10*size(MeanVel_B,2),nanmean(MeanVel_B),'color',c2);
        hold on

        p1=plot(10:10:10*size(MeanVel,2),nanmean(MeanVel),'color',color);
        
        p1.Color(4) = 0.3;
        p2.Color(4) = 0.3;
        
        axis([0 10*size(MeanVel,2) 2 11])
        axis([0 100 2 11])
        title('')
        xlabel('Time [ms]','FontSize', 20)
        ylabel('Speed [deg/sec]','FontSize', 20)
            set(gca,'box','off')

        
        axes(ha300(type+4));
        %         subplot(2,4,type+4)
        %         errorbar(10:10:10*size(MeanVel,2),nanmean(MeanVel),nanstd(MeanVel)./sqrt(size(MeanVel,1)-sum(isnan(MeanVel))),'color',color)
        %         errorbar(10:10:10*size(MeanVel_B,2),nanmean(MeanVel_B),nanstd(MeanVel_B)./sqrt(size(MeanVel_B,1)-sum(isnan(MeanVel_B))),'color','g')
        
        p1=plot(10:10:10*size(MeanVel,2),nanmean(MeanVel),'color',color);
        hold on
        p2=plot(10:10:10*size(MeanVel_B,2),nanmean(MeanVel_B),'color',c2);
        p1.Color(4) = 0.3;
        p2.Color(4) = 0.3;
        
        axis([0 10*size(MeanVel,2) 2 11])
        axis([0 300 2 11])
        title('')
        xlabel('Time [ms]','FontSize', 20)
        ylabel('Speed [deg/sec]','FontSize', 20)
            set(gca,'box','off')

        
        
        %         subplot(2,6,sub_i+6)
        %         hold on
        %         errorbar(10:10:10*size(MeanVar,2),nanmean(MeanVar),nanstd(MeanVar)./sqrt(size(MeanVar,1)-sum(isnan(MeanVar))),'color',color)
        %         errorbar(10:10:10*size(MeanVar_B,2),nanmean(MeanVar_B),nanstd(MeanVar_B)./sqrt(size(MeanVar_B,1)-sum(isnan(MeanVar_B))),'color','g')
        %         plot(10:10:10*size(MeanVar,2),nanmean(MeanVar),'color',color)
        %         plot(10:10:10*size(MeanVar_B,2),nanmean(MeanVar_B),'color','g')
        %         % errorbar(10:10:100,mean(MeanVar),ste(MeanVar),'color',color)
        %         axis([0 10*size(MeanVar,2) 1 5.4])
        %         axis([0 100 1 25.4])
        %         xlabel('ms')
        %         ylabel('VAR(vel)')
        %
        %         figure(2)
        %
        %         subplot(2,6,sub_i)
        %         hold on
        %         %         errorbar(10:10:10*size(MeanVel_B,2),nanmean(MeanVel_B),nanstd(MeanVel_B)./sqrt(size(MeanVel_B,1)-sum(isnan(MeanVel_B))),'color',color)
        %         plot(10:10:10*size(MeanVel_B,2),nanmean(MeanVel_B),'color',color)
        %         axis([0 10*size(MeanVel_B,2) 2 11])
        %         axis([0 300 2 11])
        %         title(sub)
        %         xlabel('ms')
        %         ylabel('Velocity Border [deg/sec]')
        %
        %         subplot(2,6,sub_i+6)
        %         hold on
        % %         errorbar(10:10:10*size(MeanVar_B,2),nanmean(MeanVar_B),nanstd(MeanVar_B)./sqrt(size(MeanVar_B,1)-sum(isnan(MeanVar_B))),'color',color)
        %         plot(10:10:10*size(MeanVar_B,2),nanmean(MeanVar_B),'color',color)
        %         %         errorbar(10:10:100,mean(MeanVar),ste(MeanVar),'color',color)
        %         axis([0 10*size(MeanVar_B,2) 1 5.4])
        %         axis([0 300 1 25.4])
        %         xlabel('ms')
        %         ylabel('VAR Border(vel)')
        %
    end
    
    
    %     figure(type+5)
    %     subplot(2,6,6)
    
    figure(300)
    axes(ha300(type));
            if type==1
            figure(30)
            axes(ha30(3));
        end
        if  type==3
            figure(30)
            axes(ha30(4));
        end
    %     subplot(2,4,type)
    errorbar(10:10:10*size(allSub_MeanVel_B,2),nanmean(allSub_MeanVel_B),nanstd(allSub_MeanVel_B)./sqrt(size(allSub_MeanVel_B,1)-sum(isnan(allSub_MeanVel_B))),'color',c2,'LineWidth',2)
    hold on
    errorbar(10:10:10*size(allSub_MeanVel,2),nanmean(allSub_MeanVel),nanstd(allSub_MeanVel)./sqrt(size(allSub_MeanVel,1)-sum(isnan(allSub_MeanVel))),'color',color,'LineWidth',2)
    plot(10:10:10*size(allSub_MeanVel,2),nanmean(allSub_MeanVel),'color',color,'LineWidth',4)
    plot(10:10:10*size(allSub_MeanVel_B,2),nanmean(allSub_MeanVel_B),'color',c2,'LineWidth',4)
    %     errorbar(10:10:100,mean(allSub_MeanVel),ste(allSub_MeanVel),'color',color)
    axis([0 10*size(allSub_MeanVel,2) 2 11])
    axis([0 100 2 11])
    title('')
    xlabel('Time [ms]','FontSize', 20)
    ylabel('Speed [deg/sec]','FontSize', 20)
        set(gca,'box','off')

    
    
    axes(ha300(type+4));
    %     subplot(2,4,type+4)
    errorbar(10:10:10*size(allSub_MeanVel,2),nanmean(allSub_MeanVel),nanstd(allSub_MeanVel)./sqrt(size(allSub_MeanVel,1)-sum(isnan(allSub_MeanVel))),'color',color,'LineWidth',2)
    hold on
    errorbar(10:10:10*size(allSub_MeanVel_B,2),nanmean(allSub_MeanVel_B),nanstd(allSub_MeanVel_B)./sqrt(size(allSub_MeanVel_B,1)-sum(isnan(allSub_MeanVel_B))),'color',c2,'LineWidth',2)
    plot(10:10:10*size(allSub_MeanVel,2),nanmean(allSub_MeanVel),'color',color,'LineWidth',4)
    plot(10:10:10*size(allSub_MeanVel_B,2),nanmean(allSub_MeanVel_B),'color',c2,'LineWidth',4)
    %     errorbar(10:10:100,mean(allSub_MeanVel),ste(allSub_MeanVel),'color',color)
    axis([0 10*size(allSub_MeanVel,2) 2 11])
    axis([0 300 2 11])
    title('')
    xlabel('Time [ms]','FontSize', 20)
    ylabel('Speed [deg/sec]','FontSize', 20)
        set(gca,'box','off')

    %     legend('Not borders','Borders')
    
    
    %     subplot(2,6,12)
    %     hold on
    %     errorbar(10:10:10*size(allSub_MeanVar,2),nanmean(allSub_MeanVar),nanstd(allSub_MeanVar)./sqrt(size(allSub_MeanVar,1)-sum(isnan(allSub_MeanVar))),'color',color)
    %     errorbar(10:10:10*size(allSub_MeanVar_B,2),nanmean(allSub_MeanVar_B),nanstd(allSub_MeanVar_B)./sqrt(size(allSub_MeanVar_B,1)-sum(isnan(allSub_MeanVar_B))),'color','g')
    % plot(10:10:10*size(allSub_MeanVar,2),nanmean(allSub_MeanVar),'color',color)
    %         plot(10:10:10*size(allSub_MeanVar_B,2),nanmean(allSub_MeanVar_B),'color','g')
    %     %     errorbar(10:10:100,mean(allSub_MeanVar),ste(allSub_MeanVar),'color',color)
    %     axis([0 10*size(allSub_MeanVar,2) 1 5.4])
    %     axis([0 100 1 25.4])
    %     xlabel('ms')
    %     ylabel('VAR(vel)')
    %
    %     figure(2)
    %
    %     subplot(2,6,6)
    %     hold on
    %     %     errorbar(10:10:10*size(allSub_MeanVel_B,2),nanmean(allSub_MeanVel_B),nanstd(allSub_MeanVel_B)./sqrt(size(allSub_MeanVel_B,1)-sum(isnan(allSub_MeanVel_B))),'color',color)
    %     plot(10:10:10*size(allSub_MeanVel_B,2),nanmean(allSub_MeanVel_B),'color',color)
    %
    %     %     errorbar(10:10:100,mean(allSub_MeanVel),ste(allSub_MeanVel),'color',color)
    %     axis([0 10*size(allSub_MeanVel_B,2) 2 11])
    %     axis([0 300 2 11])
    %     title('ALL')
    %     xlabel('ms')
    %     ylabel('Velocity Border [deg/sec]')
    %
    %
    %     subplot(2,6,12)
    %     hold on
    %     %     errorbar(10:10:10*size(allSub_MeanVar_B,2),nanmean(allSub_MeanVar_B),nanstd(allSub_MeanVar_B)./sqrt(size(allSub_MeanVar_B,1)-sum(isnan(allSub_MeanVar_B))),'color',color)
    %     plot(10:10:10*size(allSub_MeanVar_B,2),nanmean(allSub_MeanVar_B),'color',color)
    %     %     errorbar(10:10:100,mean(allSub_MeanVar),ste(allSub_MeanVar),'color',color)
    %     axis([0 10*size(allSub_MeanVar_B,2) 1 5.4])
    %     axis([0 300 1 25.4])
    %     xlabel('ms')
    %     ylabel('VAR Border(vel)')
    
end
% legend('Natural Large','Tunneled Large','Natural Small','Tunneled Small')
axes(ha30(3));
leg=legend('Borders','Not borders');
set(leg,'FontSize', 15,'Position',[0.5390    0.8463    0.0626    0.0551]);
legend boxoff

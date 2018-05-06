

subjects= {'SM','LS','LB','RW','AS', 'ALL' };
figure(3)

ratioBorder=[];
var_ratioBorder=[];
ratioNotBorder=[];
var_ratioNotBorder=[];

D_ratioBorder=[];
D_var_ratioBorder=[];
D_ratioNotBorder=[];
D_var_ratioNotBorder=[];
% ratioVer=[];
% ratioHor=[];

for type=1:4%1:4 for 3c
    TrialLength=[]; %ms
    NumOfsacc=[];
    NumOfBorderSacc=[];
    D_NumOfBorderSacc=[];
%     NumOfHorSacc=[];
%     NumOfVerSacc=[];
    for sub_i=1:length(subjects)
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
            trialLength=[]; %ms
            numOfsacc=[];
            
            border=[];
            numOfBorderSacc=[];
            D_border=[];
            D_numOfBorderSacc=[];
            %             hor=[];
            %             numOfHorSacc=[];
            %             ver=[];
            %             numOfVerSacc=[];
            
            for t=1:length(labeled_saccade_vecs)
                labeled_saccade_vec=labeled_saccade_vecs{1,t};
                if size(labeled_saccade_vec,2)>2
                    XY_vec_deg=XY_vecs_deg{1,t};
                    
                    trialLength(t)=size(XY_vec_deg,2)/100; %ms
                    numOfsacc(t)=size(labeled_saccade_vec,2);
                    
                    border=find(labeled_saccade_vec(5,:)==1);
                    numOfBorderSacc(t)=size(border,2);
                    
                    D_border=find(labeled_saccade_vec(9,:)==1);
                    D_numOfBorderSacc(t)=size(D_border,2);
                    %                 hor=find(labeled_saccade_vec(5,:)==2);
                    %                 numOfHorSacc(t)=size(hor,2);
                    %                 ver=find(labeled_saccade_vec(5,:)==3);
                    %                 numOfVerSacc(t)=size(ver,2);
                end
            end
            TrialLength=[TrialLength trialLength]; %ms
            NumOfsacc=[NumOfsacc numOfsacc];
            NumOfBorderSacc=[NumOfBorderSacc numOfBorderSacc];
            D_NumOfBorderSacc=[D_NumOfBorderSacc D_numOfBorderSacc];
            %             NumOfHorSacc=[NumOfHorSacc numOfHorSacc];
%             NumOfVerSacc=[NumOfVerSacc numOfVerSacc];
            
        else
            
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
            
            trialLength=TrialLength; %ms
            numOfsacc=NumOfsacc;
            numOfBorderSacc=NumOfBorderSacc;
            D_numOfBorderSacc=D_NumOfBorderSacc;
%             numOfHorSacc=NumOfHorSacc;
%             numOfVerSacc=NumOfVerSacc;
        end
trialLength=trialLength(trialLength~=0);
        reactionTime(sub_i,type)=mean(trialLength);
        ratioBorder(sub_i,type)=nanmean(numOfBorderSacc./numOfsacc);
        var_ratioBorder(sub_i,type)=nanvar(numOfBorderSacc./numOfsacc);
        
        D_ratioBorder(sub_i,type)=nanmean(D_numOfBorderSacc./numOfsacc);
        D_var_ratioBorder(sub_i,type)=nanvar(D_numOfBorderSacc./numOfsacc);
        
%         ratioVer(sub_i,type)=mean(numOfVerSacc/numOfsacc);
%         var_ratioVer(sub_i,type)=var(numOfVerSacc./numOfsacc);
%         
%         ratioHor(sub_i,type)=mean(numOfHorSacc./numOfsacc);
%         var_ratioHor(sub_i,type)=var(numOfHorSacc./numOfsacc);
        
        ratioNotBorder(sub_i,type)=nanmean((numOfsacc-numOfBorderSacc)./numOfsacc);
        var_ratioNotBorder(sub_i,type)=nanvar((numOfsacc-numOfBorderSacc)./numOfsacc);
        
        D_ratioNotBorder(sub_i,type)=nanmean((numOfsacc-D_numOfBorderSacc)./numOfsacc);
        D_var_ratioNotBorder(sub_i,type)=nanvar((numOfsacc-D_numOfBorderSacc)./numOfsacc);
        
    end
    disp(sum(D_numOfBorderSacc))
    disp(sum(numOfsacc))
end

c1=[0 .45 .7];%'c';
c2=[.8 .4 0];%'m';
c3=[.8 .6 .7];%'k';
figure(3)
set(gcf,'units','normalized','outerposition',[0 0 1 1])
for sub_i=1:6
    axes(ha3(1));
    plot(1,ratioBorder(sub_i,3),'.','color', c1,'MarkerSize',30)
    hold on
    plot(2,ratioBorder(sub_i,1),'.','color', c1,'MarkerSize',30)
    plot(3,ratioBorder(sub_i,4),'.','color', c1,'MarkerSize',30)
    plot(4,ratioBorder(sub_i,2),'.','color', c1,'MarkerSize',30)
    if sub_i==6
        errorbar(1,ratioBorder(sub_i,3),var_ratioBorder(sub_i,3),'vertical','.','color', 'k','MarkerSize',40)
        errorbar(2,ratioBorder(sub_i,1),var_ratioBorder(sub_i,1),'vertical','.','color', 'b','MarkerSize',40)
        errorbar(3,ratioBorder(sub_i,4),var_ratioBorder(sub_i,4),'vertical','.','color', 'k','MarkerSize',40)
        errorbar(4,ratioBorder(sub_i,2),var_ratioBorder(sub_i,2),'vertical','.','color', c1,'MarkerSize',40)
        
        plot(1,ratioBorder(sub_i,3),'.','color', 'k','MarkerSize',60)
        plot(2,ratioBorder(sub_i,1),'.','color', 'b','MarkerSize',60)
        plot(3,ratioBorder(sub_i,4),'.','color', 'k','MarkerSize',60)
        plot(4,ratioBorder(sub_i,2),'.','color', 'm','MarkerSize',60)
    end
    axis([0.5 2.5 0 0.7])
%     xlabel('Natural-large Large Natural-small Small')
    ylabel('Fraction of border saccades','FontSize', 20)
%     title('Border Saccades','FontSize', 25)
    methods={ 'Natural Large','Tunneled Large','Natural Small', 'Tunneled Small'};
    methods={ 'Natural','Tunneled','Natural Small', 'Tunneled Small'};
    set(gca, 'XTick', 1:4, 'XTickLabel', methods,'Fontsize',20);
    set(gca,'XTickLabelRotation',0);
    set(gca,'box','off')
%     axes(ha3(1));
%     plot(ratioBorder(sub_i,3),ratioBorder(sub_i,1),'.','color', c1,'MarkerSize',30)
%     hold on
%     plot(ratioNotBorder(sub_i,3),ratioNotBorder(sub_i,1),'.','color', c2,'MarkerSize',30)
%     if sub_i==6
%         errorbar(ratioBorder(sub_i,3),ratioBorder(sub_i,1),var_ratioBorder(sub_i,3),'horizontal','.','color', c1,'MarkerSize',20)
%         errorbar(ratioBorder(sub_i,3),ratioBorder(sub_i,1),var_ratioBorder(sub_i,1),'vertical','.','color', c1,'MarkerSize',20)
%         
%         errorbar(ratioNotBorder(sub_i,3),ratioNotBorder(sub_i,1),var_ratioNotBorder(sub_i,3),'horizontal','.','color', c2,'MarkerSize',20)
%         errorbar(ratioNotBorder(sub_i,3),ratioNotBorder(sub_i,1),var_ratioNotBorder(sub_i,1),'vertical','.','color', c2,'MarkerSize',20)
%         
%         plot(ratioBorder(sub_i,3),ratioBorder(sub_i,1),'.','color', 'b','MarkerSize',40)
%         plot(ratioNotBorder(sub_i,3),ratioNotBorder(sub_i,1),'.','color', [1 .4 0],'MarkerSize',40)
%     end
%     axis([0 1 0 1])
%     plot([0,1],[0,1],'--k')
%     xlabel('Natural Large','FontSize', 20)
%     if sub_i==1
%         ylabel('Tunneled Large','FontSize', 20)
%     end
%     if sub_i==6
%         title('Types of Sacacdes','FontSize', 25)
%         leg=legend('border','Not border');
%         set(leg,'FontSize', 15,'Position',[0.1090    0.8263    0.0626    0.0551]);
%         legend boxoff
%     else
%         title(subjects{1,sub_i},'FontSize', 25)
%     end
%     set(gca,'box','off')
    
%     axes(ha3(4));
%     plot(ratioBorder(sub_i,4),ratioBorder(sub_i,2),'.','color', c1,'MarkerSize',30)
%     hold on
%     plot(ratioNotBorder(sub_i,4),ratioNotBorder(sub_i,2),'.','color', c2,'MarkerSize',30)
%     if sub_i==6
%         errorbar(ratioBorder(sub_i,4),ratioBorder(sub_i,2),var_ratioBorder(sub_i,4),'horizontal','.','color', c1,'MarkerSize',20)
%         errorbar(ratioBorder(sub_i,4),ratioBorder(sub_i,2),var_ratioBorder(sub_i,2),'vertical','.','color', c1,'MarkerSize',20)
%         
%         errorbar(ratioNotBorder(sub_i,4),ratioNotBorder(sub_i,2),var_ratioNotBorder(sub_i,4),'horizontal','.','color', c2,'MarkerSize',20)
%         errorbar(ratioNotBorder(sub_i,4),ratioNotBorder(sub_i,2),var_ratioNotBorder(sub_i,2),'vertical','.','color', c2,'MarkerSize',20)
%         
%         plot(ratioBorder(sub_i,4),ratioBorder(sub_i,2),'.','color', 'b','MarkerSize',40)
%         plot(ratioNotBorder(sub_i,4),ratioNotBorder(sub_i,2),'.','color', [1 .4 0],'MarkerSize',40)
%     end
%     
%     axis([0 1 0 1])
%     plot([0,1],[0,1],'--k')
%     xlabel('Natural Small','FontSize', 20)
%     if sub_i==1
%         ylabel('Tunneled Small','FontSize', 20)
%     end
%     if sub_i==6
%         title('','FontSize', 25)
%     else
%     end
%     set(gca,'box','off')
    
%     axes(ha3(2));
%     plot(D_ratioBorder(sub_i,3),D_ratioBorder(sub_i,1),'.','color', c1,'MarkerSize',30)
%     hold on
%     plot(D_ratioNotBorder(sub_i,3),D_ratioNotBorder(sub_i,1),'.','color', c2,'MarkerSize',30)
%     if sub_i==6
%         errorbar(D_ratioBorder(sub_i,3),D_ratioBorder(sub_i,1),D_var_ratioBorder(sub_i,3),'horizontal','.','color', c1,'MarkerSize',20)
%         errorbar(D_ratioBorder(sub_i,3),D_ratioBorder(sub_i,1),D_var_ratioBorder(sub_i,1),'vertical','.','color', c1,'MarkerSize',20)
%         
%         errorbar(D_ratioNotBorder(sub_i,3),D_ratioNotBorder(sub_i,1),D_var_ratioNotBorder(sub_i,3),'horizontal','.','color', c2,'MarkerSize',20)
%         errorbar(D_ratioNotBorder(sub_i,3),D_ratioNotBorder(sub_i,1),D_var_ratioNotBorder(sub_i,1),'vertical','.','color', c2,'MarkerSize',20)
%         
%         plot(D_ratioBorder(sub_i,3),D_ratioBorder(sub_i,1),'.','color', 'b','MarkerSize',40)
%         plot(D_ratioNotBorder(sub_i,3),D_ratioNotBorder(sub_i,1),'.','color', [1 .4 0],'MarkerSize',40)
%     end
%     axis([0 1 0 1])
%     plot([0,1],[0,1],'--k')
%     xlabel('Natural','FontSize', 20)
%     if sub_i==1
%         ylabel('Tunneled','FontSize', 20)
%     end
%     if sub_i==6
%         title('Types of Drift : Large','FontSize', 25)
%     else
%         title(subjects{1,sub_i},'FontSize', 25)
%     end
%     set(gca,'box','off')
%     
%     axes(ha3(5));
%     plot(D_ratioBorder(sub_i,4),D_ratioBorder(sub_i,2),'.','color', c1,'MarkerSize',30)
%     hold on
%     plot(D_ratioNotBorder(sub_i,4),D_ratioNotBorder(sub_i,2),'.','color', c2,'MarkerSize',30)
%     if sub_i==6
%         errorbar(D_ratioBorder(sub_i,4),D_ratioBorder(sub_i,2),D_var_ratioBorder(sub_i,4),'horizontal','.','color', c1,'MarkerSize',20)
%         errorbar(D_ratioBorder(sub_i,4),D_ratioBorder(sub_i,2),D_var_ratioBorder(sub_i,2),'vertical','.','color', c1,'MarkerSize',20)
%         
%         errorbar(D_ratioNotBorder(sub_i,4),D_ratioNotBorder(sub_i,2),D_var_ratioNotBorder(sub_i,4),'horizontal','.','color', c2,'MarkerSize',20)
%         errorbar(D_ratioNotBorder(sub_i,4),D_ratioNotBorder(sub_i,2),D_var_ratioNotBorder(sub_i,2),'vertical','.','color', c2,'MarkerSize',20)
%         
%         plot(D_ratioBorder(sub_i,4),D_ratioBorder(sub_i,2),'.','color', 'b','MarkerSize',40)
%         plot(D_ratioNotBorder(sub_i,4),D_ratioNotBorder(sub_i,2),'.','color', [1 .4 0],'MarkerSize',40)
%     end
%     
%     axis([0 1 0 1])
%     plot([0,1],[0,1],'--k')
%     xlabel('Natural','FontSize', 20)
%     if sub_i==1
%         ylabel('Tunneled','FontSize', 20)
%     end
%     if sub_i==6
%         title('Small','FontSize', 25)
%     else
%     end
%     set(gca,'box','off')
end

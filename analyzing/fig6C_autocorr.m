% NOT SEPERATING HORIZONTAL AND VERTICAL
clear
corrLags=40;
subjects= {'SM','LS','LB','RW','AS'};

for type=4:-1:1
    
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
    
    AllTsignAmpCorr=[];
    %     AllTsignAmpCorrY=[];
    AllTsignDistCorr=[];
    %     AllTsignDistCorrY=[];
    
    for sub_i=1:length(subjects)
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
        signAmpCorr=zeros(1,corrLags*2+1);
        signDistCorr=zeros(1,corrLags*2+1);
        %
        %         relDY=0;
        %         relTY=0;
        %         signAmpCorrY=zeros(1,corrLags*2+1);
        %         signDistCorrY=zeros(1,corrLags*2+1);
        
        for t=1:length(labeled_saccade_vecs)
            labeled_saccade_vec=labeled_saccade_vecs{1,t};
            XY_vec_deg=XY_vecs_deg{1,t};
            
            ampsPerTrial=[];
            distsPerTrial=[];
            %             ampsPerTrialY=[];
            %             distsPerTrialY=[];
            %
            for i =1:size(labeled_saccade_vec,2)-1
                %                 tempX=(XY_vec_deg(1,((labeled_saccade_vec(1,i)+labeled_saccade_vec(2,i)):labeled_saccade_vec(1,i+1)))');
                %                 tempY=(XY_vec_deg(2,((labeled_saccade_vec(1,i)+labeled_saccade_vec(2,i)):labeled_saccade_vec(1,i+1)))');
                temp=(XY_vec_deg(:,((labeled_saccade_vec(1,i)+labeled_saccade_vec(2,i)):labeled_saccade_vec(1,i+1)))');
                
                if length(temp)>10 && size(labeled_saccade_vec,2)>2
                    relD=relD+1;
                    currAmp=[];
                    currDist=[];
                    for j=2:length(temp)
                        %                         currAmp(j-1) = tempX(j)-tempX(j-1);
                        %                         currDist(j-1)=tempX(j)-tempX(1);
                        currAmp(j-1) = sqrt((temp(j,1)-temp(j-1,1))^2+(temp(j,2)-temp(j-1,2))^2);
                        currDist(j-1)=sqrt((temp(j,1)-temp(1,1))^2+(temp(j,2)-temp(1,2))^2);
                    end
                    %for any given drift
                    ampsPerTrial=[ampsPerTrial currAmp];
                    distsPerTrial=[distsPerTrial currDist];
                end
                %                 if length(tempY)>10 && size(labeled_saccade_vec,2)>2
                %                     relDY=relDY+1;
                %                     currAmp=[];
                %                     currDist=[];
                %                     for j=2:length(tempY)
                %                         currAmp(j-1) = tempY(j)-tempY(j-1);
                %                         currDist(j-1)=tempY(j)-tempY(1);
                %                     end
                %                     %for any given drift
                %                     ampsPerTrialY=[ampsPerTrialY currAmp];
                %                     distsPerTrialY=[distsPerTrialY currDist];
                %                 end
                
            end
            if ~isempty(ampsPerTrial)
                relT=relT+1;
                [xcf_amp,lags_amp,bounds_amp]=crosscorr(ampsPerTrial,ampsPerTrial,min(corrLags,length(ampsPerTrial)-1));
                [xcf_dist,lags_dist,bounds_dist]=crosscorr(distsPerTrial,distsPerTrial,min(corrLags,length(distsPerTrial)-1));
                for l=-corrLags:1:corrLags
                    if max(lags_amp==l)>0
                        if xcf_amp(lags_amp==l)>bounds_amp(1) || xcf_amp(lags_amp==l)<bounds_amp(2)
                            signAmpCorr(relT,l+corrLags+1)=xcf_amp(lags_amp==l);
                        end
                        if xcf_dist(lags_dist==l)>bounds_dist(1) || xcf_dist(lags_dist==l)<bounds_dist(2)
                            signDistCorr(relT,l+corrLags+1)=xcf_dist(lags_dist==l);
                        end
                    end
                end
            end
            %             if ~isempty(ampsPerTrialY)
            %                 relTY=relTY+1;
            %                 [xcf_amp,lags_amp,bounds_amp]=crosscorr(ampsPerTrialY,ampsPerTrialY,min(corrLags,length(ampsPerTrialY)-1));
            %                 [xcf_dist,lags_dist,bounds_dist]=crosscorr(distsPerTrialY,distsPerTrialY,min(corrLags,length(distsPerTrialY)-1));
            %                 for l=-corrLags:1:corrLags
            %                     if max(lags_amp==l)>0
            %                         if xcf_amp(lags_amp==l)>bounds_amp(1) || xcf_amp(lags_amp==l)<bounds_amp(2)
            %                             signAmpCorrY(relTY,l+corrLags+1)=xcf_amp(lags_amp==l);
            %                         end
            %                         if xcf_dist(lags_dist==l)>bounds_dist(1) || xcf_dist(lags_dist==l)<bounds_dist(2)
            %                             signDistCorrY(relTY,l+corrLags+1)=xcf_dist(lags_dist==l);
            %                         end
            %                     end
            %                 end
            %             end
            
        end
        
        
        AllTsignAmpCorr = [AllTsignAmpCorr ; signAmpCorr];
        %         AllTsignAmpCorrY = [AllTsignAmpCorrY ; signAmpCorrY];
        AllTsignDistCorr = [AllTsignDistCorr ; signDistCorr];
        %         AllTsignDistCorrY = [AllTsignDistCorrY ; signDistCorrY];
        
    end
    
    signAmpCorr = AllTsignAmpCorr ;
    %     signAmpCorrY = AllTsignAmpCorrY ;
    signDistCorr = AllTsignDistCorr ;
    %     signDistCorrY = AllTsignDistCorrY ;
    
    figure(62)
    set(gcf,'units','normalized','outerposition',[0 0 1 1])
    figure(61)
    set(gcf,'units','normalized','outerposition',[0 0 1 1])
    
    if type==1 figure(62); figN=5; end
    if type==3 figure(62); figN=6; end
    
    if type==2 figure(61); figN=5; end
    if type==4 figure(61); figN=6; end
    
    subplot(2,4,figN)
    signAmpCorr(signAmpCorr>0.5)=0.5;
    imagesc(signAmpCorr(:,corrLags+1:end),[-1 1])
    colormap('jet')
    caxis([-0.5 0.5])
    colorbar
    if figN==5
        ylabel('trials','FontSize',20)
    end
    xlabel('time lags [ms]','FontSize',20)
    axis([1 25 0 size(signAmpCorr,1)])
    xticks(6:5:25);
    xticklabels({'50','100','150','200','250'});
    GAP=round(size(signAmpCorr,1)/5);
    yticks(10:GAP:size(signAmpCorr,1));
    yticklabels({'SM','LS','LB','RW','AS'});
    NEW=signAmpCorr(:,corrLags+1:end);
    temp1=find(NEW(:,11)>0);
    temp2=find(NEW(:,11)>NEW(:,10));
    temp3=find(NEW(:,11)>NEW(:,12));
    tempint=intersect(temp1,temp2);
    tempint=intersect(tempint,temp3);
    numberOfPer100=size(tempint,1)/size(signAmpCorr,1)*100;
    title(['100ms periodic trials=' num2str(round(numberOfPer100)) '\%'],'FontSize',20)
    
    
    %     if type==1 figure(62); figN=7; end
    %     if type==3 figure(62); figN=8; end
    %
    %     if type==2 figure(61); figN=7; end
    %     if type==4 figure(61); figN=8; end
    %
    %     subplot(2,4,figN)
    %     imagesc(signAmpCorrY(:,corrLags+1:end),[-1 1])
    %     colormap('jet')
    %     caxis([-0.5 0.5])
    %     colorbar
    %     xlabel('time lags [ms]','FontSize',20)
    %     axis([1 25 0 size(signAmpCorrY,1)])
    %     xticks(6:5:25);
    %     xticklabels({'50','100','150','200','250'});
    %     GAP=round(size(signAmpCorrY,1)/5);
    %     yticks(10:GAP:size(signAmpCorrY,1));
    %     yticklabels({'SM','LS','LB','RW','AS'});
    %     NEW=signAmpCorrY(:,corrLags+1:end);
    %     temp1=find(NEW(:,11)>0);
    %     temp2=find(NEW(:,11)>NEW(:,10));
    %     temp3=find(NEW(:,11)>NEW(:,12));
    %     tempint=intersect(temp1,temp2);
    %     tempint=intersect(tempint,temp3);
    %     numberOfPer100=size(tempint,1)/size(signAmpCorrY,1)*100;
    %     title(['100ms periodic trials=' num2str(round(numberOfPer100)) '\%'],'FontSize',20)
    
    
    if type==1 figure(62); figN=5; end
    if type==3 figure(62); figN=6; end
    
    if type==2 figure(61); figN=5; end
    if type==4 figure(61); figN=6; end
    
    subplot(4,4,figN)
    hold on
    NEW=signAmpCorr;
    sumX=sum(NEW);
    bar(10:10:corrLags*10,sumX(corrLags+2:end)./size(NEW,1),color,'FaceAlpha',0.5);
    xticks(0:50:corrLags*10-1)
    if figN==5
        ylabel({' sum of';'sign corr'},'FontSize',20)
    end
    axis([0 270 -0.02 0.091])
    if figN==5
        title({'Inst Velocity - LARGE'},'FontSize',25)
        figure(61); title('');
    end
    if figN==6
        title('SMALL','FontSize',25)
        figure(61); title('');
    end
    
    %     if type==1 figure(62); figN=7; end
    %     if type==3 figure(62); figN=8; end
    %
    %     if type==2 figure(61); figN=7; end
    %     if type==4 figure(61); figN=8; end
    %
    %     subplot(4,4,figN)
    %     hold on
    %     NEW=signAmpCorrY;
    %     sumY=sum(NEW);
    %     bar(10:10:corrLags*10,sumY(corrLags+2:end)./size(NEW,1),color,'FaceAlpha',0.5);
    %     xticks(0:50:corrLags*10-1)
    %     axis([0 270 -0.02 0.091])
    %     if figN==7
    %         title({'Vertical' 'Inst Velocity - LARGE'},'FontSize',25)
    %         figure(61); title('');
    %     end
    %     if figN==8
    %         title('SMALL','FontSize',25)
    %         figure(61); title('');
    %     end
    %
    figure(63)
    set(gcf,'units','normalized','outerposition',[0 0 1 1])
    if type==1 || type==2
        subplot(4,4,13)
        title('Travelled Dist - LARGE','FontSize',25)
        ylabel({' sum of';'sign corr'})
    else
        ylabel('')
    end
    if type==3 || type==4
        subplot(4,4,14)
        title('SMALL','FontSize',25)
    end
    hold on
    NEW=signDistCorr;
    sumX=sum(NEW);
    plot(10:10:corrLags*10,sumX(corrLags+2:end)./size(NEW,1),[color '.']);
    f=fit((10:10:corrLags*10)',(sumX(corrLags+2:end)./size(NEW,1))','exp1');
    hold on
    plot(f,color);
    if type==1 || type==2
        subplot(4,4,13)
        ylabel({' sum of';'sign corr'},'FontSize',20)
    else
        ylabel('')
    end
    legend('off')
    
    if type==1 || type==3
        text(150,0.8,['Tau decay=' num2str(10*round(1/-round(f.b*10,2)))  'ms'],'color',color,'FontSize',20)
    else
        text(150,0.6,['Tau decay=' num2str(10*round(1/-round(f.b*10,2)))  'ms'],'color',color,'FontSize',20);
    end
    xticks(0:100:corrLags*10-1)
    xlabel('')
    axis([0 350 0 1])
    
    %     if type==1 || type==2
    %         subplot(4,4,15)
    %         title('Travelled Dist - LARGE','FontSize',25)
    %     end
    %     if type==3 || type==4
    %         subplot(4,4,16)
    %         title('SMALL','FontSize',25)
    %     end
    %     hold on
    %     NEW=signDistCorrY;
    %     sumY=sum(NEW);
    %     plot(10:10:corrLags*10,sumY(corrLags+2:end)./size(NEW,1),[color '.']);
    %     f=fit((10:10:corrLags*10)',(sumY(corrLags+2:end)./size(NEW,1))','exp1');
    %     hold on
    %     plot(f,color);
    %     legend('off')
    %     if type==1 || type==3
    %         text(150,0.8,['Tau decay=' num2str(10*round(1/-round(f.b*10,2)))  'ms'],'color',color,'FontSize',20)
    %     else
    %         text(150,0.6,['Tau decay=' num2str(10*round(1/-round(f.b*10,2)))  'ms'],'color',color,'FontSize',20)
    %     end
    %     xticks(0:100:corrLags*10-1)
    %     xlabel('')
    %     ylabel('')
    %     axis([0 350 0 1])
    
end

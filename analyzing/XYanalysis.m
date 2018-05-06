% XY seperatly : velocities +amps
%figs:
% 1 histogram drift vel (X and Y, big & small)
% 2 drift vel/amp vs duration in dots - X
% 3 drift vel/amp vs duration in dots - Y
%%%%% no use%%%%%%%%%%%%%%%%%%%%% 4+41 (X&Y) auto correlation per drift (time,vel,amp) - big&small
% 5+51 X (big&small) auto correlation inside drift CONCAT per trial (amp,dist,amp-dist) 
% 6+61 X (big&small) auto correlation inside drift (amp,dist,amp-dist) - big
% 7+71 Y (big&small) auto correlation inside drift CONCAT per trial (amp,dist,amp-dist) 
% 8+81 Y (big&small) auto correlation inside drift (amp,dist,amp-dist) - big

startup;

clear
close all
res=0.01;% 0.01 sec
subjects= {'SM','LS','LB','RW','AS', 'ALL' };%};


for type=4:-1:1
    all_drift_ampS_degreesX=[];
    all_drift_ampS_degreesY=[];
    all_drift_timeS_sX=[];
    all_drift_timeS_sY=[];
    all_drift_distS_degreesX=[];
    all_drift_distS_degreesY=[];
    all_drift_velS_deg2secX=[];
    all_drift_velS_deg2secY=[];
    for sub_i=1:length(subjects)
        sub=subjects(sub_i);
        sub=sub{1,1};
        if strcmp(sub, 'ALL')==0
            if type==1
                load(['C:\Users\bnapp\Documents\tunnelledVisionPaper\analyzing\resultsVectors\' sub '\allShapeNBAnalogallSessionallTrialcAnswer.mat']);
                subFig_num=sub_i;
                color='k';
                textY=1;
            else if type==2
                    load(['C:\Users\bnapp\Documents\tunnelledVisionPaper\analyzing\resultsVectors\' sub '\allShapeBAnalogallSessionallTrialcAnswer.mat']);
                    subFig_num=sub_i;
                    color='b';
                    textY=0.8;
                else if type==3
                        load(['C:\Users\bnapp\Documents\tunnelledVisionPaper\analyzing\resultsVectors\' sub '\allShapeNSAnalogallSessionallTrialcAnswer.mat']);
                        subFig_num=sub_i+12;
                        color='k';
                        textY=1;
                    else if type==4
                            load(['C:\Users\bnapp\Documents\tunnelledVisionPaper\analyzing\resultsVectors\' sub '\allShapeSAnalogallSessionallTrialcAnswer.mat']);
                            subFig_num=sub_i+12;
                            color='m';
                            textY=0.8;
                        end
                    end
                end
            end
            
            drift_ampS_degreesX=[];
            drift_ampS_degreesY=[];
            drift_timeS_sX=[];
            drift_timeS_sY=[];
            drift_distS_degreesX=[];
            drift_distS_degreesY=[];
            drift_velS_deg2secX=[];
            drift_velS_deg2secY=[];
            % INSIDE
            %for any given drift
            ampsPerDriftX=zeros(200,200);
            distsPerDriftX=zeros(200,200);
            ampsPerDriftY=zeros(200,200);
            distsPerDriftY=zeros(200,200);
            %for all drifts in the condition
            relDX=0;
            all_ampcorr_per_lagX=[];
            all_distcorr_per_lagX=[];
            all_bothcorr_per_lagX=[];
            xcf_ampPerTX=NaN(1,41);
            lags_ampPerTX=NaN(1,41);
            xcf_ampdistPerTX=NaN(1,41);
            lags_ampdistPerTX=NaN(1,41);
            xcf_distPerTX=NaN(1,41);
            lags_distPerTX=NaN(1,41);
            relTX=0;
            
            relDY=0;
            all_ampcorr_per_lagY=[];
            all_distcorr_per_lagY=[];
            all_bothcorr_per_lagY=[];
            xcf_ampPerTY=NaN(1,41);
            lags_ampPerTY=NaN(1,41);
            xcf_ampdistPerTY=NaN(1,41);
            lags_ampdistPerTY=NaN(1,41);
            xcf_distPerTY=NaN(1,41);
            lags_distPerTY=NaN(1,41);
            relTY=0;
            
            for t=1:length(drifts_time_ms)
                labeled_saccade_vec=labeled_saccade_vecs{1,t};
                XY_vec_deg=XY_vecs_deg{1,t};
                drift_amp_degreesX=[];
                drift_amp_degreesY=[];
                drift_time_sX=[];
                drift_time_sY=[];
                drift_dist_degreesX=[];
                drift_dist_degreesY=[];
                drift_vel_deg2secX=[];
                drift_vel_deg2secY=[];
                for i =1:size(labeled_saccade_vec,2)-1
                    tempX=[];
                    tempY=[];
                    tempX=(XY_vec_deg(1,((labeled_saccade_vec(1,i)+labeled_saccade_vec(2,i)):labeled_saccade_vec(1,i+1)))');
                    tempY=(XY_vec_deg(2,((labeled_saccade_vec(1,i)+labeled_saccade_vec(2,i)):labeled_saccade_vec(1,i+1)))');
                    
                    % clac - amp+dist+vel
                    drift_amp_degreesX(i) = sum(abs(diff(tempX)));
                    drift_amp_degreesY(i) = sum(abs(diff(tempY)));
                    drift_time_sX(i)=length(tempX)*res; % sec
                    drift_time_sY(i)=length(tempY)*res; % sec
                    drift_dist_degreesX(i)=sum(diff(tempX));
                    drift_dist_degreesY(i)=sum(diff(tempY));
                    drift_vel_deg2secX(i)=drift_amp_degreesX(i)/drift_time_sX(i);
                    drift_vel_deg2secY(i)=drift_amp_degreesY(i)/drift_time_sY(i);
                    
                end
                drift_ampS_degreesX=[drift_ampS_degreesX drift_amp_degreesX];
                drift_ampS_degreesY=[drift_ampS_degreesY drift_amp_degreesY];
                drift_timeS_sX=[drift_timeS_sX drift_time_sX];
                drift_timeS_sY=[drift_timeS_sY drift_time_sY];
                drift_distS_degreesX=[drift_distS_degreesX drift_dist_degreesX];
                drift_distS_degreesY=[drift_distS_degreesY drift_dist_degreesY];
                drift_velS_deg2secX=[drift_velS_deg2secX drift_vel_deg2secX];
                drift_velS_deg2secY=[drift_velS_deg2secY drift_vel_deg2secY];
                
                %inside
                
                ampsPerTrialX=[];
                distsPerTrialX=[];
                ampsPerTrialY=[];
                distsPerTrialY=[];
                for i =1:size(labeled_saccade_vec,2)-1
                    if length(tempX)>10 && size(labeled_saccade_vec,2)>2
                        relDX=relDX+1;
                        currAmp=[];
                        currDist=[];
                        for j=2:length(tempX)
                            currAmp(j-1) = tempX(j)-tempX(j-1);
                            currDist(j-1)=tempX(j,:)-tempX(1);
                        end
                        %for any given drift
                        ampsPerDriftX(relDX,1:length(tempX)-1)=currAmp;
                        distsPerDriftX(relDX,1:length(tempX)-1)=currDist;
                        ampsPerTrialX=[ampsPerTrialX currAmp];
                        distsPerTrialX=[distsPerTrialX currDist];
                        [xcf_amp,lags_amp,bounds_amp]=crosscorr(currAmp,currAmp);
                        [xcf_dist,lags_dist,bounds_dist]=crosscorr(currDist,currDist);
                        [xcf_both,lags_both,bounds_both]=crosscorr(currAmp,currDist);
                        for l=-20:1:20
                            if max(lags_amp==l)>0
                                all_ampcorr_per_lagX(relDX,l+21)=xcf_amp(lags_amp==l);
                                all_distcorr_per_lagX(relDX,l+21)=xcf_dist(lags_dist==l);
                                all_bothcorr_per_lagX(relDX,l+21)=xcf_both(lags_both==l);
                            end
                        end
                    end
                end
                if ~isempty(ampsPerTrialX)
                    relTX=relTX+1;
                    [xcf_ampPerTX(relTX,:),lags_ampPerTX(relTX,:),bounds_amp]=crosscorr(ampsPerTrialX,ampsPerTrialX);
                    [xcf_ampdistPerTX(relTX,:),lags_ampdistPerTX(relTX,:),bounds_amp]=crosscorr(ampsPerTrialX,distsPerTrialX);
                    [xcf_distPerTX(relTX,:),lags_distPerTX(relTX,:),bounds_amp]=crosscorr(distsPerTrialX,distsPerTrialX);
                end
                for i =1:size(labeled_saccade_vec,2)-1
                    if length(tempY)>10 && size(labeled_saccade_vec,2)>2
                        relDY=relDY+1;
                        currAmp=[];
                        currDist=[];
                        for j=2:length(tempY)
                            currAmp(j-1) = tempY(j)-tempY(j-1);
                            currDist(j-1)=tempY(j,:)-tempY(1);
                        end
                        %for any given drift
                        ampsPerDriftY(relDY,1:length(tempY)-1)=currAmp;
                        distsPerDriftY(relDY,1:length(tempY)-1)=currDist;
                        ampsPerTrialY=[ampsPerTrialY currAmp];
                        distsPerTrialY=[distsPerTrialY currDist];
                        [xcf_amp,lags_amp,bounds_amp]=crosscorr(currAmp,currAmp);
                        [xcf_dist,lags_dist,bounds_dist]=crosscorr(currDist,currDist);
                        [xcf_both,lags_both,bounds_both]=crosscorr(currAmp,currDist);
                        for l=-20:1:20
                            if max(lags_amp==l)>0
                                all_ampcorr_per_lagY(relDY,l+21)=xcf_amp(lags_amp==l);
                                all_distcorr_per_lagY(relDY,l+21)=xcf_dist(lags_dist==l);
                                all_bothcorr_per_lagY(relDY,l+21)=xcf_both(lags_both==l);
                            end
                        end
                    end
                end
                if ~isempty(ampsPerTrialY)
                    relTY=relTY+1;
                    [xcf_ampPerTY(relTY,:),lags_ampPerTY(relTY,:),bounds_amp]=crosscorr(ampsPerTrialY,ampsPerTrialY);
                    [xcf_ampdistPerTY(relTY,:),lags_ampdistPerTY(relTY,:),bounds_amp]=crosscorr(ampsPerTrialY,distsPerTrialY);
                    [xcf_distPerTY(relTY,:),lags_distPerTY(relTY,:),bounds_amp]=crosscorr(distsPerTrialY,distsPerTrialY);
                end
                
            end
            all_drift_ampS_degreesX=[all_drift_ampS_degreesX drift_ampS_degreesX];
            all_drift_ampS_degreesY=[all_drift_ampS_degreesY drift_ampS_degreesY];
            all_drift_timeS_sX=[all_drift_timeS_sX drift_timeS_sX];
            all_drift_timeS_sY=[all_drift_timeS_sY drift_timeS_sY];
            all_drift_distS_degreesX=[all_drift_distS_degreesX drift_distS_degreesX];
            all_drift_distS_degreesY=[all_drift_distS_degreesY drift_distS_degreesY];
            all_drift_velS_deg2secX=[all_drift_velS_deg2secX drift_velS_deg2secX];
            all_drift_velS_deg2secY=[all_drift_velS_deg2secY drift_velS_deg2secY];
        else
            if type==1
                subFig_num=sub_i;
                color='k';
                textY=1;
            else if type==2
                    subFig_num=sub_i;
                    color='b';
                    textY=0.8;
                else if type==3
                        subFig_num=sub_i+12;
                        color='k';
                        textY=1;
                    else if type==4
                            subFig_num=sub_i+12;
                            color='m';
                            textY=0.8;
                        end
                    end
                end
            end
            drift_ampS_degreesX=all_drift_ampS_degreesX;
            drift_ampS_degreesY=all_drift_ampS_degreesY;
            drift_timeS_sX=all_drift_timeS_sX;
            drift_timeS_sY=all_drift_timeS_sY;
            drift_distS_degreesX=all_drift_distS_degreesX;
            drift_distS_degreesY=all_drift_distS_degreesY;
            drift_velS_deg2secX=all_drift_velS_deg2secX;
            drift_velS_deg2secY=all_drift_velS_deg2secY;
            
        end
        if type==1 || type==2
            figure(5)
        else
            figure(51)
        end
        
        subplot(3,6,sub_i)
        hold on
        errorbar(-20:20,nanmean(xcf_ampPerTX),ste(xcf_ampPerTX),color)
        title({['-------' sub] ,'Amp X Concat'},'FontWeight','Normal')
        xlabel('lags [10ms]')
        text(10,textY,['n=' num2str(relDX) ],'color',color)
        axis([0 20 -0.5 1])
        subplot(3,6,sub_i+6)
        hold on
        errorbar(-20:20,nanmean(xcf_distPerTX),ste(xcf_distPerTX),color)
        title('Dist X Concat')
        xlabel('lags [10ms]')
        text(10,textY,['n=' num2str(relDX) ],'color',color)
        axis([0 20 -0.5 1])
        subplot(3,6,sub_i+12)
        hold on
        errorbar(-20:20,nanmean(xcf_ampdistPerTX),ste(xcf_ampdistPerTX),color)
        title('Dist-Amp X Concat')
        xlabel('lags [10ms]')
        text(10,textY,['n=' num2str(relDX) ],'color',color)
        axis([0 20 -0.5 1])
        
        if type==1 || type==2
            figure(6)
        else
            figure(61)
        end
        subplot(3,6,sub_i)
        hold on
        errorbar(-20:20,nanmean(all_ampcorr_per_lagX),ste(all_ampcorr_per_lagX),color)
        title({['-------' sub] ,'Amp X autocorr'},'FontWeight','Normal')
        xlabel('lags [10ms]')
        text(10,textY,['n=' num2str(relDX) ],'color',color)
        axis([0 20 -0.5 1])
        subplot(3,6,sub_i+6)
        hold on
        errorbar(-20:20,nanmean(all_distcorr_per_lagX),ste(all_distcorr_per_lagX),color)
        title('Dist X autocorr')
        xlabel('lags [10ms]')
        text(10,textY,['n=' num2str(relDX) ],'color',color)
        axis([0 20 -0.5 1])
        subplot(3,6,sub_i+12)
        hold on
        errorbar(-20:20,nanmean(all_bothcorr_per_lagX),ste(all_bothcorr_per_lagX),color)
        title('Dist-Amp X crosscorr')
        xlabel('lags [10ms]')
        text(10,textY,['n=' num2str(relDX) ],'color',color)
        axis([0 20 -0.5 1])
        if type==1 || type==2
            figure(7)
        else
            figure(71)
        end
        
        subplot(3,6,sub_i)
        hold on
        errorbar(-20:20,nanmean(xcf_ampPerTY),ste(xcf_ampPerTY),color)
        title({['-------' sub] ,'Amp Y Concat'},'FontWeight','Normal')
        xlabel('lags [10ms]')
        axis([0 20 -0.5 1])
        text(10,textY,['n=' num2str(relDY) ],'color',color)
        subplot(3,6,sub_i+6)
        hold on
        errorbar(-20:20,nanmean(xcf_distPerTY),ste(xcf_distPerTY),color)
        title('Dist Y Concat')
        xlabel('lags [10ms]')
        text(10,textY,['n=' num2str(relDY) ],'color',color)
        axis([0 20 -0.5 1])
        subplot(3,6,sub_i+12)
        hold on
        errorbar(-20:20,nanmean(xcf_ampdistPerTY),ste(xcf_ampdistPerTY),color)
        title('Dist-Amp Y Concat')
        xlabel('lags [10ms]')
        text(10,textY,['n=' num2str(relDY) ],'color',color)
        axis([0 20 -0.5 1])
        
        if type==1 || type==2
            figure(8)
        else
            figure(81)
        end
        subplot(3,6,sub_i)
        hold on
        errorbar(-20:20,nanmean(all_ampcorr_per_lagY),ste(all_ampcorr_per_lagY),color)
        title({['-------' sub] ,'Amp Y autocorr'},'FontWeight','Normal')
        xlabel('lags [10ms]')
        axis([0 20 -0.5 1])
        text(10,textY,['n=' num2str(relDY) ],'color',color)
        subplot(3,6,sub_i+6)
        hold on
        errorbar(-20:20,nanmean(all_distcorr_per_lagY),ste(all_distcorr_per_lagY),color)
        title('Dist Y autocorr')
        xlabel('lags [10ms]')
        axis([0 20 -0.5 1])
        text(10,textY,['n=' num2str(relDY) ],'color',color)
        subplot(3,6,sub_i+12)
        hold on
        errorbar(-20:20,nanmean(all_bothcorr_per_lagY),ste(all_bothcorr_per_lagY),color)
        title('Dist-Amp Y crosscorr')
        xlabel('lags [10ms]')
        text(10,textY,['n=' num2str(relDY) ],'color',color)
        axis([0 20 -0.5 1])
        
        figure(1)
        % X
        subplot(4,6,subFig_num)
        hold all
        axis([ 0 10 0 0.2]);
        h=histogram(drift_velS_deg2secX(drift_velS_deg2secX>0),0:0.2:10,'Normalization','probability','FaceColor',color);
        plot( median(drift_velS_deg2secX(drift_velS_deg2secX>0))*[1,1,1,1,1], 0:0.1:0.4,[color '--'])
        if strcmp(color,'k')==0
            text( median(drift_velS_deg2secX(drift_velS_deg2secX>0)),0.15 ,num2str(round(median(drift_velS_deg2secX(drift_velS_deg2secX>0)),2)),'Color',color,'FontSize',20);
        else
            text( median(drift_velS_deg2secX(drift_velS_deg2secX>0))-2.8,0.15 ,num2str(round(median(drift_velS_deg2secX(drift_velS_deg2secX>0)),2)),'Color',color,'FontSize',20);
        end
        xlabel(['Vel [deg/sec]'])
        p_x(sub_i)=ranksum(drift_velS_deg2secX(drift_velS_deg2secX>0),drift_velS_deg2secX(drift_velS_deg2secX>0));
        if sub_i==1
            ylabel('# DRIFT','FontSize', 20)
        else
            ylabel([])
        end
        if strcmp(sub,'ALL')
            %legend('Natural BIG', 'Tunneled BIG','Location','NorthEast') ;
            title('Drift Velocity X', 'FontSize', 25)
        end
        % Y
        subplot(4,6,subFig_num+6)
        hold all
        axis([ 0 10 0 0.2]);
        h=histogram(drift_velS_deg2secY(drift_velS_deg2secY>0),0:0.2:10,'Normalization','probability','FaceColor',color);
        plot( median(drift_velS_deg2secY(drift_velS_deg2secY>0))*[1,1,1,1,1], 0:0.1:0.4,[color '--'])
        if strcmp(color,'k')==0
            text( median(drift_velS_deg2secY(drift_velS_deg2secY>0)),0.15 ,num2str(round(median(drift_velS_deg2secY(drift_velS_deg2secY>0)),2)),'Color',color,'FontSize',20);
        else
            text( median(drift_velS_deg2secY(drift_velS_deg2secY>0))-2.8,0.15 ,num2str(round(median(drift_velS_deg2secY(drift_velS_deg2secY>0)),2)),'Color',color,'FontSize',20);
        end
        xlabel(['Vel [deg/sec]'])
        p_y(sub_i)=ranksum(drift_velS_deg2secY(drift_velS_deg2secY>0),drift_velS_deg2secY(drift_velS_deg2secY>0));
        if sub_i==1
            ylabel('# DRIFT','FontSize', 20)
        else
            ylabel([])
        end
        if strcmp(sub,'ALL')
            %legend('Natural BIG', 'Tunneled BIG','Location','NorthEast') ;
            title('Drift Velocity Y', 'FontSize', 25)
        end
        
      
        % scatter drift length/vel vs time
        % X
        binSize=0.2;
        ind=0;
        for bin=0:binSize:2-binSize
            ind=ind+1;
            temp=drift_ampS_degreesX(drift_ampS_degreesX<30);
            temp(drift_timeS_sX<bin)=0;
            temp(drift_timeS_sX>bin+binSize)=0;
            meanAmpsPerBin(ind)=mean(temp(temp~=0));
            stdAmpsPerBin(ind)=std(temp(temp~=0));
            Q_AmpsPerBin(1:3,ind)=quantile(temp(temp~=0),[0.25 0.5 0.75]);
            temp=drift_velS_deg2secX(drift_velS_deg2secX<10);
            temp(drift_timeS_sX<bin)=0;
            temp(drift_timeS_sX>bin+binSize)=0;
            meanVelsPerBin(ind)=mean(temp(temp~=0));
            stdVelsPerBin(ind)=std(temp(temp~=0));
            Q_VelsPerBin(1:3,ind)=quantile(temp(temp~=0),[0.25 0.5 0.75]);
        end
        figure(2)
        %vel/time tunneled
        subplot(4,6,subFig_num)
        if strcmp(sub,'ALL')
            title('Vel X', 'FontSize', 25)
        else
            title(sub, 'FontSize', 25)
        end
        hold all
        plot(drift_timeS_sX,drift_velS_deg2secX,['.' color])
        xlabel('drift duration','FontSize', 20)
        if sub_i==1
            ylabel('drift velocity','FontSize', 20)
        else
            ylabel([])
        end
        axis([ 0 2 0 30]);
        %length/time tunneled
        subplot(4,6,subFig_num+6)
        if strcmp(sub,'ALL')
            title('Amp X', 'FontSize', 25)
        else
            title(sub, 'FontSize', 25)
        end
        hold all
        plot(drift_timeS_sX,drift_ampS_degreesX,['.' color])
        xlabel('drift duration','FontSize', 20)
        if sub_i==1
            ylabel('drift amplitude','FontSize', 20)
        else
            ylabel([])
        end
        axis([ 0 2 0 10]);
  %%% trying to present 2+3 better :      
%         figure(21)
%         %vel/time tunneled
%         subplot(4,6,subFig_num)
%         if strcmp(sub,'ALL')
%             title('Vel X', 'FontSize', 25)
%         else
%             title(sub, 'FontSize', 25)
%         end
%         hold all
%         plot(binSize:binSize:2,stdVelsPerBin,color);
%         xlabel('drift duration','FontSize', 20)
%         if sub_i==1
%             ylabel('drift velocity','FontSize', 20)
%         else
%             ylabel([])
%         end
%         axis([ 0 2 0 30]);
%         %length/time tunneled
%         subplot(4,6,subFig_num+6)
%         if strcmp(sub,'ALL')
%             title('Amp X', 'FontSize', 25)
%         else
%             title(sub, 'FontSize', 25)
%         end
%         hold all
%         plot(binSize:binSize:2,stdAmpsPerBin,color);
%         xlabel('drift duration','FontSize', 20)
%         if sub_i==1
%             ylabel('drift amplitude','FontSize', 20)
%         else
%             ylabel([])
%         end
%         axis([ 0 2 0 10]);
%         
%         figure(22)
%         %vel/time tunneled
%         subplot(4,6,subFig_num)
%         if strcmp(sub,'ALL')
%             title('Vel X', 'FontSize', 25)
%         else
%             title(sub, 'FontSize', 25)
%         end
%         hold all
%         plot(binSize:binSize:2,Q_AmpsPerBin(2,:),color)
%         plot(binSize:binSize:2,Q_AmpsPerBin(1,:),['.' color])
%         plot(binSize:binSize:2,Q_AmpsPerBin(3,:),['.' color])
%         xlabel('drift duration','FontSize', 20)
%         if sub_i==1
%             ylabel('drift velocity','FontSize', 20)
%         else
%             ylabel([])
%         end
%         axis([ 0 2 0 30]);
%         %length/time tunneled
%         subplot(4,6,subFig_num+6)
%         if strcmp(sub,'ALL')
%             title('Amp X', 'FontSize', 25)
%         else
%             title(sub, 'FontSize', 25)
%         end
%         hold all
%         plot(binSize:binSize:2,Q_VelsPerBin(2,:),color)
%         plot(binSize:binSize:2,Q_VelsPerBin(1,:),['.' color])
%         plot(binSize:binSize:2,Q_VelsPerBin(3,:),['.' color])
%         xlabel('drift duration','FontSize', 20)
%         if sub_i==1
%             ylabel('drift amplitude','FontSize', 20)
%         else
%             ylabel([])
%         end
%         axis([ 0 2 0 10]);
        
        figure(3)
        %vel/time tunneled
        subplot(4,6,subFig_num)
        if strcmp(sub,'ALL')
            title('Vel Y', 'FontSize', 25)
        else
            title(sub, 'FontSize', 25)
        end
        hold all
        plot(drift_timeS_sY,drift_velS_deg2secY,['.' color])
        xlabel('drift duration','FontSize', 20)
        if sub_i==1
            ylabel('drift velocity','FontSize', 20)
        else
            ylabel([])
        end
        axis([ 0 2 0 30]);
        %length/time tunneled
        subplot(4,6,subFig_num+6)
        if strcmp(sub,'ALL')
            title('Amp Y', 'FontSize', 25)
        else
            title(sub, 'FontSize', 25)
        end
        hold all
        plot(drift_timeS_sY,drift_ampS_degreesY,['.' color])
        xlabel('drift duration','FontSize', 20)
        if sub_i==1
            ylabel('drift amplitude','FontSize', 20)
        else
            ylabel([])
        end
        axis([ 0 2 0 10]);
        
%         figure(4)
%         %4 auto correlation per drift (time,vel,amp) - X
%         %41 auto correlation per drift (time,vel,amp) - Y
%         if length(drift_timeS_sX)>1
%             [xcf_temp1,lags_temp1,bounds_temp1]=crosscorr(drift_timeS_sX,drift_timeS_sX,length(drift_timeS_sX)-1);
%             [xcf_temp2,lags_temp2,bounds_temp2]=crosscorr(drift_velS_deg2secX,drift_velS_deg2secX,length(drift_timeS_sX)-1);
%             [xcf_temp3,lags_temp3,bounds_temp3]=crosscorr(drift_ampS_degreesX,drift_ampS_degreesX,length(drift_timeS_sX)-1);
%             
%         else
%             xcf_temp=nan;
%             lags_temp=nan;
%             bounds_temp=nan;
%         end
%         xcf1{t}=xcf_temp1;
%         lags1{t}=lags_temp1;
%         bounds1{t}=bounds_temp1;
%         
%         xcf2{t}=xcf_temp2;
%         lags2{t}=lags_temp2;
%         bounds2{t}=bounds_temp2;
%         
%         xcf3{t}=xcf_temp3;
%         lags3{t}=lags_temp3;
%         bounds3{t}=bounds_temp3;
%         
%         
%         for rel_lag=-5:1:5
%             rel_xcf=[];
%             for ii=1:length(lags1)
%                 if max(lags1{1,ii}==rel_lag)>0
%                     rel_xcf=[rel_xcf xcf1{1,ii}(lags1{1,ii}==rel_lag)];
%                 end
%             end
%             mean_per_lag1(rel_lag+6)=mean(rel_xcf);
%             std_per_lag1(rel_lag+6)=ste(rel_xcf);
%         end
%         
%         for rel_lag=-5:1:5
%             rel_xcf=[];
%             for ii=1:length(lags2)
%                 if max(lags2{1,ii}==rel_lag)>0
%                     rel_xcf=[rel_xcf xcf2{1,ii}(lags2{1,ii}==rel_lag)];
%                 end
%             end
%             mean_per_lag2(rel_lag+6)=mean(rel_xcf);
%             std_per_lag2(rel_lag+6)=ste(rel_xcf);
%         end
%         
%         for rel_lag=-5:1:5
%             rel_xcf=[];
%             for ii=1:length(lags3)
%                 if max(lags3{1,ii}==rel_lag)>0
%                     rel_xcf=[rel_xcf xcf3{1,ii}(lags3{1,ii}==rel_lag)];
%                 end
%             end
%             mean_per_lag3(rel_lag+6)=mean(rel_xcf);
%             std_per_lag3(rel_lag+6)=ste(rel_xcf);
%         end
%         subplot(3,6,sub_i)
%         hold all
%         shadedErrorBar(-5:1:5,mean_per_lag1,std_per_lag1,color);
%         title(sub, 'FontSize', 25)
%         if sub_i==1
%             ylabel('AutoCorr X Time','FontSize',15)
%         else
%             ylabel([])
%         end
%         axis([-5 5 -1 1])
%         
%         subplot(3,6,sub_i+6)
%         hold all
%         shadedErrorBar(-5:1:5,mean_per_lag1,std_per_lag1,color);
%         title(sub, 'FontSize', 25)
%         if sub_i==1
%             ylabel('AutoCorr X Vel','FontSize',15)
%         else
%             ylabel([])
%         end
%         axis([-5 5 -1 1])
%         
%         subplot(3,6,sub_i+12)
%         hold all
%         shadedErrorBar(-5:1:5,mean_per_lag1,std_per_lag1,color);
%         
%         title(sub, 'FontSize', 25)
%         if sub_i==1
%             ylabel('AutoCorr X Amp','FontSize',15)
%         else
%             ylabel([])
%         end
%         axis([-5 5 -1 1])
%         % Y
%         figure(41)
%         %4 auto correlation per drift (time,vel,amp) - X
%         %41 auto correlation per drift (time,vel,amp) - Y
%         if length(drift_timeS_sY)>1
%             [xcf_temp1,lags_temp1,bounds_temp1]=crosscorr(drift_timeS_sY,drift_timeS_sY,length(drift_timeS_sY)-1);
%             [xcf_temp2,lags_temp2,bounds_temp2]=crosscorr(drift_velS_deg2secY,drift_velS_deg2secY,length(drift_timeS_sY)-1);
%             [xcf_temp3,lags_temp3,bounds_temp3]=crosscorr(drift_ampS_degreesY,drift_ampS_degreesY,length(drift_timeS_sY)-1);
%             
%         else
%             xcf_temp=nan;
%             lags_temp=nan;
%             bounds_temp=nan;
%         end
%         xcf1{t}=xcf_temp1;
%         lags1{t}=lags_temp1;
%         bounds1{t}=bounds_temp1;
%         
%         xcf2{t}=xcf_temp2;
%         lags2{t}=lags_temp2;
%         bounds2{t}=bounds_temp2;
%         
%         xcf3{t}=xcf_temp3;
%         lags3{t}=lags_temp3;
%         bounds3{t}=bounds_temp3;
%         
%         
%         for rel_lag=-5:1:5
%             rel_xcf=[];
%             for ii=1:length(lags1)
%                 if max(lags1{1,ii}==rel_lag)>0
%                     rel_xcf=[rel_xcf xcf1{1,ii}(lags1{1,ii}==rel_lag)];
%                 end
%             end
%             mean_per_lag1(rel_lag+6)=mean(rel_xcf);
%             std_per_lag1(rel_lag+6)=ste(rel_xcf);
%         end
%         
%         for rel_lag=-5:1:5
%             rel_xcf=[];
%             for ii=1:length(lags2)
%                 if max(lags2{1,ii}==rel_lag)>0
%                     rel_xcf=[rel_xcf xcf2{1,ii}(lags2{1,ii}==rel_lag)];
%                 end
%             end
%             mean_per_lag2(rel_lag+6)=mean(rel_xcf);
%             std_per_lag2(rel_lag+6)=ste(rel_xcf);
%         end
%         
%         for rel_lag=-5:1:5
%             rel_xcf=[];
%             for ii=1:length(lags3)
%                 if max(lags3{1,ii}==rel_lag)>0
%                     rel_xcf=[rel_xcf xcf3{1,ii}(lags3{1,ii}==rel_lag)];
%                 end
%             end
%             mean_per_lag3(rel_lag+6)=mean(rel_xcf);
%             std_per_lag3(rel_lag+6)=ste(rel_xcf);
%         end
%         subplot(3,6,sub_i)
%         hold all
%         shadedErrorBar(-5:1:5,mean_per_lag1,std_per_lag1,color);
%         title(sub, 'FontSize', 25)
%         if sub_i==1
%             ylabel('AutoCorr Y Time','FontSize',15)
%         else
%             ylabel([])
%         end
%         axis([-5 5 -1 1])
%         
%         subplot(3,6,sub_i+6)
%         hold all
%         shadedErrorBar(-5:1:5,mean_per_lag1,std_per_lag1,color);
%         title(sub, 'FontSize', 25)
%         if sub_i==1
%             ylabel('AutoCorr Y Vel','FontSize',15)
%         else
%             ylabel([])
%         end
%         axis([-5 5 -1 1])
%         
%         subplot(3,6,sub_i+12)
%         hold all
%         shadedErrorBar(-5:1:5,mean_per_lag1,std_per_lag1,color);
%         
%         title(sub, 'FontSize', 25)
%         if sub_i==1
%             ylabel('AutoCorr Y Amp','FontSize',15)
%         else
%             ylabel([])
%         end
%         axis([-5 5 -1 1])
        
    end
end
tilefigs;
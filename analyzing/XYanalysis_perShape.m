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
corrLags=40;
subjects= {'SM','LS','LB','RW','AS', 'ALL' };%};
%subjects= {'LS'};
shapes={'all'};%,'parallelog','rectangle','square','circle','triangle'};

for shape_i=1:length(shapes)
    shape=shapes(shape_i);
    shape=shape{1,1};
    disp(shape)
    for type=4:-1:1
        All_ampcorr_per_lagY=[];
        All_distcorr_per_lagY=[];
        All_bothcorr_per_lagY=[];
        All_ampcorr_per_lagX=[];
        All_distcorr_per_lagX=[];
        All_bothcorr_per_lagX=[];
        
        AllT_ampcorr_per_lagY=[];
        AllT_distcorr_per_lagY=[];
        AllT_bothcorr_per_lagY=[];
        AllT_ampcorr_per_lagX=[];
        AllT_distcorr_per_lagX=[];
        AllT_bothcorr_per_lagX=[];
        for sub_i=1:length(subjects)
            sub=subjects(sub_i);
            sub=sub{1,1};
            if strcmp(sub, 'ALL')==0
                if type==1
                    load(['C:\Users\bnapp\Documents\tunnelledVisionPaper\analyzing\resultsVectors_forXY\' sub '\' shape 'ShapeNBAnalogallSessionallTrialcAnswer.mat']);
                    subFig_num=sub_i;
                    color='k';
                    textY=1;
                else if type==2
                        load(['C:\Users\bnapp\Documents\tunnelledVisionPaper\analyzing\resultsVectors_forXY\' sub '\' shape 'ShapeBAnalogallSessionallTrialcAnswer.mat']);
                        subFig_num=sub_i;
                        color='b';
                        textY=0.8;
                    else if type==3
                            load(['C:\Users\bnapp\Documents\tunnelledVisionPaper\analyzing\resultsVectors_forXY\' sub '\' shape 'ShapeNSAnalogallSessionallTrialcAnswer.mat']);
                            subFig_num=sub_i+12;
                            color='k';
                            textY=1;
                        else if type==4
                                load(['C:\Users\bnapp\Documents\tunnelledVisionPaper\analyzing\resultsVectors_forXY\' sub '\' shape 'ShapeSAnalogallSessionallTrialcAnswer.mat']);
                                subFig_num=sub_i+12;
                                color='m';
                                textY=0.8;
                            end
                        end
                    end
                end
                % INSIDE
                %for all drifts in the condition
                relDX=0;
                all_ampcorr_per_lagX=NaN(1,corrLags*2+1);
                all_distcorr_per_lagX=NaN(1,corrLags*2+1);
                all_bothcorr_per_lagX=NaN(1,corrLags*2+1);
                allT_ampcorr_per_lagX=NaN(1,corrLags*2+1);
                allT_distcorr_per_lagX=NaN(1,corrLags*2+1);
                allT_bothcorr_per_lagX=NaN(1,corrLags*2+1);
                relTX=0;
                signAmpCorrX=zeros(1,corrLags*2+1);
                signDistCorrX=zeros(1,corrLags*2+1);
                
                relDY=0;
                all_ampcorr_per_lagY=NaN(1,corrLags*2+1);
                all_distcorr_per_lagY=NaN(1,corrLags*2+1);
                all_bothcorr_per_lagY=NaN(1,corrLags*2+1);
                allT_ampcorr_per_lagY=NaN(1,corrLags*2+1);
                allT_distcorr_per_lagY=NaN(1,corrLags*2+1);
                allT_bothcorr_per_lagY=NaN(1,corrLags*2+1);
                relTY=0;
                signAmpCorrY=zeros(1,corrLags*2+1);
                signDistCorrY=zeros(1,corrLags*2+1);
                
                for t=1:length(labeled_saccade_vecs)
                    labeled_saccade_vec=labeled_saccade_vecs{1,t};
                    XY_vec_deg=XY_vecs_deg{1,t};
                    
                    %inside
                    ampsPerTrialX=[];
                    distsPerTrialX=[];
                    ampsPerTrialY=[];
                    distsPerTrialY=[];
                    
                    for i =1:size(labeled_saccade_vec,2)-1
                        tempX=[];
                        tempY=[];
                        tempX=(XY_vec_deg(1,((labeled_saccade_vec(1,i)+labeled_saccade_vec(2,i)):labeled_saccade_vec(1,i+1)))');
                        tempY=(XY_vec_deg(2,((labeled_saccade_vec(1,i)+labeled_saccade_vec(2,i)):labeled_saccade_vec(1,i+1)))');
                        
                        if length(tempX)>10 && size(labeled_saccade_vec,2)>2
                            relDX=relDX+1;
                            currAmp=[];
                            currDist=[];
                            for j=2:length(tempX)
                                currAmp(j-1) = tempX(j)-tempX(j-1);
                                currDist(j-1)=tempX(j,:)-tempX(1);
                            end
                            %for any given drift
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
                        if length(tempY)>10 && size(labeled_saccade_vec,2)>2
                            relDY=relDY+1;
                            currAmp=[];
                            currDist=[];
                            for j=2:length(tempY)
                                currAmp(j-1) = tempY(j)-tempY(j-1);
                                currDist(j-1)=tempY(j,:)-tempY(1);
                            end
                            %for any given drift
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
                    if ~isempty(ampsPerTrialX)
                        relTX=relTX+1;
                        [xcf_amp,lags_amp,bounds_amp]=crosscorr(ampsPerTrialX,ampsPerTrialX,min(corrLags,length(ampsPerTrialX)-1));
                        [xcf_dist,lags_dist,bounds_dist]=crosscorr(distsPerTrialX,distsPerTrialX,min(corrLags,length(distsPerTrialX)-1));
%                         crosscorr(ampsPerTrialX,ampsPerTrialX)
%                         pause;
                        [xcf_both,lags_both,bounds_both]=crosscorr(ampsPerTrialX,distsPerTrialX,min(corrLags,length(ampsPerTrialX)-1));
                        for l=-corrLags:1:corrLags
                            if max(lags_amp==l)>0
                                allT_ampcorr_per_lagX(relTX,l+corrLags+1)=xcf_amp(lags_amp==l);
                                allT_distcorr_per_lagX(relTX,l+corrLags+1)=xcf_dist(lags_dist==l);
                                allT_bothcorr_per_lagX(relTX,l+corrLags+1)=xcf_both(lags_both==l);
                                if xcf_amp(lags_amp==l)>bounds_amp(1) || xcf_amp(lags_amp==l)<bounds_amp(2)
                                    signAmpCorrX(relTX,l+corrLags+1)=xcf_amp(lags_amp==l);
                                end
                                if xcf_dist(lags_dist==l)>bounds_dist(1) || xcf_dist(lags_dist==l)<bounds_dist(2)
                                    signDistCorrX(relTX,l+corrLags+1)=xcf_dist(lags_dist==l);
                                end
                            end
                        end
                    end
                    if ~isempty(ampsPerTrialY)
                        relTY=relTY+1;
                        [xcf_amp,lags_amp,bounds_amp]=crosscorr(ampsPerTrialY,ampsPerTrialY,min(corrLags,length(ampsPerTrialY)-1));
                        [xcf_dist,lags_dist,bounds_dist]=crosscorr(distsPerTrialY,distsPerTrialY,min(corrLags,length(distsPerTrialY)-1));
%                         crosscorr(ampsPerTrialY,ampsPerTrialY)
%                         pause;
                        [xcf_both,lags_both,bounds_both]=crosscorr(ampsPerTrialY,distsPerTrialY,min(corrLags,length(ampsPerTrialY)-1));
                        for l=-corrLags:1:corrLags
                            if max(lags_amp==l)>0
                                allT_ampcorr_per_lagY(relTY,l+corrLags+1)=xcf_amp(lags_amp==l);
                                allT_distcorr_per_lagY(relTY,l+corrLags+1)=xcf_dist(lags_dist==l);
                                allT_bothcorr_per_lagY(relTY,l+corrLags+1)=xcf_both(lags_both==l);
                                if xcf_amp(lags_amp==l)>bounds_amp(1) || xcf_amp(lags_amp==l)<bounds_amp(2)
                                    signAmpCorrY(relTY,l+corrLags+1)=xcf_amp(lags_amp==l);
                                end
                                if xcf_dist(lags_dist==l)>bounds_dist(1) || xcf_dist(lags_dist==l)<bounds_dist(2)
                                    signDistCorrY(relTY,l+corrLags+1)=xcf_dist(lags_dist==l);
                                end
                            end
                        end
                    end
                    
                end
                All_ampcorr_per_lagY = [All_ampcorr_per_lagY ; all_ampcorr_per_lagY];
                All_distcorr_per_lagY = [All_distcorr_per_lagY ; all_distcorr_per_lagY];
                All_bothcorr_per_lagY = [All_bothcorr_per_lagY ; all_bothcorr_per_lagY];
                All_ampcorr_per_lagX = [All_ampcorr_per_lagX ; all_ampcorr_per_lagX];
                All_distcorr_per_lagX = [All_distcorr_per_lagX ; all_distcorr_per_lagX];
                All_bothcorr_per_lagX = [All_bothcorr_per_lagX ; all_bothcorr_per_lagX];
                
                AllT_ampcorr_per_lagY = [AllT_ampcorr_per_lagY ; allT_ampcorr_per_lagY];
                AllT_distcorr_per_lagY = [AllT_distcorr_per_lagY ; allT_distcorr_per_lagY];
                AllT_bothcorr_per_lagY = [AllT_bothcorr_per_lagY ; allT_bothcorr_per_lagY];
                AllT_ampcorr_per_lagX = [AllT_ampcorr_per_lagX ; allT_ampcorr_per_lagX];
                AllT_distcorr_per_lagX = [AllT_distcorr_per_lagX ; allT_distcorr_per_lagX];
                AllT_bothcorr_per_lagX = [AllT_bothcorr_per_lagX ; allT_bothcorr_per_lagX];
                
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
                
                all_ampcorr_per_lagY = All_ampcorr_per_lagY;
                all_distcorr_per_lagY = All_distcorr_per_lagY;
                all_bothcorr_per_lagY = All_bothcorr_per_lagY;
                all_ampcorr_per_lagX = All_ampcorr_per_lagX;
                all_distcorr_per_lagX = All_distcorr_per_lagX;
                all_bothcorr_per_lagX = All_bothcorr_per_lagX;
                
                allT_ampcorr_per_lagY = AllT_ampcorr_per_lagY;
                allT_distcorr_per_lagY = AllT_distcorr_per_lagY;
                allT_bothcorr_per_lagY = AllT_bothcorr_per_lagY;
                allT_ampcorr_per_lagX = AllT_ampcorr_per_lagX;
                allT_distcorr_per_lagX = AllT_distcorr_per_lagX;
                allT_bothcorr_per_lagX = AllT_bothcorr_per_lagX;
                
                
            end
            if type==1 || type==2
                figure(5)
            else
                figure(51)
            end
            
            subplot(3,6,sub_i)
            hold on
            errorbar(-corrLags:corrLags,nanmean(allT_ampcorr_per_lagX,1),ste(allT_ampcorr_per_lagX,1),color)
            title({['-------' sub] ,'Amp X Concat'},'FontWeight','Normal')
            xlabel('lags [10ms]')
            text(10,textY,['trials=' num2str(relTX) ],'color',color)
            axis([0 corrLags -0.5 1])
            subplot(3,6,sub_i+6)
            hold on
            errorbar(-corrLags:corrLags,nanmean(allT_distcorr_per_lagX,1),ste(allT_distcorr_per_lagX,1),color)
            title('Dist X Concat')
            xlabel('lags [10ms]')
            text(10,textY,['trials=' num2str(relTX) ],'color',color)
            axis([0 corrLags -0.5 1])
            subplot(3,6,sub_i+12)
            hold on
            errorbar(-corrLags:corrLags,nanmean(allT_bothcorr_per_lagX,1),ste(allT_bothcorr_per_lagX,1),color)
            title('Dist-Amp X Concat')
            xlabel('lags [10ms]')
            text(10,textY,['trials=' num2str(relTX) ],'color',color)
            axis([0 corrLags -0.5 1])
            
%             if type==1 || type==2
%                 figure(6)
%             else
%                 figure(61)
%             end
%             subplot(3,6,sub_i)
%             hold on
%             errorbar(-20:20,nanmean(all_ampcorr_per_lagX,1),ste(all_ampcorr_per_lagX,1),color)
%             title({['-------' sub] ,'Amp X autocorr'},'FontWeight','Normal')
%             xlabel('lags [10ms]')
%             text(10,textY,['drifts=' num2str(relDX) ],'color',color)
%             axis([0 20 -0.5 1])
%             subplot(3,6,sub_i+6)
%             hold on
%             errorbar(-20:20,nanmean(all_distcorr_per_lagX,1),ste(all_distcorr_per_lagX,1),color)
%             title('Dist X autocorr')
%             xlabel('lags [10ms]')
%             text(10,textY,['drifts=' num2str(relDX) ],'color',color)
%             axis([0 20 -0.5 1])
%             subplot(3,6,sub_i+12)
%             hold on
%             errorbar(-20:20,nanmean(all_bothcorr_per_lagX,1),ste(all_bothcorr_per_lagX,1),color)
%             title('Dist-Amp X crosscorr')
%             xlabel('lags [10ms]')
%             text(10,textY,['drifts=' num2str(relDX) ],'color',color)
%             axis([0 20 -0.5 1])
            if type==1 || type==2
                figure(7)
            else
                figure(71)
            end
            
            subplot(3,6,sub_i)
            hold on
            errorbar(-corrLags:corrLags,nanmean(allT_ampcorr_per_lagY,1),ste(allT_ampcorr_per_lagY,1),color)
            title({['-------' sub] ,'Amp Y Concat'},'FontWeight','Normal')
            xlabel('lags [10ms]')
            axis([0 corrLags -0.5 1])
            text(10,textY,['trials=' num2str(relTY) ],'color',color)
            subplot(3,6,sub_i+6)
            hold on
            errorbar(-corrLags:corrLags,nanmean(allT_distcorr_per_lagY,1),ste(allT_distcorr_per_lagY,1),color)
            title('Dist Y Concat')
            xlabel('lags [10ms]')
            text(10,textY,['trials=' num2str(relTY) ],'color',color)
            axis([0 corrLags -0.5 1])
            subplot(3,6,sub_i+12)
            hold on
            errorbar(-corrLags:corrLags,nanmean(allT_bothcorr_per_lagY,1),ste(allT_bothcorr_per_lagY,1),color)
            title('Dist-Amp Y Concat')
            xlabel('lags [10ms]')
            text(10,textY,['trials=' num2str(relTY) ],'color',color)
            axis([0 corrLags -0.5 1])
            
%             if type==1 || type==2
%                 figure(8)
%             else
%                 figure(81)
%             end
%             subplot(3,6,sub_i)
%             hold on
%             errorbar(-20:20,nanmean(all_ampcorr_per_lagY,1),ste(all_ampcorr_per_lagY,1),color)
%             title({['-------' sub] ,'Amp Y autocorr'},'FontWeight','Normal')
%             xlabel('lags [10ms]')
%             axis([0 20 -0.5 1])
%             text(10,textY,['drifts=' num2str(relDY) ],'color',color)
%             subplot(3,6,sub_i+6)
%             hold on
%             errorbar(-20:20,nanmean(all_distcorr_per_lagY,1),ste(all_distcorr_per_lagY,1),color)
%             title('Dist Y autocorr')
%             xlabel('lags [10ms]')
%             axis([0 20 -0.5 1])
%             text(10,textY,['drifts=' num2str(relDY) ],'color',color)
%             subplot(3,6,sub_i+12)
%             hold on
%             errorbar(-20:20,nanmean(all_bothcorr_per_lagY,1),ste(all_bothcorr_per_lagY,1),color)
%             title('Dist-Amp Y crosscorr')
%             xlabel('lags [10ms]')
%             text(10,textY,['drifts=' num2str(relDY) ],'color',color)
%             axis([0 20 -0.5 1])
if ~strcmp(sub,'ALL')
    figure(10+type)
    subplot(5,1,sub_i)
    imagesc(signAmpCorrX(:,corrLags+1:end),[-1 1])
    colormap('jet')
    colorbar
    ylabel(sub)
    if sub_i==5
        xlabel('time lags [ms]')
    end
    figure(20+type)
    subplot(5,1,sub_i)
    imagesc(signAmpCorrY(:,corrLags+1:end),[-1 1])
    colormap('jet')
    colorbar
    ylabel(sub)
    if sub_i==5
        xlabel('time lags [ms]')
    end
        figure(30+type)
    subplot(5,1,sub_i)
    imagesc(signDistCorrX(:,corrLags+1:end),[-1 1])
    colormap('jet')
    colorbar
    ylabel(sub)
    if sub_i==5
        xlabel('time lags [ms]')
    end
    figure(40+type)
    subplot(5,1,sub_i)
    imagesc(signDistCorrY(:,corrLags+1:end),[-1 1])
    colormap('jet')
    colorbar
    ylabel(sub)
    if sub_i==5
        xlabel('time lags [ms]')
    end
    
end

        end
        figure(10+type)
        subplot(5,1,1)
        title(['Sign X ConcatCorr - Amp  type: ' color])
        figure(20+type)
        subplot(5,1,1)
        title(['Sign Y ConcatCorr - Amp  type: ' color])
        figure(30+type)
        subplot(5,1,1)
        title(['Sign X ConcatCorr - Dist  type: ' color])
        figure(40+type)
        subplot(5,1,1)
        title(['Sign Y ConcatCorr - Dist  type: ' color])
        %         tilefigs;
        %         pause;
    end
    tilefigs;
%     pause;
%     close all
end


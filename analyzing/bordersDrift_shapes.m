% new drift borders analysis

clear
% close all

binS=10;
% what sub data do I want?
shape='all'; % 'all' 'circle' 'parallelog' 'square' 'triangle' 'rectangle'
session='all'; % 'all' '1';
trial='all';% 'all' '1.mat';
coreectORwrong='c'; %'all' 'c' 'w';
cal=0;

%general parameters:
res=0.01;% 0.01 sec
screen_dis=1;% meter
PIXEL2METER=0.000264583;
doPlot=0; %for sacDiffAmos
analogs={'B', 'NB'};%{'S', 'NS'};%

for analog_i=1:2
    analog=analogs{1,analog_i};
    nameOfFile=[shape 'Shape' analog 'Analog' session 'Session' trial 'Trial' coreectORwrong 'Answer'];
    nameOfFile(regexp(nameOfFile,'[.]'))=[];
    if strcmp(analog,'B') || strcmp(analog,'NB')
        analogType='B';
    else if strcmp(analog,'S') || strcmp(analog,'NS')
            analogType='S';
        end
    end
    allSub_Strait=0;
    allSub_Circle=0;
    allSub_Other=0;
    allSub_Strait_notB=0;
    allSub_Circle_notB=0;
    allSub_Other_notB=0;
    allSub_borderAngels=[];
    allSub_driftAngels=[];
    allSub_notB_driftAngels=[];
    allSub_angleBetweenBorderDrift=[];
    allSub_angleBetweenSaccDrift=[];
    allSub_followSaccAngle=[];
    allSub_crossSaccAngle=[];
    sub_i=0;
    for subjects= {'LB','LS','SM','RW','AS'} %,'LB','LS' ,'AS' ,'RW','SM'
        Strait=0;
        Circle=0;
        Other=0;
        Strait_notB=0;
        Circle_notB=0;
        Other_notB=0;
        allCircle_notB=0;
        allOther_notB=0;
        allStrait_notB=0;
        allCircle=0;
        allOther=0;
        allStrait=0;
        sub_i=sub_i+1;
        alltrial_borderAngels=[];
        alltrial_driftAngels=[];
        alltrial_notB_driftAngels=[];
        alltrial_angleBetweenSaccDrift=[];
        alltrial_angleBetweenBorderDrift=[];
        alltrial_followSaccAngle=[];
        alltrial_crossSaccAngle=[];
        t=0;
        labeled_saccade_vecs={};
        f=fullfile('C:\Users\bnapp\Documents\tunnelledVisionPaper\analyzing\cleanedData\', subjects);
        files = dir(f{1,1});
        for file = files'
            if strcmp(file.name,'.')==0 && strcmp(file.name,'..')==0
                currFile = load(file.name);
                % shape
                if  strcmp(shape,'all')==1 || strcmp(currFile.myimgfiles{1,1}{1,1},shape)
                    % correct\wrong only
                    if  strcmp(coreectORwrong,'all')==1 || ((strcmp(coreectORwrong,'c') && max(currFile.iscorrects{1,1})==1 ) || (strcmp(coreectORwrong,'w') && max(currFile.iscorrects{1,1})==0 ))
                        % analog type
                        if  strcmp(analog,'all')==1 || strcmp(file.name(4),analog(1))
                            if  length(analog)==2
                                if strcmp(analogType,'B')
                                    session=[1,3];
                                else if strcmp(analogType,'S')
                                        session=[2,4];
                                    end
                                end
                            end
                            % session number
                            if  strcmp(session,'all')==1 || strcmp(file.name(5),num2str(session(1))) || strcmp(file.name(5),num2str(session(2)))
                                % trial number
                                if  strcmp(trial,'all')==1 || strcmp(file.name(7:end),trial)
                                    
                                    %here come the main analysis:
                                    fileName=file.name(1:5);
                                    sessionNum=str2num(file.name(7:length(file.name)-4));
                                    picName=shape; %'circle' 'triangle' etc
                                    [imdatas,chan_h_pix,chan_v_pix,chan_h, chan_v,saccade_vec, ~] =sacDiffAmos(cal,fileName,sessionNum,picName,doPlot);
                                    
                                    if ~isempty(find(saccade_vec{1,1}))
                                        notB_driftAngels=[];
                                        rel_bordersAngels=[];
                                        rel_saccAngels=[];
                                        rel_driftAngels=[];
                                        angleBetweenBorderDrift=[];
                                        angleBetweenSaccDrift=[];
                                        t=t+1;
                                        [row ,col]=find(saccade_vec{1,1});
                                        last=col(end);
                                        saccade_vec=saccade_vec{1,1}(:,1:last);
                                        XY_vec_pix=[chan_h_pix;chan_v_pix];
                                        XY_vec_deg=[chan_h;chan_v];
                                        imdata=imdatas{1};
                                        
                                        % 5. saccades - row 4(BIG)
                                        [labeled_saccade_vec,sacc_time_ms,sacc_amp_degrees,sacc_vel_deg2sec,sacc_maxvel_deg2sec]=typeOfSaccade(saccade_vec,XY_vec_pix,XY_vec_deg,imdata,res,analogType);                                        % 6. drifts -  row 5
                                        [labeled_saccade_vec,drift_time_ms,drift_dist_degrees,drift_amp_degrees,drift_vel_deg2sec]=drifts(labeled_saccade_vec,XY_vec_deg,XY_vec_pix,res,imdata,analogType);
                                        
                                        labeled_saccade_vecs{t}=labeled_saccade_vec;
                                        % saving only strait border drifts:
                                        if  size(labeled_saccade_vec,2)>2 && size(labeled_saccade_vec,1)>9
                                            
                                            Strait_notB=length(intersect(find(labeled_saccade_vec(4,:)==1),find(labeled_saccade_vec(9,:)==0)));
                                            Circle_notB=length(intersect(find(labeled_saccade_vec(4,:)==2),find(labeled_saccade_vec(9,:)==0)));
                                            Other_notB=length(intersect(find(labeled_saccade_vec(4,:)==3),find(labeled_saccade_vec(9,:)==0)));
                                            
                                            Strait=length(intersect(find(labeled_saccade_vec(4,:)==1),find(labeled_saccade_vec(9,:)==1)));
                                            Circle=length(intersect(find(labeled_saccade_vec(4,:)==2),find(labeled_saccade_vec(9,:)==1)));
                                            Other=length(intersect(find(labeled_saccade_vec(4,:)==3),find(labeled_saccade_vec(9,:)==1)));
                                            
                                            rel_bordersAngels=labeled_saccade_vec(10,intersect(find(labeled_saccade_vec(9,:)==1),find(labeled_saccade_vec(4,:)==1)));
                                            rel_saccAngels=labeled_saccade_vec(7,intersect(find(labeled_saccade_vec(9,:)==1),find(labeled_saccade_vec(4,:)==1)));
                                            rel_driftAngels=labeled_saccade_vec(8,intersect(find(labeled_saccade_vec(9,:)==1),find(labeled_saccade_vec(4,:)==1)));
                                            % %                                             rel_bordersAngels=labeled_saccade_vec(10,find(labeled_saccade_vec(4,:)==1));
                                            % %                                             rel_saccAngels=labeled_saccade_vec(7,find(labeled_saccade_vec(4,:)==1));
                                            notB_driftAngels=labeled_saccade_vec(8,find(labeled_saccade_vec(4,:)==1));
                                            
                                            rel_bordersAngels(rel_bordersAngels<0)=rel_bordersAngels(rel_bordersAngels<0)+180;
                                            rel_saccAngels(rel_saccAngels<0)=rel_saccAngels(rel_saccAngels<0)+180;
                                            rel_driftAngels(rel_driftAngels<0)=rel_driftAngels(rel_driftAngels<0)+180;
                                            notB_driftAngels(notB_driftAngels<0)=notB_driftAngels(notB_driftAngels<0)+180;
                                            
                                            angleBetweenBorderDrift=min(abs(rel_bordersAngels-rel_driftAngels),180-abs(rel_bordersAngels-rel_driftAngels));
                                            angleBetweenSaccDrift=min(abs(rel_saccAngels-rel_driftAngels),180-abs(rel_saccAngels-rel_driftAngels));
                                            
                                            %                                             angleBetweenBorderDrift=abs(rel_bordersAngels-rel_driftAngels);
                                            %                                             angleBetweenSaccDrift=abs(rel_saccAngels-rel_driftAngels);
                                            
                                            rel_bordersAngels(rel_bordersAngels>90)=180-rel_bordersAngels(rel_bordersAngels>90);
                                            rel_saccAngels(rel_saccAngels>90)=180-rel_saccAngels(rel_saccAngels>90);
                                            rel_driftAngels(rel_driftAngels>90)=180-rel_driftAngels(rel_driftAngels>90);
                                            notB_driftAngels(notB_driftAngels>90)=180-notB_driftAngels(notB_driftAngels>90);
                                            %                                             followSaccAngle=angleBetweenSaccDrift(angleBetweenBorderDrift<30);
                                            %                                             crossSaccAngle=angleBetweenSaccDrift(angleBetweenBorderDrift>60);
                                        end
                                        allCircle=allCircle+Circle;
                                        allOther=allOther+Other;
                                        allStrait=allStrait+Strait;
                                        allCircle_notB=allCircle_notB+Circle_notB;
                                        allOther_notB=allOther_notB+Other_notB;
                                        allStrait_notB=allStrait_notB+Strait_notB;
                                        alltrial_borderAngels=[alltrial_borderAngels rel_bordersAngels];
                                        alltrial_driftAngels=[alltrial_driftAngels rel_driftAngels];
                                        alltrial_notB_driftAngels=[alltrial_notB_driftAngels notB_driftAngels];
                                        alltrial_angleBetweenBorderDrift=[alltrial_angleBetweenBorderDrift angleBetweenBorderDrift];
                                        alltrial_angleBetweenSaccDrift=[alltrial_angleBetweenSaccDrift angleBetweenSaccDrift];
                                        %                                         alltrial_followSaccAngle=[alltrial_followSaccAngle followSaccAngle];
                                        %                                         alltrial_crossSaccAngle=[alltrial_crossSaccAngle crossSaccAngle];
                                    end
                                end
                            end
                        end
                    end
                end
                
            end
        end
        allSub_Other=allSub_Other+allOther;
        allSub_Circle=allSub_Circle+allCircle;
        allSub_Strait=allSub_Strait+allStrait;
        allSub_Other_notB=allSub_Other_notB+allOther_notB;
        allSub_Circle_notB=allSub_Circle_notB+allCircle_notB;
        allSub_Strait_notB=allSub_Strait_notB+allStrait_notB;
        allSub_borderAngels=[allSub_borderAngels alltrial_borderAngels];
        allSub_driftAngels=[allSub_driftAngels alltrial_driftAngels];
        allSub_notB_driftAngels=[allSub_notB_driftAngels alltrial_notB_driftAngels];
        allSub_angleBetweenBorderDrift=[allSub_angleBetweenBorderDrift alltrial_angleBetweenBorderDrift];
        allSub_angleBetweenSaccDrift=[allSub_angleBetweenSaccDrift alltrial_angleBetweenSaccDrift];
        allSub_followSaccAngle=[allSub_followSaccAngle alltrial_followSaccAngle];
        allSub_crossSaccAngle=[allSub_crossSaccAngle alltrial_crossSaccAngle];
        
        if strcmp(analog,'B')==1 || strcmp(analog,'S')==1 
%             figure(1)
%             hold on
%             subplot(2,6,sub_i)
%             histogram(alltrial_angleBetweenBorderDrift,0:binS:180);%,'Normalization','probability')
%             ylabel(' border - drift','FontSize', 20)
%             xlabel('Angle (deg)','FontSize', 20)
%             title(subjects)
%             %             axis([0 190 0 20])
%             
%             subplot(2,6,sub_i+6)
%             histogram(alltrial_angleBetweenSaccDrift,0:binS:180);%,'Normalization','probability')
%             ylabel(' saccade - drift','FontSize', 20)
%             xlabel('Angle (deg)','FontSize', 20)
%             %             axis([0 190 0 20])
%             
%             figure(2)
%             subplot(2,6,sub_i)
%             hold on
% %             histogram(alltrial_driftAngels,0:binS:180);%,'Normalization','probability')
%             plot(alltrial_borderAngels,alltrial_driftAngels,'.')
%             ylabel('drift not relative','FontSize', 20)
%             xlabel('Angle (deg)','FontSize', 20)
%             title(subjects)
            %             axis([0 190 0 20])
            
% %             subplot(2,6,sub_i+6)
% %             hold on
% %             histogram(alltrial_borderAngels,0:binS:180);%,'Normalization','probability')
% %             ylabel('border not relative','FontSize', 20)
% %             xlabel('Angle (deg)','FontSize', 20)
% %             title(subjects)
% %             %             axis([0 190 0 20])
% %             
% %             figure(4)
% %             subplot(2,6,sub_i)
% %             hold on
% %             histogram(alltrial_notB_driftAngels,0:binS:180);%,'Normalization','probability')
% %             ylabel('drift not relative','FontSize', 20)
% %             xlabel('Angle (deg)','FontSize', 20)
% %             title(subjects)
% %             %             axis([0 190 0 20])
            
            
            figure(10)
            hold on
            subplot(2,6,sub_i)
            S=allStrait+allCircle+allOther+allStrait_notB+allCircle_notB+allOther_notB;
            bar([allStrait,allCircle,allOther ; allStrait_notB,allCircle_notB,allOther_notB]);%./S)
            xlabel('Border      Not','FontSize', 20)
            ylabel(analog)
                        axis([0 3 0 400])
            
        else
% %             figure(3)
% %             subplot(2,6,sub_i)
% %             hold on
% %             histogram(alltrial_driftAngels,0:binS:180);%,'Normalization','probability')
% %             ylabel('drift not relative','FontSize', 20)
% %             xlabel('Angle (deg)','FontSize', 20)
% %             title(subjects)
% %             %             axis([0 190 0 5])
% %             
% %             subplot(2,6,sub_i+6)
% %             hold on
% %             histogram(alltrial_borderAngels,0:binS:180);%,'Normalization','probability')
% %             ylabel('border not relative','FontSize', 20)
% %             xlabel('Angle (deg)','FontSize', 20)
% %             title(subjects)
% %             %             axis([0 190 0 20])
            
            figure(10)
            hold on
            subplot(2,6,sub_i+6)
            S=allStrait+allCircle+allOther+allStrait_notB+allCircle_notB+allOther_notB;
            bar([allStrait,allCircle,allOther ; allStrait_notB,allCircle_notB,allOther_notB]);%./S)
            xlabel('Border      Not','FontSize', 20)
            ylabel(analog)
                                axis([0 3 0 100])
            
            
        end
        %     subplot(4,6,sub_i+12)
        %     histogram(alltrial_followSaccAngle,0:10:90,'Normalization','probability')
        %     ylabel(' saccade - (follow)drift','FontSize', 20)
        %     xlabel('Angle (deg)','FontSize', 20)
        %     axis([0 100 0 0.25])
        %
        %     subplot(4,6,sub_i+18)
        %     histogram(alltrial_crossSaccAngle,0:10:90,'Normalization','probability')
        %     ylabel(' saccade - (cross)drift','FontSize', 20)
        %     xlabel('Angle (deg)','FontSize', 20)
        %     axis([0 100 0 0.25])
        
    end
    if strcmp(analog,'B')==1 ||  strcmp(analog,'S')==1
%         figure(1)
%         subplot(2,6,6)
%         histogram(allSub_angleBetweenBorderDrift,0:binS:180);%,'Normalization','probability')
%         title('ALL')
%         xlabel('Angle (deg)','FontSize', 20)
%         ylabel(' border - drift','FontSize', 20)
%         %         axis([0 190 0 50])
%         
%         subplot(2,6,12)
%         histogram(allSub_angleBetweenSaccDrift,0:binS:180);%,'Normalization','probability')
%         title('ALL')
%         xlabel('Angle (deg)','FontSize', 20)
%         ylabel(' saccade - drift','FontSize', 20)
%         %         axis([0 190 0 50])
%         
%         figure(2)
%         subplot(2,6,6)
%         hold on
% %         histogram(allSub_driftAngels,0:binS:180);%,'Normalization','probability')
%         plot(allSub_borderAngels,allSub_driftAngels,'.')
%         ylabel('drift not relative','FontSize', 20)
%         xlabel('Angle (deg)','FontSize', 20)
%         title(subjects)
%         %         axis([0 190 0 70])
        
% %         subplot(2,6,12)
% %         hold on
% %         histogram(allSub_borderAngels,0:binS:180);%,'Normalization','probability')
% %         ylabel('border not relative','FontSize', 20)
% %         xlabel('Angle (deg)','FontSize', 20)
% %         title(subjects)
% %         %         axis([0 190 0 70])
        
% %         figure(4)
% %         subplot(2,6,6)
% %         hold on
% %         histogram(allSub_notB_driftAngels,0:binS:180);%,'Normalization','probability')
% %         ylabel('drift not relative','FontSize', 20)
% %         xlabel('Angle (deg)','FontSize', 20)
% %         title(subjects)
% %         %             axis([0 190 0 20])
        
        figure(10)
        hold on
        subplot(2,6,6)
        S=allSub_Strait+allSub_Circle+allSub_Other+allSub_Strait_notB+allSub_Circle_notB+allSub_Other_notB;
        bar([allSub_Strait,allSub_Circle,allSub_Other ; allSub_Strait_notB,allSub_Circle_notB,allSub_Other_notB]);%./S)
        xlabel('Border      Not','FontSize', 20)
        legend('Strait', 'Circle', 'Curved')
        %         axis([0 3 0 3200])
    else
% %         figure(3)
% %         subplot(2,6,6)
% %         hold on
% %         histogram(allSub_driftAngels,0:binS:180);%,'Normalization','probability')
% %         ylabel('drift not relative','FontSize', 20)
% %         xlabel('Angle (deg)','FontSize', 20)
% %         title(subjects)
% %         %         axis([0 190 0 11])
% %         
% %         subplot(2,6,12)
% %         hold on
% %         histogram(allSub_borderAngels,0:binS:180);%,'Normalization','probability')
% %         ylabel('border not relative','FontSize', 20)
% %         xlabel('Angle (deg)','FontSize', 20)
% %         title(subjects)
% %         %         axis([0 190 0 70])
        
        figure(10)
        hold on
        subplot(2,6,12)
        S=allSub_Strait+allSub_Circle+allSub_Other+allSub_Strait_notB+allSub_Circle_notB+allSub_Other_notB;
        bar([allSub_Strait,allSub_Circle,allSub_Other ; allSub_Strait_notB,allSub_Circle_notB,allSub_Other_notB]);%./S)
        xlabel('Border      Not','FontSize', 20)
        legend('Strait', 'Circle', 'Curved')
                axis([0 3 0 200])
    end
    
    % subplot(4,6,18)
    % histogram(allSub_followSaccAngle,0:10:90,'Normalization','probability')
    % ylabel(' saccade - (follow)drift','FontSize', 20)
    % xlabel('Angle (deg)','FontSize', 20)
    % axis([0 100 0 0.25])
    %
    % subplot(4,6,24)
    % histogram(allSub_crossSaccAngle,0:10:90,'Normalization','probability')
    % ylabel(' saccade - (cross)drift','FontSize', 20)
    % xlabel('Angle (deg)','FontSize', 20)
    % axis([0 100 0 0.25])
end

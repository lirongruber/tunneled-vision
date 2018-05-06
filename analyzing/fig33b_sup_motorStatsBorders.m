% new drift borders analysis

% clear
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
analogs={'NB', 'S'};%{'B', 'NB'};
kindaBlue=[0 .45 .7];
kindaBlue2=[.35 .7 .9];
kindaMag=[.8 .4 0];
kindaMag2=[.8 .6 .7];
colors={kindaBlue,kindaMag, kindaBlue2 ,kindaMag2};

figure(33)
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
for analog_i=1:2 %1:2
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
    
    allCircle_notB=0;
    allOther_notB=0;
    allStrait_notB=0;
    allCircle=0;
    allOther=0;
    allStrait=0;
    
    
    sub_i=0;
    for subjects= {'LB','LS','SM','RW','AS','ALL'} %,'LB','LS' ,'AS' ,'RW','SM'
        sub_i=sub_i+1;
        if strcmp(subjects,'ALL')==0
            Strait=0;
            Circle=0;
            Other=0;
            Strait_notB=0;
            Circle_notB=0;
            Other_notB=0;
            
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
                                                
                                                Strait_notB_i=intersect(find(labeled_saccade_vec(4,:)==1),find(labeled_saccade_vec(9,:)==0));
                                                Strait_notB=drift_vel_deg2sec(Strait_notB_i);
                                                Circle_notB_i=intersect(find(labeled_saccade_vec(4,:)==2),find(labeled_saccade_vec(9,:)==0));
                                                Circle_notB=drift_vel_deg2sec(Circle_notB_i);
                                                Other_notB_i=intersect(find(labeled_saccade_vec(4,:)==3),find(labeled_saccade_vec(9,:)==0));
                                                Other_notB=drift_vel_deg2sec(Other_notB_i);
                                                
                                                Strait_B_i=intersect(find(labeled_saccade_vec(4,:)==1),find(labeled_saccade_vec(9,:)==1));
                                                Strait_B=drift_vel_deg2sec(Strait_B_i);
                                                Circle_B_i=intersect(find(labeled_saccade_vec(4,:)==2),find(labeled_saccade_vec(9,:)==1));
                                                Circle_B=drift_vel_deg2sec(Circle_B_i);
                                                Other_B_i=intersect(find(labeled_saccade_vec(4,:)==3),find(labeled_saccade_vec(9,:)==1));
                                                Other_B=drift_vel_deg2sec(Other_B_i);
                                                
                                                %                                                 t_Strait_notB=drift_time_ms(Strait_notB_i);
                                                %                                                 t_Circle_notB=drift_time_ms(Circle_notB_i);
                                                %                                                 t_Other_notB=drift_time_ms(Other_notB_i);
                                                %
                                                %                                                 t_Strait_B=drift_time_ms(Strait_B_i);
                                                %                                                 t_Circle_B=drift_time_ms(Circle_B_i);
                                                %                                                 t_Other_B=drift_time_ms(Other_B_i);
                                                
                                            end
                                            allCircle=[allCircle Circle_B];
                                            allOther=[allOther Other_B];
                                            allStrait=[allStrait Strait_B];
                                            allCircle_notB=[allCircle_notB Circle_notB];
                                            allOther_notB=[allOther_notB Other_notB];
                                            allStrait_notB=[allStrait_notB Strait_notB];
                                            
                                            %                                             t_allCircle=[t_allCircle t_Circle_B];
                                            %                                             t_allOther=[t_allOther t_Other_B];
                                            %                                             t_allStrait=[t_allStrait t_Strait_B];
                                            %                                             t_allCircle_notB=[t_allCircle_notB t_Circle_notB];
                                            %                                             t_allOther_notB=[t_allOther_notB t_Other_notB];
                                            %                                             t_allStrait_notB=[t_allStrait_notB t_Strait_notB];
                                        end
                                    end
                                end
                            end
                        end
                    end
                    
                end
            end

            
            allSub_Other=[allSub_Other allOther];
            allSub_Circle=[allSub_Circle allCircle];
            allSub_Strait=[allSub_Strait allStrait];
            allSub_Other_notB=[allSub_Other_notB allOther_notB];
            allSub_Circle_notB=[allSub_Circle_notB allCircle_notB];
            allSub_Strait_notB=[allSub_Strait_notB allStrait_notB];
            
        else
 
            allOther= allSub_Other;
            allCircle=allSub_Circle;
            allStrait=allSub_Strait;
            allOther_notB=allSub_Other_notB;
            allCircle_notB=allSub_Circle_notB;
            allStrait_notB=allSub_Strait_notB;
        end
        
        %% velocity
        histB=1;%1
        vel_borders=[allOther allCircle allStrait];
        vel_Notborders=[allOther_notB allCircle_notB allStrait_notB];
        
        figure(33)
        if mod(analog_i,2)==1
            ext=0;
        else
            ext=6;
        end
        axes(ha33(sub_i+ext));
        
        figure(99)
        hold on
        h1=histogram(vel_borders,0:histB:20,'Normalization','probability','FaceColor','c');
        h2=histogram(vel_Notborders,0:histB:20,'Normalization','probability','FaceColor','b');
        %                 close(99)
        
        figure(33)
        yy1=smooth(h1.BinCounts./sum(h1.BinCounts));
        yy2=smooth(h2.BinCounts./sum(h2.BinCounts));
        plot(0:histB:20-histB,yy1,'Color',colors{analog_i})
        hold on
        plot(0:histB:20-histB,yy2,'Color',colors{analog_i+2})
        
        plot( mean(vel_borders)*[1,1,1,1,1], 0:0.1:0.4,'--','Color',colors{analog_i} )
        text(0.5,0.21,[num2str(round(mean(vel_borders),2)) '+-' num2str(round(ste(vel_borders),2))],'Color',colors{analog_i},'FontSize',20);
        plot( mean(vel_Notborders)*[1,1,1,1,1], 0:0.1:0.4,'--','Color',colors{analog_i+2} )
        text(0.5,0.18,[num2str(round(mean(vel_Notborders),2)) '+-' num2str(round(ste(vel_Notborders),2))],'Color',colors{analog_i+2},'FontSize',20);
        axis([ 0 15 0 0.25]);
        xlabel('Speed [deg/sec]','FontSize',20)
        title(subjects)
        
        if sub_i==6
            leg=legend('Border','Not-border');
            if analog_i<2
                set(leg,'FontSize', 15,'Position',[0.8890    0.8263    0.0556    0.0551]);
            else
                set(leg,'FontSize', 15,'Position',[0.8890    0.5263    0.0556    0.0551]);
            end
            legend boxoff
        end
        if sub_i==1
            ylabel('hist[norm]','FontSize',20)
        end
        
        curr_p=ranksum(vel_borders,vel_Notborders);
        p(analog_i,sub_i)=curr_p;
        if curr_p<0.05
            text(( mean(vel_borders)+mean(vel_Notborders))/2-0.4,0.20,'*','FontSize',25)
        end
        set(gca,'box','off')
        close(99)
    end
end
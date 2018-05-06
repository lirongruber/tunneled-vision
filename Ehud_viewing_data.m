
clear
close all

% what sub data do I want?
shape='parallelog'; % 'all' 'circle' 'parallelog' 'square' 'triangle' 'rectangle'
analog='B'; % 'all' 'B'  'S'  'NB' 'NS'
session='all'; % 'all' '1';
trial='all';% 'all' '1.mat';
coreectORwrong='c'; %'all' 'c' 'w';
cal=0;
t=0;

%extra:
onlyHighLevel=1;
levelThresHold=0.3;
% onlyGoodDrifts=1;
% driftType=[]; % 1 2 3 or [] for all

labeled_saccade_vecs={};
whiteTimes={};
nameOfFile=[shape 'Shape' analog 'Analog' session 'Session' trial 'Trial' coreectORwrong 'Answer'];
nameOfFile(regexp(nameOfFile,'[.]'))=[];

%general parameters:
res=0.01;% 0.01 sec
screen_dis=1;% meter
PIXEL2METER=0.000264583;
doPlot=0; %for sacDiffAmos
if strcmp(analog,'B') || strcmp(analog,'NB')
    analogType='B';
    %     analog_type=1; % '1' '2' for saccDiff
else if strcmp(analog,'S') || strcmp(analog,'NS')
        analogType='S';
        %         analog_type=2; % '1' '2' for saccDiff
    end
end

for subjects= {'LB','LS','SM','RW','AS'}; %,'LB','LS' ,'AS' ,'RW','SM'
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
                                [imdatas,chan_h_pix,chan_v_pix,chan_h, chan_v,saccade_vec, ~] =Ehud_sacDiffAmos(cal,fileName,sessionNum,picName,doPlot);
                                
                                if ~isempty(find(saccade_vec{1,1}))
                                    t=t+1
                                    [row ,col]=find(saccade_vec{1,1});
                                    last=col(end);
                                    saccade_vec{1,1}=saccade_vec{1,1}(:,1:last);
                                    saccade_vecs{t}=saccade_vec{1,1};
                                    XY_vecs_pix{t}=[chan_h_pix;chan_v_pix];
                                    XY_vecs_deg{t}=[chan_h;chan_v];
                                    
                                    saccade_vec=saccade_vecs{t};
                                    XY_vec_pix=XY_vecs_pix{t};
                                    XY_vec_deg=XY_vecs_deg{t};
                                    imdata=imdatas{1};
                                    [labeled_saccade_vec,sacc_time_ms,sacc_amp_degrees,sacc_vel_deg2sec,sacc_maxvel_deg2sec]=Ehud_typeOfSaccade(saccade_vec,XY_vec_pix,XY_vec_deg,imdata,res,analogType);                                        % 6. drifts -  row 5
                                    [labeled_saccade_vec,drift_time_ms,drift_dist_degrees,drift_amp_degrees,drift_vel_deg2sec]=Ehud_drifts(labeled_saccade_vec,XY_vec_deg,XY_vec_pix,res,imdata);
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

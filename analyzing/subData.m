% script for running different kinds of analysis on different sub groups of
% the data:
clear
close all


% what sub data do I want?
shape='parallelog'; % 'all' 'circle' 'parallelog' 'square' 'triangle' 'rectangle'
analog='S'; % 'all' 'B'  'S'  'NB' 'NS'
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

for subjects={'LB','LS','SM','RW','AS'}; %,'LB','LS' ,'AS' ,'RW','SM'
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
                                    t=t+1
                                    [row ,col]=find(saccade_vec{1,1});
                                    last=col(end);
                                    saccade_vec{1,1}=saccade_vec{1,1}(:,1:last);
                                    % 1.time of trial
                                    time_of_trial_in_sec{t}=length(chan_h)*res;
                                    % 2.number of sacc
                                    num_of_sacc{t}=length(saccade_vec{1,1});
                                    % 3. number of saccedes per sec
                                    num_of_sacc_per_sec{t}=num_of_sacc{t}./ time_of_trial_in_sec{t};
                                    
                                    saccade_vecs{t}=saccade_vec{1,1};
                                    XY_vecs_pix{t}=[chan_h_pix;chan_v_pix];
                                    XY_vecs_deg{t}=[chan_h;chan_v];
                                    
                                    saccade_vec=saccade_vecs{t};
                                    XY_vec_pix=XY_vecs_pix{t};
                                    XY_vec_deg=XY_vecs_deg{t};
                                    imdata=imdatas{1};
                                    
                                    % 4. Percent Time on Shape+Percent Whiteness
                                    [whiteTime]=trialLevel(XY_vec_pix,imdata,analogType);
                                    whiteTimes{t}=whiteTime;
                                    
                                    % 5. saccades - row 4(BIG)
                                    [labeled_saccade_vec,sacc_time_ms,sacc_amp_degrees,sacc_vel_deg2sec,sacc_maxvel_deg2sec]=typeOfSaccade(saccade_vec,XY_vec_pix,XY_vec_deg,imdata,res,analogType);                                        % 6. drifts -  row 5
                                    [labeled_saccade_vec,drift_time_ms,drift_dist_degrees,drift_amp_degrees,drift_vel_deg2sec]=drifts(labeled_saccade_vec,XY_vec_deg,XY_vec_pix,res,imdata,analogType);
                                    
                                    labeled_saccade_vecs{t}=labeled_saccade_vec;
                                    saccs_time_ms{t}=sacc_time_ms;
                                    saccs_amp_degrees{t}=sacc_amp_degrees;
                                    saccs_vel_deg2sec{t}=sacc_vel_deg2sec;
                                    saccs_maxvel_deg2sec{t}=sacc_maxvel_deg2sec;
                                    drifts_time_ms{t}=drift_time_ms;
                                    drifts_dist_degrees{t}=drift_dist_degrees;
                                    drifts_amp_degrees{t}=drift_amp_degrees;
                                    drifts_vel_deg2sec{t}=drift_vel_deg2sec;
                      
                                    %visit rates
                                    shapeForVisitRates=currFile.myimgfiles{1,1}{1,1};
                                    [finalPic]=visitRates(XY_vec_pix,imdata,analogType,shapeForVisitRates);
                                    
                                    if strcmp(shapeForVisitRates,'circle')
                                        finalPics{1}{t}=finalPic;
                                    else if strcmp(shapeForVisitRates,'triangle')
                                            finalPics{2}{t}=finalPic;
                                        else if strcmp(shapeForVisitRates,'square')
                                                finalPics{3}{t}=finalPic;
                                            else if strcmp(shapeForVisitRates,'rectangle')
                                                    finalPics{4}{t}=finalPic;
                                                else if strcmp(shapeForVisitRates,'parallelog')
                                                        finalPics{5}{t}=finalPic;
                                                    end ; end  ;end  ;end; end;
                                    
                                end
                            end
                        end
                    end
                end
            end
            
        end
    end
    
    if strcmp(shape,'all')
        finalPics{1}=finalPics{1}(~cellfun('isempty',finalPics{1}));
        finalPics{2}=finalPics{2}(~cellfun('isempty',finalPics{2}));
        finalPics{3}=finalPics{3}(~cellfun('isempty',finalPics{3}));
        finalPics{4}=finalPics{4}(~cellfun('isempty',finalPics{4}));
        finalPics{5}=finalPics{5}(~cellfun('isempty',finalPics{5}));
    else
        
    end
    %% saving

end

%% plotting
% SavingFileForPara=['C:\Users\bnapp\Documents\tunnelledVisionPaper\analyzing\resultsParameters\',nameOfFile];
% vecsForStatForsubData(analogType,t,time_of_trial_in_sec,num_of_sacc_per_sec,whiteTimes,saccs_amp_degrees,drifts_amp_degrees,saccs_vel_deg2sec,saccs_maxvel_deg2sec,drifts_vel_deg2sec,saccs_time_ms,drifts_time_ms)
numberOfRelevantTrials=t;
SavingFile=[['C:\Users\bnapp\Documents\tunnelledVisionPaper\analyzing\resultsVectors\' subjects{1} '\'] nameOfFile];
save(SavingFile,'numberOfRelevantTrials','labeled_saccade_vecs','XY_vecs_pix','XY_vecs_deg','whiteTimes',...
    'drifts_vel_deg2sec','drifts_dist_degrees','drifts_amp_degrees','drifts_time_ms',...
    'saccs_maxvel_deg2sec','saccs_vel_deg2sec','saccs_amp_degrees','saccs_time_ms',...
    'num_of_sacc_per_sec','num_of_sacc','time_of_trial_in_sec');
save([SavingFile 'FP'],'finalPics','-v7.3');

% %% extra pulling out data:
% % 1. only high trial levels
% 
% if onlyHighLevel==1
%     relCells=ones(1,length(XY_vecs_pix));
%     for i=1:length(XY_vecs_pix)
%         if whiteTimes{1,i}(1,1)>=levelThresHold
%             relCells(i)=1;
%         else
%             relCells(i)=0;
%         end
%     end
%     numberOfRelevantTrials=sum(relCells);
%     drifts_vel_deg2sec(:,relCells==0)=[];
%     drifts_amp_degrees(:,relCells==0)=[];
%     drifts_time_ms(:,relCells==0)=[];
%     saccs_vel_deg2sec(:,relCells==0)=[];
%     saccs_maxvel_deg2sec(:,relCells==0)=[];
%     drifts_dist_degrees(:,relCells==0)=[];
%     saccs_amp_degrees(:,relCells==0)=[];
%     saccs_time_ms(:,relCells==0)=[];
%     num_of_sacc_per_sec(:,relCells==0)=[];
%     num_of_sacc(:,relCells==0)=[];
%     time_of_trial_in_sec(:,relCells==0)=[];
%     labeled_saccade_vecs(:,relCells==0)=[];
%     XY_vecs_pix(:,relCells==0)=[];
%     XY_vecs_deg(:,relCells==0)=[];
%     whiteTimes(:,relCells==0)=[];
%     
%     %     SavingFileForPara=[SavingFileForPara,'EXTRA'];
%     SavingFile=[SavingFile,'EXTRA'];
%     %     vecsForStatForsubData(analogType,numberOfRelevantTrials,time_of_trial_in_sec,num_of_sacc_per_sec,whiteTimes,saccs_amp_degrees,drifts_amp_degrees,saccs_vel_deg2sec,saccs_maxvel_deg2sec,drifts_vel_deg2sec,saccs_time_ms,drifts_time_ms);
%     save(SavingFile,'numberOfRelevantTrials','labeled_saccade_vecs','XY_vecs_pix','XY_vecs_deg','whiteTimes',...
%         'drifts_vel_deg2sec','drifts_dist_degrees','drifts_amp_degrees','drifts_time_ms',...
%         'saccs_maxvel_deg2sec','saccs_vel_deg2sec','saccs_amp_degrees','saccs_time_ms',...
%         'num_of_sacc_per_sec','num_of_sacc','time_of_trial_in_sec');
%     
% end
% %% extra pulling out data:
% % 2. only rellvant drifts (no 'no drifts')+different types
% % 3. only 'loops' where the sensory part is not 0

% if onlyGoodDrifts==1 || isempty(driftType)==0
%     % specifing type 1 2 or 3
%     L=labeled_saccade_vecs;
%     if isempty(driftType)==0
%         for i=1:length(SM_values)
%             SM_values{1,i}(:,L{1,i}(4,1:end-1)~=driftType)=[];
%             labeled_saccade_vecs{1,i}(:,L{1,i}(4,1:end-1)~=driftType)=[];
%         end
%     end
%     for i=1:length(SM_values)
%         % SM_value
%         % row 1:2 saccade motor 3:4 drift motor (amp+vel)
%         % row 5:6 saccade sensory 7:8 drift sensory (sum +diff sum)
%         SMA=SM_values{1,i}(1,:)'; % saccase motor amplitude
%         SMV=SM_values{1,i}(2,:)'; % saccade motor velocity
%         DMA=SM_values{1,i}(3,:)'; % drift motor amplitude
%         DMV=SM_values{1,i}(4,:)'; % drift motor velocity
%         SSS=SM_values{1,i}(5,:)'; % saccade senosory sum
%         SSD=SM_values{1,i}(6,:)'; % saccade senosory dif
%         DSS=SM_values{1,i}(7,:)'; % drift senosory sum
%         DSD=SM_values{1,i}(8,:)'; % drift senosory dif
%
% %         [corrMatrix]=corrSMS(SMA,SMV,DMA,DMV,SSS,SSD,DSS,DSD);
%         corrMatrix=[];
%         corrMatrixs{i}=corrMatrix;
%     end
%     SavingFile=[SavingFile,'DRIFT',num2str(driftType)];
%     save(SavingFile,'SM_values','SM_interDrift_values','corrMatrixs');
% end
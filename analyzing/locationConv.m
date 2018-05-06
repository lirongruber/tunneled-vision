%location convergence:
clear
close all

% what sub data do I want?
shape='all'; % 'all' 'circle'
black='without';% 'with' , 'without'
analog='B  '; % 'all' 'B  ' 'SAF' 'S  ' 'A  ' 'F  ' 'M  ' 'V  '  !! always 3 chars!!
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
nameOfFile=[shape 'Shape' black 'Black' analog 'Analog' session 'Session' trial 'Trial' coreectORwrong 'Answer'];
nameOfFile(regexp(nameOfFile,'[.]'))=[];

%general parameters:
res=0.01;% 0.01 sec
screen_dis=1;% meter
PIXEL2METER=0.000264583;
doPlot=0; %for sacDiffAmos
if strcmp(analog,'B  ')
    analog_type=1; % '1' '2' for saccDiff
else
    analog_type=2; % '1' '2' for saccDiff
end

for subjects= {'MS','RP' , 'NA' ,'SG'}; %{'MS','RP' , 'NA' ,'SG'};
    f=fullfile('C:\Users\lirongr\Documents\actvie-vision\analyzing\cleanedData\', subjects);
    files = dir(f{1,1});
    
    
    for file = files'
        if strcmp(file.name,'.')==0 && strcmp(file.name,'..')==0
            currFile = load(file.name);
            % shape
            if  strcmp(shape,'all')==1 || strcmp(currFile.myimgfiles{1,1}{1,1},shape)
                %black trials
                if strcmp(black,'with')==1 || (strcmp(currFile.myimgfiles{1,1}{1,1},'black')==0 && strcmp(black,'without')==1)  || (strcmp(currFile.myimgfiles{1,1}{1,1},'black')==1 && strcmp(black,'only')==1)
                    % correct\wrong only
                    if  strcmp(currFile.myimgfiles{1,1}{1,1},'black')==1 || strcmp(coreectORwrong,'all')==1 || ((strcmp(coreectORwrong,'c') && max(currFile.iscorrects{1,1})==1 ) || (strcmp(coreectORwrong,'w') && max(currFile.iscorrects{1,1})==0 ))
                        % analog type
                        if  strcmp(analog,'all')==1 ||  strcmp(file.name(4),analog(1)) || strcmp(file.name(4),analog(2)) || strcmp(file.name(4),analog(3))
                            % session number
                            if  strcmp(session,'all')==1 || strcmp(file.name(5),session)
                                % trial number
                                if  strcmp(trial,'all')==1 || strcmp(file.name(7:end),trial)
                                    
                                    %here come the main analysis:
                                    fileName=file.name(1:5);
                                    sessionNum=str2num(file.name(7:length(file.name)-4));
                                    picName=shape; %'circle' 'triangle' etc
                                    [imdatas,chan_h_pix,chan_v_pix,chan_h, chan_v,saccade_vec, ~] =sacDiffAmos(cal,fileName,sessionNum,picName,doPlot);
                                    t=t+1;
                                    [row ,col]=find(saccade_vec{1,1});
                                        last=col(end);
                                        saccade_vec{1,1}=saccade_vec{1,1}(:,1:last);
                                    XY_vecs_pix{t}=[chan_h_pix;chan_v_pix];
                                    XY_vecs_deg{t}=[chan_h;chan_v];
                                    
                                    if isfield(currFile, 'mostVisitedLoc')
                                        mostVisitedLoc=currFile.mostVisitedLoc;
                                        if strcmp(currFile.myimgfiles{1,1}{1,1},'square')
                                            mostVisitedLoc2=currFile.mostVisitedLoc2;
                                        end
                                    else
                                        imshow(imdatas{1,1})
                                        prompt = 'What is the X value? ';
                                        x = input(prompt);
                                        prompt = 'What is the Y value? ';
                                        y = input(prompt);
                                        mostVisitedLoc=[x,y];
                                        save(file.name, 'mostVisitedLoc', '-append')
                                        if strcmp(currFile.myimgfiles{1,1}{1,1},'square')
                                            prompt = 'What is the X value? ';
                                            x2 = input(prompt);
                                            prompt = 'What is the Y value? ';
                                            y2 = input(prompt);
                                            mostVisitedLoc2=[x,y];
                                            save(file.name, 'mostVisitedLoc2', '-append')
                                        end
                                    end
                                    
                                    whereToCut=0.5;
                                    
                                    firstPart=XY_vecs_pix{t}(:,1:floor(length((XY_vecs_pix{t})).*whereToCut));
                                    secondPart=XY_vecs_pix{t}(:,floor(length((XY_vecs_pix{t})).*whereToCut)+1:end);
                                    for i=1:length(firstPart)
                                        distFirst{t}(i)= EUDist (firstPart(:,i)',mostVisitedLoc);
                                    end
                                    for i=1:length(secondPart)
                                        distSecond{t}(i)= EUDist (secondPart(:,i)',mostVisitedLoc);
                                    end
                                    if strcmp(currFile.myimgfiles{1,1}{1,1},'square')
                                        for i=1:length(firstPart)
                                            distFirst2{t}(i)= EUDist (firstPart(:,i)',mostVisitedLoc2);
                                            distFirst{t}(i)=min(distFirst{t}(i),distFirst2{t}(i));
                                        end
                                        for i=1:length(secondPart)
                                            distSecond2{t}(i)= EUDist (secondPart(:,i)',mostVisitedLoc2);
                                            distSecond2{t}(i)=min(distSecond{t}(i),distSecond2{t}(i));
                                        end
                                    end
                                    clear('mostVisitedLoc');
                                    saccade_vecs{1,t}=saccade_vec;
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
for i=1:length(distFirst)
    meanPerTrialDistFirst(i)=mean(distFirst{1,i});
end
for i=1:length(distSecond)
    meanPerTrialDistSecond(i)=mean(distSecond{1,i});
end
meanAllFirst=mean(meanPerTrialDistFirst)
meanAllSecond= mean(meanPerTrialDistSecond)
% 
% for i=1:length(distFirst)
% plot([distFirst{1,i} distSecond{1,i}])
% prompt = 'next? ';
% a = input(prompt);
% end
minDriftTimeMs=40; % x*10 milsec
minLengthofDrift=0.15;% in degrees!
for t=1:length(distFirst)
    dists=[distFirst{1,t} distSecond{1,t}];
    
    for i=1:length(saccade_vecs{1,t}{1,1})-1
        driftDist{1,t}{1,i}=dists(((saccade_vecs{1,t}{1,1}(1,i)+saccade_vecs{1,t}{1,1}(2,i)):saccade_vecs{1,t}{1,1}(1,i+1)));
        temp=[];
        temp=(XY_vecs_deg{1,t}(:,((saccade_vecs{1,t}{1,1}(1,i)+saccade_vecs{1,t}{1,1}(2,i)):saccade_vecs{1,t}{1,1}(1,i+1)))');
        [len,~,~] = EULength(temp);
        drift_time_ms{1,t}(i)=length(temp)*0.01*1000; % x*10 milsec
        
        drift_amp_degrees{1,t}(i)=len;
        drift_vel_deg2sec{1,t}(i)=drift_amp_degrees{1,t}(i)/(drift_time_ms{1,t}(i)/1000);
        
        if drift_amp_degrees{1,t}(i)> 10 || drift_amp_degrees{1,t}(i)<minLengthofDrift || drift_time_ms{1,t}(i)< minDriftTimeMs
            drift_amp_degrees{1,t}(i)=0;
            drift_vel_deg2sec{1,t}(i)=0;
            drift_time_ms{1,t}(i)=0;
        end
    end
end
final=0;
for t=1:length(distFirst)
    for i=1:length(saccade_vecs{1,t}{1,1})-1
        final=final+1;
        dd(final)=mean(driftDist{1,t}{1,i});
        dv(final)=drift_vel_deg2sec{1,t}(1,i);
        da(final)=drift_amp_degrees{1,t}(1,i);
        dt(final)=drift_time_ms{1,t}(1,i);

        %         hold on
        %         prompt = 'next? ';
        %         a = input(prompt);
    end
end
plot(dd,dv,'.')
figure;
plot(dd,da,'.')
figure;
plot(dd,dt,'.')
tilefigs;

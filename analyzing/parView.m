% show what participent viewed: -  video RECORDING!
clear
clc
close all


fileName='LB_S5';
sessionNum=1;

fileName='LB_B1';
sessionNum=6;
picName='triangle';
video=1;

% if nargin=2 : all sessions. if nrgin=3: the trials with the specific shape! !
[dataLens,times,calLens,gazesX,gazesY,fixs,pds,myimgfiles,imdatas,gazesX_cal,gazesY_cal,answers,iscorrects,missedSampless]=loadAndFix(fileName,sessionNum);%,picName);

sessionNum=max(size(dataLens));

for i=1:sessionNum
    gaze{i}=[gazesX{1,i} ; gazesY{1,i}];
end

ms=158;% fovea size(length of the square) in pixels=sqrt(picArea/13) .....picture area is ~13 times the fovea area
% ms=10;
wideSetup=[1 3/2 0]; % the 3 fingers setup - fovea in the middle and periphery on two sides - first: 0\1 second: x/y  proportion
for session_number=1:sessionNum
    for i=1:(dataLens{1,session_number})
        if wideSetup(1)==1
            myrect{session_number}{i}=[gaze{1,session_number}(1,i)-(ms/(1+1/wideSetup(2))) gaze{1,session_number}(2,i)-(ms/(1+wideSetup(2))) gaze{1,session_number}(1,i)+(ms/(1+1/wideSetup(2)))+1 gaze{1,session_number}(2,i)+(ms/(1+wideSetup(2)))+1]; % center dRect on current position
        else
            myrect{session_number}{i}=[gaze{1,session_number}(1,i)-(ms/2) gaze{1,session_number}(2,i)-(ms/2) gaze{1,session_number}(1,i)+(ms/2)+1 gaze{1,session_number}(2,i)+(ms/2)+1]; % center dRect on current position
        end
    end
end


%with screen
TIME_RES=0.01*4;
screenNumber = 2;
pixelSize=32;
windowSize = [];
% Screen('Preference', 'SkipSyncTests', 1);% for the other screen (number 2)
% Screen('Preference', 'SuppressAllWarnings', 1);
% Screen('Preference', 'VisualDebuglevel', 3); % avoid Psychtoolbox's welcome screen
% [w, windowRect]=Screen('OpenWindow',screenNumber, 0,windowSize,pixelSize,2);
[wH, wW]=size(imdatas{1,1});
% [wW, wH]=WindowSize(w);
% wH=1080; %need only in my office comp - because the screen is larger!
figure('units','normalized','outerposition',[0 0 1 1])
for session_number=1:sessionNum
    if video==1
        f=0;
%         movie = Screen('CreateMovie', w,[fileName '_' num2str(session_number) '_V' '.avi'], wW, wH, 25);
    end
    pic=imdatas{1,session_number};
%     pic=Screen('MakeTexture', w, pic);
%     Rect=Screen('Rect', pic); % the mask size....
%     Screen('DrawTexture', w, pic,[], Rect);
%     
%     Screen('Flip', w);
    for i=1:4:(dataLens{1,session_number})/3
        currStepTime= GetSecs;
        y1=max(1,round(myrect{session_number}{i}(2))); y1=min(y1,wH);
        y2=max(1,round(myrect{session_number}{i}(4))); y2=min(y2,wH);
        x3=max(1,round(myrect{session_number}{i}(1))); x3=min(x3,wW);
        x4=max(1,round(myrect{session_number}{i}(3))); x4=min(x4,wW);
        
        smallimdata=imdatas{1,session_number}(y1:y2,x3:x4);
        smallimdata_forFull=smallimdata;
        smallimdata_forFull(1:2,:)=255;  smallimdata_forFull(:,1:2)=255;
        s=size(smallimdata_forFull);
        smallimdata_forFull(s(1)-1:s(1),:)=255;  smallimdata_forFull(:,s(2)-1:s(2))=255;
        
        currimdata=imdatas{1,session_number};
        currimdata_forFull=currimdata;
        currimdata(:,:)=0;
        if y1~=y2 && x3~=x4
        currimdata(y1:y2,x3:x4)=smallimdata;
        currimdata_forFull(y1:y2,x3:x4)=smallimdata_forFull;
        end
        imshow([currimdata currimdata_forFull])
%         imshow([currimdata(220:860,500:1500) currimdata_forFull(220:860,500:1500)])

        f=f+1;
        M(f) = getframe(gca);
%         currimdata=Screen('MakeTexture', w, currimdata);
%         dataRect=Screen('Rect', currimdata); % the mask size....
%         Screen('DrawTexture', w, currimdata, [], dataRect);
        
        if video==1
            %             Screen('AddFrameToMovie', w, CenterRect([0 0 wW wH], Screen('Rect', screenNumber)), 'backBuffer');
        end
%         Screen('Flip', w);
        if    (GetSecs -currStepTime )< TIME_RES
            WaitSecs(TIME_RES-(GetSecs -currStepTime)); %if every loop will be less than 0.01sec
        end
    end
    if video==1
        %         Screen('FinalizeMovie', movie);
        myVideo = VideoWriter('ccc.avi');
        myVideo.Quality = 100;
        myVideo.FrameRate = 40;
        open(myVideo);
        writeVideo(myVideo, M);
        close(myVideo);
    end
end

Screen('CloseAll');

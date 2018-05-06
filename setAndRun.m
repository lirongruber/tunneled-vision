% setting the parameters and running exp!
%%this script is the one to use when running exp!
clear 
close all
clc

exp_type=1;%1 for tracking the gaze  ,2 for following old recordngs
analog_type=1; % 1 for foveal , 2 for receptors
practice=0;%1 for practice mode with gray stars. [exp=PP]

small_star=practice; % (only when practice==1!) for practice with small star
motor_task=practice; %  (only when practice==1 and small_star==1 !) for motor task - seeing image and exploring
low_con_control=practice; % (only when practice==1 and small_star==1  and motor_task==1 !) 1 if  control- low contrass shape %  
video=0; % to create a video - only using exp2 - not live!! WORKS SLOWLY!


memory_exp=0;% 1 for memory with shapes  2 for memory without anything

%subject=initials of subjects name - big letters.
subject='AA';%name of subject % AA defult exp1, BB defult exp2
exp='AA'; % name of experiment - subject+exp=not more than 4 letters for the EDF 
%[S#/B#-original small/big exp],[N# - for natural big], [n# for natural small] 
domEye='r'; % r or l

if exp_type==2
    %detailes of recorded session being viewed:
    oldFileName='IN_M1'; %only name subject+exp - no seesion num!!
end

%PARAMETERS:
eyetracking =0;% 0 for mouse tracking
largeScreen=1; %screen mode - if 0 than small screen for debug
doPlot=1;  
SESSION_NUM=1;
SESSION_MAX_LENGTH=0.5; %minutes
if low_con_control==1
    SESSION_MAX_LENGTH=0.05; %minutes
end
TIME_RES=0.01; %10 milsec resulotion .
TotalSessionTime=SESSION_MAX_LENGTH*60;%in seconds!
%TotalSessionTime=SESSION_MAX_LENGTH*60/TIME_RES;% total time in milsec (10milsec)
TimeToStart= 0; %(10 milsec) = sec
MAX_DATA_SIZE=TotalSessionTime/TIME_RES;% total time in milsec (10milsec);

% SET THE SCREEN SETTING
if analog_type==1
    ms=158;% fovea size(length of the square) in pixels=sqrt(picArea/19.5) .....picture area is ~19.5 times the fovea area
else
    ms=10;%70
end
wideSetup=[1 3/2 0]; % the 3 fingers setup - fovea in the middle and periphery on two sides - first: 0\1 second: x/y  proportion
% third : the small periphery setup == method :  1=pyramids , 2= low
% pass(not working)
screenNumber = 0; % the smaller on the left
maskPara=0; % original 3.2 0 is for no gausian - all fovea . for 'masking'
pixelSize=32;%original 32 for 'openWindow'

%% The Psychtoolbox command AssertOpenGL will issue an error message if
%%someonen
%%tries to execute this script on a computer without an OpenGL
%%Psychtoolbox:
%AssertOpenGL;
%%sometimes needed for multi-screen mode:
Screen('Preference', 'SkipSyncTests', screenNumber);% for the other screen (number 2)
Screen('Preference', 'SuppressAllWarnings', screenNumber);

%%
% experiment : active vision: recognizing picture with only the fovea
fileName=[subject '_' exp];
SavingPath=whichComp;
if exp_type==2
    SavingPath=[SavingPath 'data_viewing_exp\'];
end
keyboardNum=GetKeyboardIndices;
if exp_type==1
    defult_name='AA_AA';
end
if exp_type==2
    defult_name='BB_BB';
end


if practice==1
    picsNames={'Star.jpg' , 'Star.jpg' , 'Star.jpg' ,'Star.jpg' , 'Star.jpg','Star.jpg' , 'Star.jpg' , 'Star.jpg' ,'Star.jpg' , 'Star.jpg' } ;
    NamesForAns={'small_Star.jpg' , 'circle.jpg' , 'triangle.jpg' ,'Star.jpg' , 'square.jpg' } ;
    if small_star==1
        picsNames={'small_Star.jpg' ,'small_Star.jpg' ,'small_Star.jpg' ,'small_Star.jpg' ,'small_Star.jpg' ,'small_Star.jpg' ,'small_Star.jpg' ,'small_Star.jpg' ,'small_Star.jpg' ,'small_Star.jpg' };
    end
    if motor_task==1
        picsNames={  'square.jpg','parallelog.jpg', 'rectangle.jpg'  , 'triangle.jpg','circle.jpg' ,'circle.jpg' , 'square.jpg'  , 'triangle.jpg'  , 'rectangle.jpg' , 'parallelog.jpg'} ;
        NamesForAns={'circle.jpg' , 'square.jpg'  , 'triangle.jpg'  , 'rectangle.jpg' , 'parallelog.jpg','black.jpg'} ;
    end
else
    %picsNames={'clocksmall.jpg' } ;
    %picsNames={'chair.jpg' , 'clock.jpg'  , 'hat.jpg'  , 'shoe.jpg' , 'trashcan.jpg'} ;
    %picsNames={'cats.jpg' , 'kangaroo.jpg'  , 'rabbits.jpg'  , 'monkeys.jpg' , 'swans.jpg'} ;
    picsNames={  'square.jpg','parallelog.jpg', 'rectangle.jpg'  , 'triangle.jpg','circle.jpg','black.jpg' ,'circle.jpg' , 'square.jpg'  , 'triangle.jpg'  , 'rectangle.jpg' , 'parallelog.jpg','black.jpg'} ;
    NamesForAns={'circle.jpg' , 'square.jpg'  , 'triangle.jpg'  , 'rectangle.jpg' , 'parallelog.jpg','black.jpg'} ;
    %     picsNames={ 'L.jpg'  ,'Trapeze.jpg', 'moon.jpg' , 'black.jpg','arrow.jpg' , 'heart.jpg'  , 'L.jpg'  , 'moon.jpg' , 'heart.jpg', 'Trapeze.jpg','black.jpg','arrow.jpg' } ;
    %     NamesForAns={'arrow.jpg' , 'heart.jpg'  , 'L.jpg'  , 'moon.jpg' , 'Trapeze.jpg','black.jpg'} ;
end
%[picOrder]=randOrder(SESSION_NUM, picsNames);
comp=whichComp;
if strcmp(comp,'C:\Users\lirongruber\Documents\weizmann\MASTER_PROJECT\data\')%computer at home knows only small S!
    [picOrder]=shuffle(1:SESSION_NUM);
    picsNames=picsNames(1:SESSION_NUM);
    [picOrder]=picsNames(picOrder);
else
    [picOrder]=Shuffle(1:SESSION_NUM);
    picsNames=picsNames(1:SESSION_NUM);
    [picOrder]=picsNames(picOrder);
end
if strcmp(picOrder(1),'black.jpg')
    picOrder(1)=picOrder(2);
    picOrder{2}='black.jpg';
end
mouseNum=GetMouseIndices;

if largeScreen
    windowSize = [];
else
    windowSize = [0 0 300 300];
end

white=WhiteIndex(screenNumber);
black=BlackIndex(screenNumber);
gray=GrayIndex(screenNumber); % returns as default the mean gray value of screen

backgroundcolor = black;

Screen('Preference', 'VisualDebuglevel', 3); % avoid Psychtoolbox's welcome screen
[w, windowRect]=Screen('OpenWindow',screenNumber, 0,windowSize,pixelSize,2);
[wW, wH]=WindowSize(w);

if eyetracking==1
    Eyelink('initialize'); % might be needed after stop recording??? than- inside the following loop
    [el]= calibration(w,backgroundcolor,mouseNum,domEye);
    fix=[0,0];
end

%%starting exp
globalClock = GetSecs;

for session_num=1:SESSION_NUM; % 12 session
    SavingFile=[SavingPath fileName '_'  num2str(session_num)  '.mat'];
    if session_num==1
        nameError(fileName,defult_name,session_num,keyboardNum);
    end
    if eyetracking
        edfFile=[subject exp num2str(session_num)  '.edf'];% EDF reasons for short names (max 6)
    end
    disp ( 'waiting to start session:   ' )
    disp(num2str(session_num))
    if exp_type==1
        % picture settings per session:
        myimgfile= picOrder{1,session_num}; % rellevant picture
        %%%%%%%%%%%%%%%%%%%myblurimgfile= 'white.jpg'; % background picture!
    end
    if exp_type==2
        % picture settings per session:
        [dataLen,X,Y,myimgfile,oldPic]=loadOldFile(oldFileName,session_num);
        X=[0 X];
        Y=[0 Y];
    else
        oldPic=[];
        %%%%%%%%%%%%%%%%%%%myblurimgfile= 'white.jpg'; % background
        %%%%%%%%%%%%%%%%%%%picture!
    end
    
    % Load and process image file:
    [imdata,imdatablur,newfoveaRect,masktex,nonfoveatex]=imagePro(backgroundcolor,myimgfile,w,wH,wW,windowRect,ms,maskPara,wideSetup,exp_type,memory_exp,analog_type,oldPic,practice,low_con_control);
    
    %empty vectors to fill:
    pd=zeros(1,MAX_DATA_SIZE); %pupil size
    gazeX=zeros(1,MAX_DATA_SIZE);
    gazeY=zeros(1,MAX_DATA_SIZE);
    sacVel=zeros(1,MAX_DATA_SIZE); %velocity
    acc=zeros(1,MAX_DATA_SIZE); %acceleration
    sacLen=zeros(1,MAX_DATA_SIZE);%saccads size
    missedSamples=zeros(1,MAX_DATA_SIZE);
    timeCompleted=zeros(1,MAX_DATA_SIZE);
    pd_cal= zeros(1,300000);
    gazeX_cal= zeros(1,300000);
    gazeY_cal= zeros(1,300000);
   HideCursor;
    
    % Set background color to  and do initial flips:
    Screen('FillRect', w, backgroundcolor);
    Screen('TextSize',w,20);
    % fonts:
    Screen('TextSize',w,50);
    % for video recordings:
    if video==1
        movie = Screen('CreateMovie', w,[oldFileName '_' num2str(session_num) '.avi'], wW, wH, 100);
    end
    %
    if eyetracking==1
        [a,b,eyeused]=ELInit(eyetracking,w,edfFile);
        [pd_cal,gazeX_cal,gazeY_cal,fix]=calibVer(analog_type,w,wW,wH,backgroundcolor,mouseNum,TIME_RES,eyeused,pd_cal,gazeX_cal,gazeY_cal,fix);
        if session_num==1
            firstFix=fix;
        end
    end
    
    if exp_type==1
        if memory_exp==1 || memory_exp==2
            DrawFormattedText(w, 'Get ready - click mouse to START \n \n \n use the mouse to redraw your eye movements \n \n  while exploring the last object','center','center',[25 140 230]);
        else if low_con_control==1
                [nx,ny,~]=DrawFormattedText(w, 'Get ready - click mouse to START  \n \n and  observe the shape  \n \n','center','center',[25 140 230]);
            else
                [nx,ny,~]=DrawFormattedText(w, 'Get ready - click mouse to START  \n \n and  click again to STOP  \n \n','center','center',[25 140 230]);
            end
                if session_num==SESSION_NUM-1
                    DrawFormattedText(w, '(only 2 more...)',nx,ny,[0 200 0]);
                end
        end
    end
    if exp_type==2
        %screen_capture([SavingPath fileName '_'  num2str(session_num) ],45) % only when recording
        DrawFormattedText(w, 'Get ready - click mouse to START \n \n and follow the window','center','center',[25 140 230]);
    end
    
    %    screen('DrawingFinished', w);
    if video==1
        for i=1:100
            Screen('AddFrameToMovie', w, CenterRect([0 0 wW wH], Screen('Rect', screenNumber)), 'backBuffer');
        end
    end
    Screen('Flip',w);
    
    while  KbCheck(mouseNum)==0 % waits for mouse click
    end
    
    pause(2)
    if memory_exp==1 || memory_exp==2
        ShowCursor;
        DrawFormattedText(w, 'Drag the mouse to the \n \n CENTER of the screen \n \n and CLICK','center','center',[25 140 230]);
        Screen('DrawingFinished', w);
        Screen('Flip',w);
        while  KbCheck(mouseNum)==0 % waits for mouse click
        end
        %         HideCursor;
        pause(2)
    end
    
    if memory_exp==0
        DrawFormattedText(w, '+','center','center',[25 140 230]);
        %    screen('DrawingFinished', w);
        Screen('Flip', w);
        %         ShowCursor; % for debugging exp with mouse
        pause(2) % for fixation in the middle of the screen
        %         HideCursor; % for debugging exp with mouse
    end
    
    %Initialize:
    
    %     if eyetracking==1
    %         [a,b,eyeused]=ELInit(eyetracking,w,edfFile);
    %     end
    i=1;
    mxold=0;
    myold=0;
    
    if practice==1 || memory_exp==1
        Screen('BlendFunction', w, GL_ONE, GL_ZERO);
        Screen('DrawTexture', w, nonfoveatex, [], newfoveaRect);
        %screen('DrawingFinished', w);
        oldvbl=Screen('Flip', w);
    else
        Screen('BlendFunction', w, GL_ONE, GL_ZERO);
        Screen('FillRect', w, [backgroundcolor backgroundcolor backgroundcolor 0 ]);
        %screen('DrawingFinished', w);
        oldvbl=Screen('Flip', w);
    end
    disp ( 'starting session    ' )
    disp(num2str(session_num))
    
    
    if exp_type==1
        i_max=MAX_DATA_SIZE;
    end
    if exp_type==2
        i_max=dataLen ;
    end
    if strcmp(myimgfile,'black.jpg')
    i_max=floor(MAX_DATA_SIZE/3);
    end
    
    sessionClock=GetSecs;
    
    %     %% temp - screen timimg
    %     Datapixx('Open'); % Open Datapixx
    %     %%
    while  i<=i_max % every session (shape)
        tic
        currStepTime= GetSecs;
        cSTime(i)=currStepTime;
        if eyetracking==1
            sample = Eyelink('NewestFloatSample');
            
            %             %% temp - screen timimg
            %             t0 = Datapixx('getTime');
            %             T0(i)=t0;% Get initial time
            %             %%
            
            pd(i) = sample.pa(eyeused);
            gazeX(i) = sample.gx(eyeused);
            gazeY(i) = sample.gy(eyeused);
            if  memory_exp==1 || memory_exp==2
                [mx, my]=GetMouse(screenNumber);
            else
                mx= gazeX(i);
                my= gazeY(i);
            end
            mx=mx-fix(1);
            my=my-fix(2);
            gazeX(i)=mx; % for the saving!
            gazeY(i)=my; %for the saving!
        else if eyetracking==0
                [mx, my]=GetMouse(screenNumber);
                gazeX(i) = mx;
                gazeY(i) = my;
            end
        end
        if i>1
            sacVel(i)=EUVelocity([mx my ;mxold myold],TIME_RES);
            sacLen(i)=EUDist([mx my ],[mxold myold]);
        end
        if exp_type==1
            currx=mx;
            curry=my;
            oldx=mxold;
            oldy=myold;
        end
        if exp_type==2
            currx=X(i+1);
            curry=Y(i+1);
            oldx=X(i);
            oldy=Y(i);
        end
        % We only redraw if gazepos. has changed:
        [ myrect]=changeScreen(imdata,imdatablur,masktex,practice,small_star,motor_task,memory_exp,wideSetup,video,w,wW,wH,screenNumber,nonfoveatex,newfoveaRect,backgroundcolor,ms,oldx,oldy,currx,curry,i,currStepTime,low_con_control);
        mxold=mx;
        myold=my;
        
        if  KbCheck(mouseNum)
            break
        end
        
        [timeCompleted,missedSamples]=loopSepTime(exp_type,currStepTime,TIME_RES,timeCompleted,missedSamples,i);
        
        i=i+1;
        stepTime(i)=toc;
    end
    %for video recordings:
    if video==1
        Screen('FinalizeMovie', movie);
    end
    %
    disp ( 'session time: ')
    disp(GetSecs-sessionClock)
    SessionTime=(GetSecs-sessionClock) ;
   
    %getting the answer
    Screen('FillRect', w, backgroundcolor);
    Screen('Flip',w);
    [answer,answer2,iscorrect]=getAnswer(NamesForAns,w,wW,wH,mouseNum,200,myimgfile);

    
    %closing and saving current session
    if eyetracking==1
        %verifing calibration:
        %         if session_num~=SESSION_NUM
        %         [pd_cal,gazeX_cal,gazeY_cal,fix]=calibVer(analog_type,w,wW,wH,backgroundcolor,mouseNum,TIME_RES,eyeused,pd_cal,gazeX_cal,gazeY_cal,fix);
        %         end
        %stoping eye recordings
        [error,status4,status5]=ELFinish(edfFile);
        save(SavingFile,'subject','exp','analog_type','ms','imdata','maskPara','pixelSize','pd','gazeX','gazeY','pd_cal','gazeX_cal','gazeY_cal','mx','my','sacVel','acc','sacLen','missedSamples','timeCompleted','SessionTime','myimgfile','answer','answer2','iscorrect','fix','firstFix');
    else
        save(SavingFile,'subject','exp','analog_type','ms','imdata','maskPara','pixelSize','pd','gazeX','gazeY','pd_cal','gazeX_cal','gazeY_cal','mx','my','sacVel','acc','sacLen','missedSamples','timeCompleted','SessionTime','myimgfile','answer','answer2','iscorrect');
    end
    %clear for next session
    clear(  'pd','gazeX','gazeY','pd_cal','gazeX_cal','gazeY_cal','sacVel','acc','sacLen','missedSamples','timeCompleted','SessionTime','myimgfile','answer','answer2','iscorrect');
    if exp_type==2
        clear('X','Y');
    end
    if memory_exp==1 || memory_exp==2
        clear('mx','my');
    end
    % recalibration exp if calibration is bad:
%     if eyetracking
%         [el]=DoRecalibration(el,eyetracking,session_num,SESSION_NUM,keyboardNum,w,backgroundcolor,mouseNum,domEye);
%     end
end


DrawFormattedText(w, 'THE END...thank you!!!','center','center',[25 140 230]);
%screen('DrawingFinished', w);
Screen('Flip',w);
pause(3)
Screen('CloseAll');
if eyetracking
    Eyelink('Shutdown');
end
disp('exp ended');
disp('exp lasted:');
disp(GetSecs-globalClock)
ShowCursor;
%plotting
if doPlot
end
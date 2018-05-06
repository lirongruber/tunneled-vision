% call Amos function with my DATA:
function [imdatas,chan_h_pix,chan_v_pix,chan_h, chan_v,saccade_vecs, n] =Ehud_sacDiffAmos(cal,fileName,sessionNum,picName,doPlot)
PIXEL2METER=0.000264583;
saccade_vecs={};
n=[];
chan_h=[];
chan_v=[];
line='\_+';
numOfFig=0;
for i=1:max(size(sessionNum))
    Name=regexp(fileName,line,'split');
    Name=Name{1,1};
    F=[Name '\' fileName '_'  num2str(sessionNum(i))];
    full_filename = fullfile('C:\Users\bnapp\Documents\tunnelledVisionPaper\analyzing\cleanedData',F);
    load(full_filename);
    if strcmp(picName,'all')==0
        if strcmp(picName,myimgfiles{1,1}{1,1})==0
            continue
        else
            numOfFig=numOfFig+1;
        end
    else numOfFig=numOfFig+1;
    end
    
    datalen=zeros(size(max(size(sessionNum))));
    if cal==1
        gaze{numOfFig} =[gazeX_cal ; gazeY_cal]; % for calibration
        datalen(numOfFig)=(calLens{1,1}-1);
    else
        gaze{numOfFig}=[gazeX ; gazeY];
        datalen(numOfFig)=(dataLens{1,1}-1);
    end
    chan_h_pix=gaze{numOfFig}(1,:);
    chan_v_pix=gaze{numOfFig}(2,:);
    % translating to degrees
    mid=size(imdatas{1,1})./2;
    chan_h=(chan_h_pix-mid(2));
    chan_v=(chan_v_pix-mid(1));
    chan_h=atand(chan_h.*PIXEL2METER);
    chan_v=atand(chan_v.*PIXEL2METER);
    
    % Parameters for Fried's function for identifying saccaddes
    amp_min = 0.0; % minimal amplitude in degrees
    amp_max = 0.0; % maximal amplitude in degrees
    eyetrack_menu_parameters.saccademinamp = 0.3; % 8 deg
    eyetrack_menu_parameters.saccademaxamp = 30; % 30 deg
    eyetrack_menu_parameters.minimumvelocity = 8; %4  deg/sec 
    eyetrack_menu_parameters.averagevelocity = 6; % 8 deg/sec 
    eyetrack_menu_parameters.peakvelocity = 16; %8  deg/sec 
    eyetrack_menu_parameters.intrussionrange = 300; % 300 msec
    eyetrack_menu_parameters.mergeovershoot = 1; % 1 - mergeovershoot
    eyetrack_menu_parameters.mergeintrussions = 0; % 1 - mergeintrussions
    
    rate=100; % Sample-Rate in Hz of the eye-Tracker : 0.01 msec, Hz=100;
    
    [saccade_vec, n] = eyetrack_find_saccadesRevAmos( chan_h, chan_v, rate, eyetrack_menu_parameters, amp_min, amp_max);
    
    saccade_vecs{numOfFig}=saccade_vec;
    imdata{numOfFig}=imdatas{1,1};
    
    
    %ploting:
    if doPlot==1
        figure(1)%(sessionNum(i))
        numOfSacc=find(saccade_vec(1,:));
        numOfSacc=numOfSacc(end);
        imshow(imdatas{1,1})
        hold on
        for i=1:numOfSacc-1
            plot (chan_h_pix(saccade_vec(2,i)+saccade_vec(1,i):saccade_vec(1,i+1)),chan_v_pix(saccade_vec(2,i)+saccade_vec(1,i):saccade_vec(1,i+1)),'b','LineWidth',1.5)
        end
        plot (chan_h_pix(saccade_vec(2,numOfSacc)+saccade_vec(1,numOfSacc):end),chan_v_pix(saccade_vec(2,numOfSacc)+saccade_vec(1,numOfSacc):end),'b','LineWidth',1.5)
    
    figure(2)
    plot(chan_h)
    hold on
    figure(3)
    plot(chan_v)
    hold on
    for i=1:numOfSacc
        figure(2)
        temp1=zeros(size(chan_h));
        temp1(saccade_vec(1,i):saccade_vec(2,i)+saccade_vec(1,i))=chan_h(saccade_vec(1,i):saccade_vec(2,i)+saccade_vec(1,i));
        temp1(temp1==0)=nan;
        plot(temp1,'r');
        figure(3)
        temp2=zeros(size(chan_v));
        temp2(saccade_vec(1,i):saccade_vec(2,i)+saccade_vec(1,i))=chan_v(saccade_vec(1,i):saccade_vec(2,i)+saccade_vec(1,i));
        temp2(temp2==0)=nan;
        plot(temp2,'r');
    end
    
    end
end
end
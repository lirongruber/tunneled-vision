% saccades view ( exp or calibration)(sacDiff or sacDiffAmos) :

% clear
clc
close all

fileName='RP_B3';
sessionNum=1;%1:12;
picName='all'; %'circle' 'triangle' etc
cal=0;
analog_type=2;
doPlot=1;

% [allFixations,numOfFixations,lenOfFixations,saccLine ]=sacDiff(cal,fileName,sessionNum,picName);

[imdatas,chan_h_pix,chan_v_pix,chan_h, chan_v,saccade_vec, n] =sacDiffAmos(cal,fileName,sessionNum,picName,doPlot);
% maybe add here the drift analysis for visualization:

if doPlot==1
    for i=1:length(sessionNum);
        figure(i)
        hold on
        %     imshow(imdata{1,i})
        %     plot( gazeX_cal{1,i}, gazeY_cal{1,i})
        %     plot( gazeX{1,i}, gazeY{1,i})
        if analog_type==1
            plot(200,200,'*r')
            plot(960,510,'*r')
            plot(1720,820,'*r')
        else
            plot(800,400,'*r')
            plot(960,510,'*r')
            plot(1120,620,'*r')
        end
        axis([0 1920 0 1200])
    end
end

tilefigs;





%- looking at the distance between mean fixations and the fixation +'s :
% i=trial, j=fixation number(1/2/3)
% avFixationX(i,j)=mean(allFixations{1,i}{1,j}(1,:));
% avFixationY(i,j)=mean(allFixations{1,i}{1,j}(2,:));
% distanceX(i,j)=avFixationX(i,j)-200;
% distanceY(i,j)=avFixationY(i,j)-200;

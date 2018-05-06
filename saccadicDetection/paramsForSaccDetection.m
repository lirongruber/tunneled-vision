%setting all parameters needed for saccades detection 
%(saccadesDetection.m)
%input : doPlot = (1/0) for a final plot of the full trial (default=1)
%        imdata = the stimuli presented (default is a black screen-size rectangle)
%        gaze = vector with horizontal and vertical samples in pixels (2xlength)
%output : chan_h/v_pix/deg = vectors with sampled data in horizontal and vertical (in pixels and degrees)
%         saccade_vec = vector containg all detected saccades : first row (indexes with saccades start points)
%                                                               second row (length of saccades in samples)
%                                                               third row (saccades intrusion in samples)
function [chan_h_pix,chan_v_pix,chan_h_deg, chan_v_deg,saccade_vec, n] =paramsForSaccDetection(doPlot,imdata,gaze)

if nargin<1
    doPlot=1;
end
PIXEL2METER=0.000264583;
if nargin<2
    imdata=zeros(1080,1920); % screen size
end
if nargin<3
% getting "gaze" from somewhere
load('C:\Users\bnapp\Documents\tunnelledVisionPaper\analyzing\cleanedData\LS\LS_B1_4.mat')
gaze=[gazeX ; gazeY];
end

rate=100; % Sample-Rate in Hz of the eye-Tracker : 0.01 msec, Hz=100;
screenDistance=1; % distance from the screen in meters

%
chan_h_pix=gaze(1,:); % in pixels
chan_v_pix=gaze(2,:); % in pixels

% translating to degrees
mid=size(imdata)./2;
chan_h_deg=(chan_h_pix-mid(2));
chan_v_deg=(chan_v_pix-mid(1));
chan_h_deg=atand(chan_h_deg.*PIXEL2METER/screenDistance);
chan_v_deg=atand(chan_v_deg.*PIXEL2METER/screenDistance);

% Parameters for saccadesDetection.m
sacc_parameters.saccade_min_amp = 0.3; % 8, deg (minimal amplitude in degrees)
sacc_parameters.saccade_max_amp = 30; % 30, deg (maximal amplitude in degrees)
sacc_parameters.saccade_min_velocity = 8; %4,  deg/sec
% sacc_parameters.averagevelocity = 6; % (not in use)
sacc_parameters.saccade_peak_velocity = 16; %8,  deg/sec
sacc_parameters.saccade_min_duration = 2;   % in msec
sacc_parameters.saccade_angle_threshold = 30.0; % maximun angle within saccades (in degrees)

sacc_parameters.merge_overshoot = 1; % 1 - mergeovershoot
sacc_parameters.overshoot_min_amp=0.5; % in fraction from full saccade minimum amplitude

sacc_parameters.merge_intrusions = 0; % 1 - mergeintrussions
sacc_parameters.intrusion_range = 300; % in msec
sacc_parameters.intrusion_angle_threshold = 90.0; % mimimum change in direction for saccadic-intrussion.

[saccade_vec, n] =saccadesDetection( chan_h_deg, chan_v_deg, rate, sacc_parameters);

%ploting:
if doPlot==1
    figure(1)
    imshow(imdata)
    hold on
    for i=1:n-1
        % drift 
        plot (chan_h_pix(saccade_vec(1,i)+saccade_vec(2,i):saccade_vec(1,i+1)),chan_v_pix(saccade_vec(2,i)+saccade_vec(1,i):saccade_vec(1,i+1)),'c','LineWidth',1.5)
        % sacc
        plot (chan_h_pix(saccade_vec(1,i):saccade_vec(1,i)+saccade_vec(2,i)),chan_v_pix(saccade_vec(1,i):saccade_vec(1,i)+saccade_vec(2,i)),'b','LineWidth',1.5)
    end
    % first sacc green, last red:
    plot (chan_h_pix(saccade_vec(1,1):saccade_vec(1,1)+saccade_vec(2,1)),chan_v_pix(saccade_vec(1,1):saccade_vec(1,1)+saccade_vec(2,1)),'g','LineWidth',1.5)
    plot (chan_h_pix(saccade_vec(1,n):saccade_vec(1,n)+saccade_vec(2,n)),chan_v_pix(saccade_vec(1,n):saccade_vec(1,n)+saccade_vec(2,n)),'r','LineWidth',1.5)
    
    figure(2)
    plot(chan_h_deg,'k')
    hold on
    figure(3)
    plot(chan_v_deg,'k')
    hold on
    for i=1:n
        figure(2)
        temp1=zeros(size(chan_h_deg));
        temp1(saccade_vec(1,i):saccade_vec(1,i)+saccade_vec(2,i))=chan_h_deg(saccade_vec(1,i):saccade_vec(1,i)+saccade_vec(2,i));
        temp1(temp1==0)=nan;
        plot(temp1,'b');
        title('Horizontal')
        figure(3)
        temp2=zeros(size(chan_v_deg));
        temp2(saccade_vec(1,i):saccade_vec(1,i)+saccade_vec(2,i))=chan_v_deg(saccade_vec(1,i):saccade_vec(1,i)+saccade_vec(2,i));
        temp2(temp2==0)=nan;
        plot(temp2,'b');
        title('Vertical')
    end
    tilefigs;
%     keyboard;
end
end
function startup
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% addpath /Users/harpazone/Dropbox/MATLAB
% cd /Users/harpazone/Dropbox/MATLAB %set the 'home' folder

% set(0,'DefaultAxesFontName', 'Calibri')
set(0,'DefaultAxesFontName', 'Arial')
set(0,'defaultTextFontName', 'Arial')
set(0,'DefaultAxesFontSize',18)
set(0,'defaultlinelinewidth',2)
set(0,'DefaultLineMarkerSize',12)
set(0,'defaultfigurecolor',[1 1 1])
% set(groot,'defaultAxesColorOrder',MyLines);close; %set color for multiple line plots
% % addpath(genpath('D:\MATLAB\R2015a\toolbox\Psychtoolbox'))
% Call Psychtoolbox-3 specific startup function:
if exist('PsychStartup')
    PsychStartup;
end

end





% plot all paramatre together:
startup;

clear
close all
sub='SM'; % SM LB LS AS RW

load(['C:\Users\bnapp\Documents\tunnelledVisionPaper\analyzing\resultsVectors\' sub '\allShapeSAnalogallSessionallTrialcAnswer.mat'])
t=length(num_of_sacc);
analog='S';
vecsForStatForsubData(sub,labeled_saccade_vecs,analog,t,time_of_trial_in_sec,num_of_sacc_per_sec,whiteTimes,saccs_amp_degrees,drifts_dist_degrees,drifts_amp_degrees,saccs_vel_deg2sec,saccs_maxvel_deg2sec,drifts_vel_deg2sec,saccs_time_ms,drifts_time_ms);
load(['C:\Users\bnapp\Documents\tunnelledVisionPaper\analyzing\resultsVectors\' sub '\SMALLvectorsForStat.mat'])

saccPerSec_s=saccPerSec;
driftAmp_s=driftAmp;
driftDist_s=driftDist;
driftVel_s=driftVel;
driftTime_s=driftTime;
saccAmp_s=saccAmp;
saccVel_s=saccVel;
saccMaxVel_s=saccMaxVel;
% ls=l;
% ms=m;
typeOfSacc_s=typeOfSacc;
typeOfDrift_s=typeOfDrift;
driftVel_for_cat_s=driftVel_for_cat;
driftAmp_for_cat_s=driftAmp_for_cat;
driftTime_for_cat_s=driftTime_for_cat;

%         'timeOftrial',,'timeNearShape'
%         'saccTime','driftTime','driftVel_for_cat','driftAmp_for_cat'

load(['C:\Users\bnapp\Documents\tunnelledVisionPaper\analyzing\resultsVectors\' sub '\allShapeSAnalogallSessionallTrialwAnswer.mat'])
t=length(num_of_sacc);
analog='S';
vecsForStatForsubData(sub,labeled_saccade_vecs,analog,t,time_of_trial_in_sec,num_of_sacc_per_sec,whiteTimes,saccs_amp_degrees,drifts_dist_degrees,drifts_amp_degrees,saccs_vel_deg2sec,saccs_maxvel_deg2sec,drifts_vel_deg2sec,saccs_time_ms,drifts_time_ms);
load(['C:\Users\bnapp\Documents\tunnelledVisionPaper\analyzing\resultsVectors\' sub '\SMALLvectorsForStat.mat'])

saccPerSec_sw=saccPerSec;
driftAmp_sw=driftAmp;
driftDist_sw=driftDist;
driftVel_sw=driftVel;
driftTime_sw=driftTime;
saccAmp_sw=saccAmp;
saccVel_sw=saccVel;
saccMaxVel_sw=saccMaxVel;
% lsw=l;
% msw=m;
typeOfSacc_sw=typeOfSacc;
typeOfDrift_sw=typeOfDrift;
driftVel_for_cat_sw=driftVel_for_cat;
driftAmp_for_cat_sw=driftAmp_for_cat;
driftTime_for_cat_sw=driftTime_for_cat;

load(['C:\Users\bnapp\Documents\tunnelledVisionPaper\analyzing\resultsVectors\' sub '\allShapeNSAnalogallSessionallTrialcAnswer.mat'])
t=length(num_of_sacc);
analog='n';
vecsForStatForsubData(sub,labeled_saccade_vecs,analog,t,time_of_trial_in_sec,num_of_sacc_per_sec,whiteTimes,saccs_amp_degrees,drifts_dist_degrees,drifts_amp_degrees,saccs_vel_deg2sec,saccs_maxvel_deg2sec,drifts_vel_deg2sec,saccs_time_ms,drifts_time_ms);
load(['C:\Users\bnapp\Documents\tunnelledVisionPaper\analyzing\resultsVectors\' sub '\nSMALLvectorsForStat.mat'])

saccPerSec_n=saccPerSec;
driftAmp_n=driftAmp;
driftDist_n=driftDist;
driftVel_n=driftVel;
driftTime_n=driftTime;
saccAmp_n=saccAmp;
saccVel_n=saccVel;
saccMaxVel_n=saccMaxVel;
% lsw=l;
% msw=m;
typeOfSacc_n=typeOfSacc;
typeOfDrift_n=typeOfDrift;
driftVel_for_cat_n=driftVel_for_cat;
driftAmp_for_cat_n=driftAmp_for_cat;
driftTime_for_cat_n=driftTime_for_cat;

load(['C:\Users\bnapp\Documents\tunnelledVisionPaper\analyzing\resultsVectors\' sub '\allShapeNBAnalogallSessionallTrialcAnswer.mat'])
t=length(num_of_sacc);
analog='N';
vecsForStatForsubData(sub,labeled_saccade_vecs,analog,t,time_of_trial_in_sec,num_of_sacc_per_sec,whiteTimes,saccs_amp_degrees,drifts_dist_degrees,drifts_amp_degrees,saccs_vel_deg2sec,saccs_maxvel_deg2sec,drifts_vel_deg2sec,saccs_time_ms,drifts_time_ms);
load(['C:\Users\bnapp\Documents\tunnelledVisionPaper\analyzing\resultsVectors\' sub '\NvectorsForStat.mat'])

saccPerSec_N=saccPerSec;
driftAmp_N=driftAmp;
driftDist_N=driftDist;
driftVel_N=driftVel;
driftTime_N=driftTime;
saccAmp_N=saccAmp;
saccVel_N=saccVel;
saccMaxVel_N=saccMaxVel;
% lsw=l;
% msw=m;
typeOfSacc_N=typeOfSacc;
typeOfDrift_N=typeOfDrift;
driftVel_for_cat_N=driftVel_for_cat;
driftAmp_for_cat_N=driftAmp_for_cat;
driftTime_for_cat_N=driftTime_for_cat;

load(['C:\Users\bnapp\Documents\tunnelledVisionPaper\analyzing\resultsVectors\' sub '\allShapeBAnalogallSessionallTrialcAnswer.mat'])
t=length(num_of_sacc);
analog='B';
vecsForStatForsubData(sub,labeled_saccade_vecs,analog,t,time_of_trial_in_sec,num_of_sacc_per_sec,whiteTimes,saccs_amp_degrees,drifts_dist_degrees,drifts_amp_degrees,saccs_vel_deg2sec,saccs_maxvel_deg2sec,drifts_vel_deg2sec,saccs_time_ms,drifts_time_ms);
load(['C:\Users\bnapp\Documents\tunnelledVisionPaper\analyzing\resultsVectors\' sub '\vectorsForStat.mat'])

%% drifts
figure(3)
% 
subplot(4,3,1)
hold on
axis([ -5 5 0 0.1]);
[N,X] = hist(log(driftAmp(driftAmp>0)),40);
N=N/sum(N);
fittedmodel = fit(X',N', 'gauss1');
hold on
bar(X,N)
plot(fittedmodel)
xisval=get(gca,'XTick');
set(gca,'XTick',xisval);
set(gca,'XTickLabel',round(exp(xisval),2));
leg=legend(['Peaks: '  num2str(round(exp(fittedmodel.b1),1))  ' deg'],'Location','northeast') ;
set(leg,'FontSize',15);
xlabel('VALUE','FontSize', 15)
ylabel('HIST of log values','FontSize', 15)
title(' log Amplitude of Drift in Degrees ', 'FontSize', 25)
% title('Tunneled BIG', 'FontSize', 25)

subplot(4,3,4)
hold on
axis([ -5 5 0 0.1]);
[N,X] = hist(log(driftAmp_N(driftAmp_N>0)),40);
N=N/sum(N);
fittedmodel = fit(X',N', 'gauss1');
hold on
bar(X,N)
plot(fittedmodel)
xisval=get(gca,'XTick');
set(gca,'XTick',xisval);
set(gca,'XTickLabel',round(exp(xisval),2));
leg=legend(['Peak: ' num2str(round(exp(fittedmodel.b1),1))  ' deg'],'Location','northeast') ;
set(leg,'FontSize',15);
xlabel('VALUE','FontSize', 15)
ylabel('HIST of log values','FontSize', 15)
title('Amplitude of Drift in Degrees', 'FontSize', 25)
title('NATURAL BIG', 'FontSize', 25)

% NmeanAmpDrift=round(exp(fittedmodel.b1),1);
NmeanAmpDrift=1;

subplot(4,3,7)
hold on
axis([ -5 5 0 0.1]);
[N,X] = hist(log(driftAmp_s(driftAmp_s>0)),40);
N=N/sum(N);
fittedmodel = fit(X',N', 'gauss1');
hold on
bar(X,N)
plot(fittedmodel)
xisval=get(gca,'XTick');
set(gca,'XTick',xisval);
set(gca,'XTickLabel',round(exp(xisval),2));
leg=legend(['Peak: '  num2str(round(exp(fittedmodel.b1),1))  ' deg'],'Location','northeast') ;
set(leg,'FontSize',15);
xlabel('VALUE','FontSize', 15)
ylabel('HIST of log values','FontSize', 15)
title(' log Amplitude of Drift in Degrees ', 'FontSize', 25)
title('Tunneled SMALL', 'FontSize', 25)

subplot(4,3,10)
hold on
axis([ -5 5 0 0.1]);
[N,X] = hist(log(driftAmp_n(driftAmp_n>0)),40);
N=N/sum(N);
fittedmodel = fit(X',N', 'gauss1');
hold on
bar(X,N)
plot(fittedmodel)
xisval=get(gca,'XTick');
set(gca,'XTick',xisval);
set(gca,'XTickLabel',round(exp(xisval),2));
leg=legend(['Peak: '  num2str(round(exp(fittedmodel.b1),1))  ' deg'],'Location','northeast') ;
set(leg,'FontSize',15);
xlabel('VALUE','FontSize', 15)
ylabel('HIST of log values','FontSize', 15)
title(' log Amplitude of Drift in Degrees ', 'FontSize', 25)
title('NATURAL SMALL', 'FontSize', 25)

% nmeanAmpDrift=round(exp(fittedmodel.b1),1);
nmeanAmpDrift=1;

subplot(4,3,2)
hold on
axis([ -4 4 0 0.1]);
[N,X] = hist(log(driftVel(driftVel>0)),40);
N=N/sum(N);
fittedmodel = fit(X',N', 'gauss1');
hold on
bar(X,N)
plot(fittedmodel)
xisval=get(gca,'XTick');
set(gca,'XTick',xisval);
set(gca,'XTickLabel',round(exp(xisval),2));
leg=legend(['Peak: '  num2str(round(exp(fittedmodel.b1),1)) ' deg/sec' ],'Location','northeast') ;
set(leg,'FontSize',15);
xlabel('VALUE','FontSize', 15)
ylabel('HIST of log values','FontSize', 15)
title(' log Velocity of Drift in DegperSec', 'FontSize', 25)
% title('Tunneled BIG', 'FontSize', 25)

subplot(4,3,5)
hold on
axis([ -4 4 0 0.1]);
[N,X] = hist(log(driftVel_N(driftVel_N>0)),40);
N=N/sum(N);
fittedmodel = fit(X',N', 'gauss1');
hold on
bar(X,N)
plot(fittedmodel)
xisval=get(gca,'XTick');
set(gca,'XTick',xisval);
set(gca,'XTickLabel',round(exp(xisval),2));
leg=legend(['Peak: ' num2str(round(exp(fittedmodel.b1),1)) ' deg/sec'],'Location','northeast') ;
set(leg,'FontSize',15);
xlabel('VALUE','FontSize', 15)
ylabel('HIST of log values','FontSize', 15)
title('Velocity of Drift in DegperSec', 'FontSize', 25)
title('NATURAL BIG', 'FontSize', 25)

% NmeanVelDrift=round(exp(fittedmodel.b1),1);
NmeanVelDrift=1;

subplot(4,3,8)
hold on
axis([ -4 4 0 0.1]);
[N,X] = hist(log(driftVel_s(driftVel_s>0)),40);
N=N/sum(N);
fittedmodel = fit(X',N', 'gauss1');
hold on
bar(X,N)
plot(fittedmodel)
xisval=get(gca,'XTick');
set(gca,'XTick',xisval);
set(gca,'XTickLabel',round(exp(xisval),2));
leg=legend(['Peak: ' num2str(round(exp(fittedmodel.b1),1)) ' deg/sec' ],'Location','northeast') ;
set(leg,'FontSize',15);
xlabel('VALUE','FontSize', 15)
ylabel('HIST of log values','FontSize', 15)
title(' log Velocity of Drift in DegperSec', 'FontSize', 25)
title('Tunneled SMALL', 'FontSize', 25)

subplot(4,3,11)
hold on
axis([ -4 4 0 0.1]);
[N,X] = hist(log(driftVel_n(driftVel_n>0)),40);
N=N/sum(N);
fittedmodel = fit(X',N', 'gauss1');
hold on
bar(X,N)
plot(fittedmodel)
xisval=get(gca,'XTick');
set(gca,'XTick',xisval);
set(gca,'XTickLabel',round(exp(xisval),2));
leg=legend(['Peak: ' num2str(round(exp(fittedmodel.b1),1)) ' deg/sec' ],'Location','northeast') ;
set(leg,'FontSize',15);
xlabel('VALUE','FontSize', 15)
ylabel('HIST of log values','FontSize', 15)
title(' log Velocity of Drift in DegperSec', 'FontSize', 25)
title('NATURAL SMALL', 'FontSize', 25)

% nmeanVelDrift=round(exp(fittedmodel.b1),1);
nmeanVelDrift=1;

subplot(4,3,3)
hold on
% axis([ 0 500 0 0.4]);
[N,X] = hist(driftTime(driftTime>0),50);
N=N/sum(N);
% fittedmodel = fit(X',N', 'a1*exp(-x/a2)');
hold on
bar(X,N)
% plot(fittedmodel)
% xisval=get(gca,'XTick');
% set(gca,'XTick',xisval);
% set(gca,'XTickLabel',round(exp(xisval),2));
leg=legend(['Med: '  num2str(round(median(driftTime(driftTime>0)),1)) ' deg'],'Location','northeast') ;
set(leg,'FontSize',15);
xlabel('VALUE','FontSize', 15)
ylabel('HIST of values','FontSize', 15)
title('Time of Drift in mSec', 'FontSize', 25)
% title('Tunneled BIG', 'FontSize', 25)

subplot(4,3,6)
hold on
axis([ 0 1000 0 0.4]);
[N,X] = hist(driftTime_N(driftTime_N>0),50);
N=N/sum(N);
% fittedmodel = fit(X',N', 'gauss1');
hold on
bar(X,N)
% plot(fittedmodel)
% xisval=get(gca,'XTick');
% set(gca,'XTick',xisval);
% set(gca,'XTickLabel',round(exp(xisval),2));
leg=legend(['Med: '  num2str(round(median(driftTime_N(driftTime_N>0)),1)) ' deg'],'Location','northeast') ;
set(leg,'FontSize',15);
xlabel('VALUE','FontSize', 15)
ylabel('HIST of values','FontSize', 15)
title('Time of Drift in mSec', 'FontSize', 25)
title('NATURAL BIG', 'FontSize', 25)

NmeanTimeDrift=1;

subplot(4,3,9)
hold on
axis([ 0 1000 0 0.4]);
[N,X] = hist(driftTime_s(driftTime_s>0),50);
N=N/sum(N);
% fittedmodel = fit(X',N', 'a1*exp(-x/a2)');
hold on
bar(X,N)
% plot(fittedmodel)
% xisval=get(gca,'XTick');
% set(gca,'XTick',xisval);
% set(gca,'XTickLabel',round(exp(xisval),2));
leg=legend(['Med: '  num2str(round(median(driftTime_s(driftTime_s>0)),1)) ' deg'],'Location','northeast') ;
set(leg,'FontSize',15);
xlabel('VALUE','FontSize', 15)
ylabel('HIST of values','FontSize', 15)
title('Time of Drift in mSec', 'FontSize', 25)
title('Tunneled SMALL', 'FontSize', 25)

subplot(4,3,12)
hold on
axis([ 0 1000 0 0.4]);
[N,X] = hist(driftTime_n(driftTime_n>0),50);
N=N/sum(N);
% fittedmodel = fit(X',N', 'gauss1');
hold on
bar(X,N)
% plot(fittedmodel)
% xisval=get(gca,'XTick');
% set(gca,'XTick',xisval);
% set(gca,'XTickLabel',round(exp(xisval),2));
leg=legend(['Med: '  num2str(round(median(driftTime_n(driftTime_n>0)),1)) ' deg'],'Location','northeast') ;
set(leg,'FontSize',15);
xlabel('VALUE','FontSize', 15)
ylabel('HIST of values','FontSize', 15)
title('Time of Drift in mSec', 'FontSize', 25)
title('NATURAL SMALL', 'FontSize', 25)

nmeanTimeDrift=1;

%% Saccsdes:
figure(2)

subplot(4,3,1)
axis([ 0 2 0 0.25]);
[N,X] = hist(saccAmp(saccAmp<2),50);
N=N/sum(N);
hold on
bar(X,N)
leg=legend(['Med: '  num2str(round(median(saccAmp(saccAmp<2)),1))  ' deg'],'Location','northeast') ;
set(leg,'FontSize',15);
xlabel('VALUE','FontSize', 15)
ylabel('HIST of values','FontSize', 15)
title('Amplitude of Saccades in Degrees', 'FontSize', 25)
% title('Tunneled BIG', 'FontSize', 25)

subplot(4,3,4)
hold on
 axis([ 0 2 0 0.25]);
[N,X] = hist(saccAmp_N(saccAmp_N<2),50);
N=N/sum(N);
hold on
bar(X,N)
leg=legend(['Med: '  num2str(round(median(saccAmp_N(saccAmp_N<2)),1))  ' deg'],'Location','northeast') ;
set(leg,'FontSize',15);
xlabel('VALUE','FontSize', 15)
ylabel('HIST of values','FontSize', 15)
title('Amplitude of Saccades in Degrees', 'FontSize', 25)
title('NATURAL BIG', 'FontSize', 25)

% NmeanAmpSacc=round(median(saccAmp_N(saccAmp_N<2)),1);
NmeanAmpSacc=1;

axes('Position',[.18 .85 .05 .05])
box on
axis([ 0 10 0 0.25]);
[N,X] = hist(saccAmp(saccAmp<10),50);
N=N/sum(N);
hold on
bar(X,N)
title(['Med: '  num2str(round(median(saccAmp(saccAmp<10)),1))  ' deg'],'FontSize', 10) ;
% title('Tunneled BIG', 'FontSize', 25)

axes('Position',[.18 .63 .05 .05])
box on
axis([ 0 10 0 0.25]);
[N,X] = hist(saccAmp_N(saccAmp_N<10),50);
N=N/sum(N);
hold on
bar(X,N)
title(['Med: '  num2str(round(median(saccAmp_N(saccAmp_N<10)),1))  ' deg'],'FontSize', 10) ;

subplot(4,3,7)
 axis([ 0 2 0 0.25]);
[N,X] = hist(saccAmp_s(saccAmp_s<2),50);
N=N/sum(N);
hold on
bar(X,N)
leg=legend(['Med: '  num2str(round(median(saccAmp_s(saccAmp_s<2)),1)) ' deg'],'Location','northeast') ;
set(leg,'FontSize',15);
xlabel('VALUE','FontSize', 15)
ylabel('HIST of values','FontSize', 15)
title('Amplitude of Saccades in Degrees', 'FontSize', 25)
title('Tunneled SMALL', 'FontSize', 25)

subplot(4,3,10)
 axis([ 0 2 0 0.25]);
[N,X] = hist(saccAmp_n(saccAmp_n<2),50);
N=N/sum(N);
hold on
bar(X,N)
leg=legend(['Med: '  num2str(round(median(saccAmp_n(saccAmp_n<2)),1)) ' deg'],'Location','northeast') ;
set(leg,'FontSize',15);
xlabel('VALUE','FontSize', 15)
ylabel('HIST of values','FontSize', 15)
title('Amplitude of Saccades in Degrees', 'FontSize', 25)
title('NATURAL SMALL', 'FontSize', 25)

% nmeanAmpSacc=round(round(median(saccAmp_n(saccAmp_n<2)),1));
nmeanAmpSacc=1;

figure(2)

subplot(4,3,2)
hold on
axis([ 0 100 0 0.35]);
[N,X] = hist(saccVel(saccAmp<2),50);
N=N/sum(N);
hold on
bar(X,N)
leg=legend(['Med: '  num2str(round(median(saccVel(saccAmp<2)),1)) ' deg/sec'],'Location','northeast') ;
set(leg,'FontSize',15);
xlabel('VALUE','FontSize', 15)
ylabel('HIST of values','FontSize', 15)
title('Av Velocity of Saccades in DegperSec', 'FontSize', 25)
% title('Tunneled BIG', 'FontSize', 25)

subplot(4,3,5)
hold on
axis([ 0 100 0 0.35]);
[N,X] = hist(saccVel_N(saccAmp_N<2),50);
N=N/sum(N);
hold on
bar(X,N)
leg=legend(['Med: '  num2str(round(median(saccVel_N(saccAmp_N<2)),1)) ' deg/sec'],'Location','northeast') ;
set(leg,'FontSize',15);
xlabel('VALUE','FontSize', 15)
ylabel('HIST of values','FontSize', 15)
title('Av Velocity of Saccades in DegperSec', 'FontSize', 25)
title('NATURAL BIG', 'FontSize', 25)

% NmeanVelSacc=round(median(saccVel_N(saccAmp_N<2)),1);
NmeanVelSacc=1;

subplot(4,3,8)
hold on
axis([ 0 100 0 0.35]);
[N,X] = hist(saccVel_s(saccAmp_s<2),50);
N=N/sum(N);
hold on
bar(X,N)
leg=legend(['Med: '  num2str(round(median(saccVel_s(saccAmp_s<2)),1)) ' deg/sec'],'Location','northeast') ;
set(leg,'FontSize',15);
xlabel('VALUE','FontSize', 15)
ylabel('HIST of values','FontSize', 15)
title('Av Velocity of Saccades in DegperSec', 'FontSize', 25)
title('Tunneled SMALL', 'FontSize', 25)

subplot(4,3,11)
hold on
axis([ 0 100 0 0.35]);
[N,X] = hist(saccVel_n(saccAmp_n<2),50);
N=N/sum(N);
hold on
bar(X,N)
leg=legend(['Med: '  num2str(round(median(saccVel_n(saccAmp_n<2)),1)) ' deg/sec'],'Location','northeast') ;
set(leg,'FontSize',15);
xlabel('VALUE','FontSize', 15)
ylabel('HIST of values','FontSize', 15)
title('Av Velocity of Saccades in DegperSec', 'FontSize', 25)
title('NATURAL SMALL', 'FontSize', 25)

% nmeanVelSacc=round(median(saccVel_n(saccAmp_n<2)),1);
nmeanVelSacc=1;

figure(2)
subplot(4,3,3)
hold on
axis([ 0 15 0 0.3]);
[N,X] = hist(saccPerSec,15);
N=N/sum(N);
hold on
bar(X,N)
leg=legend(['Med: '  num2str(round(median(saccPerSec),1)) ' #/sec'],'Location','northeast') ;
set(leg,'FontSize',15);
xlabel('VALUE','FontSize', 15)
ylabel('HIST of values','FontSize', 15)
title('Number of Saccades per second', 'FontSize', 25)
% title('Tunneled - BIG', 'FontSize', 25)

subplot(4,3,6)
hold on
axis([ 0 15 0 0.3]);
[N,X] = hist(saccPerSec_N,15);
N=N/sum(N);
hold on
bar(X,N)
leg=legend(['Med: '  num2str(round(median(saccPerSec_N),1)) ' #/sec'],'Location','northeast') ;
set(leg,'FontSize',15);
xlabel('VALUE','FontSize', 15)
ylabel('HIST of values','FontSize', 15)
title('Number of Saccades per sec', 'FontSize', 25)
title('NATURAL BIG', 'FontSize', 25)

% NmeanRateSacc=round(median(saccPerSec_N),1);
NmeanRateSacc=1;

subplot(4,3,9)
hold on
axis([ 0 15 0 0.3]);
[N,X] = hist(saccPerSec_s,15);
N=N/sum(N);
hold on
bar(X,N)
leg=legend(['Med: '  num2str(round(median(saccPerSec_s),1)) ' #/sec'],'Location','northeast') ;
set(leg,'FontSize',15);
xlabel('VALUE','FontSize', 15)
ylabel('HIST of values','FontSize', 15)
title('Number of Saccades per second', 'FontSize', 25)
title('Tunneled SMALL', 'FontSize', 25)

subplot(4,3,12)
hold on
axis([ 0 15 0 0.3]);
[N,X] = hist(saccPerSec_n,15);
N=N/sum(N);
hold on
bar(X,N)
leg=legend(['Med: '  num2str(round(median(saccPerSec_n),1)) ' #/sec'],'Location','northeast') ;
set(leg,'FontSize',15);
xlabel('VALUE','FontSize', 15)
ylabel('HIST of values','FontSize', 15)
title('Number of Saccades per second', 'FontSize', 25)
title('NATURAL SMALL', 'FontSize', 25)

% nmeanRateSacc=round(median(saccPerSec_n),1);
nmeanRateSacc=1;

%% types of sacc analysis:

saccAmp_border=saccAmp(typeOfSacc==1);
saccAmp_hor=saccAmp(typeOfSacc==2);
saccAmp_ver=saccAmp(typeOfSacc==3);

str_typeOfSacc=num2str(typeOfSacc);
str_typeOfSacc=str_typeOfSacc(str_typeOfSacc~=' ');
rel_drift=strfind(str_typeOfSacc,'11');
other_drift=ones(size(typeOfSacc));
other_drift(rel_drift)=0;

driftAmp_border=driftAmp_for_cat(rel_drift);
driftVel_border=driftVel_for_cat(rel_drift);
driftTime_border=driftTime_for_cat(rel_drift);
driftAmp_other=driftAmp_for_cat(other_drift==1);
driftVel_other=driftVel_for_cat(other_drift==1);
driftTime_other=driftTime_for_cat(other_drift==1);

borderStraitDrift=find(typeOfDrift==1);
borderStraitDrift=size(intersect(borderStraitDrift,rel_drift),2);
borderCircleDrift=find(typeOfDrift==2);
borderCircleDrift=size(intersect(borderCircleDrift,rel_drift),2);
borderOtherDrift=find(typeOfDrift==3);
borderOtherDrift=size(intersect(borderOtherDrift,rel_drift),2);

OtherStraitDrift=find(typeOfDrift==1);
OtherStraitDrift=size(intersect(OtherStraitDrift,find(other_drift==1)),2);
OtherCircleDrift=find(typeOfDrift==2);
OtherCircleDrift=size(intersect(OtherCircleDrift,find(other_drift==1)),2);
OtherOtherDrift=find(typeOfDrift==3);
OtherOtherDrift=size(intersect(OtherOtherDrift,find(other_drift==1)),2);

shapePlaceDrift=[ borderStraitDrift borderCircleDrift borderOtherDrift ; OtherStraitDrift OtherCircleDrift OtherOtherDrift];

%% small
saccAmp_border_s=saccAmp_s(typeOfSacc_s==1);
saccAmp_hor_s=saccAmp_s(typeOfSacc_s==2);
saccAmp_ver_s=saccAmp_s(typeOfSacc_s==3);

str_typeOfSacc=num2str(typeOfSacc_s);
str_typeOfSacc=str_typeOfSacc(str_typeOfSacc~=' ');
rel_drift_s=strfind(str_typeOfSacc,'11');
other_drift_s=ones(size(typeOfSacc_s));
other_drift_s(rel_drift_s)=0;

driftAmp_border_s=driftAmp_for_cat_s(rel_drift_s);
driftVel_border_s=driftVel_for_cat_s(rel_drift_s);
driftTime_border_s=driftTime_for_cat_s(rel_drift_s);
driftAmp_other_s=driftAmp_for_cat_s(other_drift_s==1);
driftVel_other_s=driftVel_for_cat_s(other_drift_s==1);
driftTime_other_s=driftTime_for_cat_s(other_drift_s==1);

borderStraitDrift_s=find(typeOfDrift_s==1);
borderStraitDrift_s=size(intersect(borderStraitDrift_s,rel_drift_s),2);
borderCircleDrift_s=find(typeOfDrift_s==2);
borderCircleDrift_s=size(intersect(borderCircleDrift_s,rel_drift_s),2);
borderOtherDrift_s=find(typeOfDrift_s==3);
borderOtherDrift_s=size(intersect(borderOtherDrift_s,rel_drift_s),2);

OtherStraitDrift_s=find(typeOfDrift_s==1);
OtherStraitDrift_s=size(intersect(OtherStraitDrift_s,find(other_drift_s==1)),2);
OtherCircleDrift_s=find(typeOfDrift_s==2);
OtherCircleDrift_s=size(intersect(OtherCircleDrift_s,find(other_drift_s==1)),2);
OtherOtherDrift_s=find(typeOfDrift_s==3);
OtherOtherDrift_s=size(intersect(OtherOtherDrift_s,find(other_drift_s==1)),2);

shapePlaceDrift_s=[ borderStraitDrift_s borderCircleDrift_s borderOtherDrift_s ; OtherStraitDrift_s OtherCircleDrift_s OtherOtherDrift_s];


%% types of drift shape analysis:
driftAmp_strait=driftAmp_for_cat(typeOfDrift==1);
driftVel_strait=driftVel_for_cat(typeOfDrift==1);
driftTime_strait=driftTime_for_cat(typeOfDrift==1);

driftAmp_circle=driftAmp_for_cat(typeOfDrift==2);
driftVel_circle=driftVel_for_cat(typeOfDrift==2);
driftTime_circle=driftTime_for_cat(typeOfDrift==2);

driftAmp_otherShape=driftAmp_for_cat(typeOfDrift==3);
driftVel_otherShape=driftVel_for_cat(typeOfDrift==3);
driftTime_otherShape=driftTime_for_cat(typeOfDrift==3);


%% small
driftAmp_strait_s=driftAmp_for_cat_s(typeOfDrift_s==1);
driftVel_strait_s=driftVel_for_cat_s(typeOfDrift_s==1);
driftTime_strait_s=driftTime_for_cat_s(typeOfDrift_s==1);

driftAmp_circle_s=driftAmp_for_cat_s(typeOfDrift_s==2);
driftVel_circle_s=driftVel_for_cat_s(typeOfDrift_s==2);
driftTime_circle_s=driftTime_for_cat_s(typeOfDrift_s==2);

driftAmp_otherShape_s=driftAmp_for_cat_s(typeOfDrift_s==3);
driftVel_otherShape_s=driftVel_for_cat_s(typeOfDrift_s==3);
driftTime_otherShape_s=driftTime_for_cat_s(typeOfDrift_s==3);

%%
driftAmp_N=driftAmp_N./NmeanAmpDrift;
driftAmp=driftAmp./NmeanAmpDrift;
driftAmp_n=driftAmp_n./nmeanAmpDrift;
driftAmp_s=driftAmp_s./nmeanAmpDrift;
driftAmp_sw=driftAmp_sw./nmeanAmpDrift;

driftAmp_border=driftAmp_border./NmeanAmpDrift;
driftAmp_other=driftAmp_other./NmeanAmpDrift;
driftAmp_strait=driftAmp_strait./NmeanAmpDrift;
driftAmp_circle=driftAmp_circle./NmeanAmpDrift;
driftAmp_otherShape=driftAmp_otherShape./NmeanAmpDrift;

driftAmp_border_s=driftAmp_border_s./nmeanAmpDrift;
driftAmp_other_s=driftAmp_other_s./nmeanAmpDrift;
driftAmp_strait_s=driftAmp_strait_s./nmeanAmpDrift;
driftAmp_circle_s=driftAmp_circle_s./nmeanAmpDrift;
driftAmp_otherShape_s=driftAmp_otherShape_s./nmeanAmpDrift;

driftVel_N=driftVel_N./NmeanVelDrift;
driftVel=driftVel./NmeanVelDrift;
driftVel_n=driftVel_n./nmeanVelDrift;
driftVel_s=driftVel_s./nmeanVelDrift;
driftVel_sw=driftVel_sw./nmeanVelDrift;

driftVel_border=driftVel_border./NmeanVelDrift;
driftVel_other=driftVel_other./NmeanVelDrift;
driftVel_strait=driftVel_strait./NmeanVelDrift;
driftVel_circle=driftVel_circle./NmeanVelDrift;
driftVel_otherShape=driftVel_otherShape./NmeanVelDrift;

driftVel_border_s=driftVel_border_s./nmeanVelDrift;
driftVel_other_s=driftVel_other_s./nmeanVelDrift;
driftVel_strait_s=driftVel_strait_s./nmeanVelDrift;
driftVel_circle_s=driftVel_circle_s./nmeanVelDrift;
driftVel_otherShape_s=driftVel_otherShape_s./nmeanVelDrift;

driftTime_N=driftTime_N./NmeanTimeDrift;
driftTime=driftTime./NmeanTimeDrift;
driftTime_n=driftTime_n./nmeanTimeDrift;
driftTime_s=driftTime_s./nmeanTimeDrift;
driftTime_sw=driftTime_sw./nmeanTimeDrift;

driftTime_border=driftTime_border./NmeanTimeDrift;
driftTime_other=driftTime_other./NmeanTimeDrift;
driftTime_strait=driftTime_strait./NmeanTimeDrift;
driftTime_circle=driftTime_circle./NmeanTimeDrift;
driftTime_otherShape=driftTime_otherShape./NmeanTimeDrift;

driftTime_border_s=driftTime_border_s./nmeanTimeDrift;
driftTime_other_s=driftTime_other_s./nmeanTimeDrift;
driftTime_strait_s=driftTime_strait_s./nmeanTimeDrift;
driftTime_circle_s=driftTime_circle_s./nmeanTimeDrift;
driftTime_otherShape_s=driftTime_otherShape_s./nmeanTimeDrift;

%saving normalized:
SavingFile=[['C:\Users\bnapp\Documents\tunnelledVisionPaper\analyzing\resultsVectors\' sub '\'],'normvectorsForStat'];
save(SavingFile,'shapePlaceDrift','shapePlaceDrift_s','driftAmp','driftAmp_N','driftAmp_s','driftAmp_sw','driftAmp_n','driftVel','driftVel_N','driftVel_s','driftVel_sw','driftVel_n',...
    'driftTime','driftTime_N','driftTime_s','driftTime_sw','driftTime_n',...
    'saccAmp','saccAmp_N','saccAmp_s','saccAmp_sw','saccAmp_n','saccVel','saccVel_N','saccVel_s','saccVel_sw','saccVel_n',...
    'saccMaxVel','saccMaxVel_N','saccMaxVel_s','saccMaxVel_sw','saccMaxVel_n','saccPerSec','saccPerSec_N','saccPerSec_s','saccPerSec_sw','saccPerSec_n', ...
    'driftAmp_other','driftAmp_border','driftVel_other','driftVel_border','driftTime_other','driftTime_border','saccAmp_border','saccAmp_ver','saccAmp_hor', ...
    'driftAmp_other_s','driftAmp_border_s','driftVel_other_s','driftVel_border_s','driftTime_other_s','driftTime_border_s','saccAmp_border_s','saccAmp_ver_s','saccAmp_hor_s', ...
    'driftAmp_strait','driftAmp_circle','driftAmp_otherShape','driftVel_strait','driftVel_circle','driftVel_otherShape','driftTime_strait','driftTime_circle','driftTime_otherShape',...
    'driftAmp_strait_s','driftAmp_circle_s','driftAmp_otherShape_s','driftVel_strait_s','driftVel_circle_s','driftVel_otherShape_s','driftTime_strait_s','driftTime_circle_s','driftTime_otherShape_s');
% drift length-dist
figure()
plot(driftDist(driftAmp~=0),driftAmp(driftAmp~=0),'.')
figure()
 hist(driftAmp(driftAmp~=0)./driftDist(driftAmp~=0),80)
 axis([0 50 0 300])
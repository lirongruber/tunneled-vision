% plot all paramatre together:
clear
load('C:\Users\lirongr\Documents\actvie-vision\analyzing\resultsVectors\ALL\allShapewithoutBlackS  AnalogallSessionallTrialcAnswer.mat');
t=length(num_of_sacc);
analog='S';
vecsForStatForsubData(labeled_saccade_vecs,analog,t,time_of_trial_in_sec,num_of_sacc_per_sec,whiteTimes,saccs_amp_degrees,drifts_amp_degrees,saccs_vel_deg2sec,saccs_maxvel_deg2sec,drifts_vel_deg2sec,saccs_time_ms,drifts_time_ms);

load('C:\Users\lirongr\Documents\actvie-vision\analyzing\resultsVectors\ALL\allShapewithoutBlackB  AnalogallSessionallTrialcAnswer.mat');
t=length(num_of_sacc);
analog='B  ';
vecsForStatForsubData(labeled_saccade_vecs,analog,t,time_of_trial_in_sec,num_of_sacc_per_sec,whiteTimes,saccs_amp_degrees,drifts_amp_degrees,saccs_vel_deg2sec,saccs_maxvel_deg2sec,drifts_vel_deg2sec,saccs_time_ms,drifts_time_ms);


% load('C:\Users\lirongr\Documents\actvie-vision\naturalV\resultVectors\CORRECTSMALLvectorsForStat.mat')
load('C:\Users\lirongr\Documents\actvie-vision\naturalV\resultVectors\SMALLvectorsForStat.mat')
cs=c;
gs=g;
hs=h;
es=e;
fs=f;
fs2=f2;
ls=l;
ms=m;

load('C:\Users\lirongr\Documents\actvie-vision\naturalV\resultVectors\vectorsForStat.mat')
load('C:\Users\lirongr\Documents\actvie-vision\naturalV\resultVectors\ALL\nvectorsForStat.mat')



%%
% %Number of Saccades per Second
% [h1,p1]=ttest(log(cs),log(c(1:length(cs))))
% [pooled_std]=pooledStd(c,cs);
% ES=(mean(c)-mean(cs))/pooled_std
% 
% [h1,p1]=ttest(log(c),log(cn(1:length(c))))
% [pooled_std]=pooledStd(c,cn);
% ES=(mean(c)-mean(cn))/pooled_std
% 
% %Time of Saccades in mSec
% [h1,p1]=ttest(log(l),log(ls(1:length(l))))
% [pooled_std]=pooledStd(l,ls);
% ES=(mean(l)-mean(ls))/pooled_std
% [p,hh] = ranksum(log(l),log(ls))
% 
% [h1,p1]=ttest(log(l),log(ln(1:length(l))))
% [pooled_std]=pooledStd(l,ln);
% ES=(mean(l)-mean(ln))/pooled_std
% [p,hh] = ranksum(log(l),log(ln))
% 
% %Time of Drifts in mSec
% [h1,p1]=ttest(log(m),log(ms(1:length(m))))
% [pooled_std]=pooledStd(m,ms);
% ES7=(mean(m)-mean(ms))/pooled_std
% [p,hh] = ranksum(log(m),log(ms))
% 
% 
% [h1,p1]=ttest(log(m),log(mn(1:length(m))))
% [pooled_std]=pooledStd(m,mn);
% ES=(mean(m)-mean(mn))/pooled_std
% [p,hh] = ranksum(log(m),log(mn))
% 
% %Amplitude of DriftS in Degrees
% [h1,p1]=ttest(log(g),log(gs(1:length(g))))
% [pooled_std]=pooledStd(g,gs);
% ES=(mean(g)-mean(gs))/pooled_std
% 
% [h1,p1]=ttest(log(g),log(gn(1:length(g))))
% [pooled_std]=pooledStd(g,gn);
% ES=(mean(g)-mean(gn))/pooled_std
% 
% %Velocity of Drifts in DegperSec
% [h1,p1]=ttest(log(h),log(hs(1:length(h))))
% [pooled_std]=pooledStd(h,hs);
% ES=(mean(h)-mean(hs))/pooled_std
% 
% [h1,p1]=ttest(log(h),log(hn(1:length(h))))
% [pooled_std]=pooledStd(h,hn);
% ES=(mean(h)-mean(hn))/pooled_std





%% number per sec and durations

% plots of t(c,g,h):
figure(1)

subplot(3,3,1)
hold on
axis([ -1 3 0 0.2]);
[N,X] = hist(log(cn),18);

N=N/sum(N);
% plot(X,N,'r')
fittedmodel = fit(X',N', 'gauss1');
hold on
bar(X,N)
plot(fittedmodel)
xisval=get(gca,'XTick');
set(gca,'XTick',xisval);
set(gca,'XTickLabel',round(exp(xisval),2));
leg=legend(['Peak: ' num2str(round(exp(fittedmodel.b1),1)) ' #/sec' ],'Location','northeast') ;
set(leg,'FontSize',15);
xlabel('VALUE','FontSize', 15)
ylabel('HIST of log values','FontSize', 15)
title('Number of Saccades per sec', 'FontSize', 25)

subplot(3,3,4)
hold on
axis([ -1 3 0 0.2]);
[N,X] = hist(log(c),18);

N=N/sum(N);
% plot(X,N,'r')
fittedmodel = fit(X',N', 'gauss1');
hold on
bar(X,N)
plot(fittedmodel)
xisval=get(gca,'XTick');
set(gca,'XTick',xisval);
set(gca,'XTickLabel',round(exp(xisval),2));
leg=legend(['Peak: ' num2str(round(exp(fittedmodel.b1),1)) ' #/sec' ],'Location','northeast') ;
set(leg,'FontSize',15);
xlabel('VALUE','FontSize', 15)
ylabel('HIST of log values','FontSize', 15)
title('Tunneled - BIG', 'FontSize', 25)

subplot(3,3,7)
hold on
axis([ -1 3 0 0.2]);
[N,X] = hist(log(cs),40);

N=N/sum(N);
% plot(X,N,'r')
fittedmodel = fit(X',N', 'gauss1');
hold on
bar(X,N)
plot(fittedmodel)
xisval=get(gca,'XTick');
set(gca,'XTick',xisval);
set(gca,'XTickLabel',round(exp(xisval),2));
leg=legend(['Peak: ' num2str(round(exp(fittedmodel.b1),1)) ' #/sec' ],'Location','northeast') ;
set(leg,'FontSize',15);
xlabel('VALUE','FontSize', 15)
ylabel('HIST of log values','FontSize', 15)
title('Tunneled SMALL', 'FontSize', 25)

subplot(3,3,2)
hold on
axis([ 0 400 0 0.5]);
[N,X] = hist(ln,20);
N=N/sum(N);
% plot(mean(ln),0.5,'*r','markerSize',10)
% startPoints=[0 -5 0 -5];
% fittedmodel = fit(X',N', 'a*x^b+a2*x^b2','Start', startPoints);
hold on
bar(X,N)
% plot(fittedmodel)
leg=legend(['Avarage: '  num2str(round(mean(ln))) ' ms,' ' Median: '  num2str(round(median(ln))) ' ms' ],'Location','northeast') ;
set(leg,'FontSize',15);
xlabel('VALUE','FontSize', 15)
ylabel('HIST','FontSize', 15)
title('Saccades Duration in ms', 'FontSize', 25,'fontweight','bold')

subplot(3,3,5)
hold on
 axis([ 0 400 0 0.5]);
[N,X] = hist(l,20);
N=N/sum(N);
% plot(mean(l),0.5,'*r','markerSize',10)
% startPoints=[0 0 0 0];
% fittedmodel = fit(X',N', 'a*x^b+a2*x^b2','Start', startPoints);
hold on
bar(X,N)
% plot(fittedmodel)
leg=legend(['Avarage: '  num2str(round(mean(l))) ' ms,' ' Median: '  num2str(round(median(l))) ' ms'],'Location','northeast') ;
set(leg,'FontSize',15);
xlabel('VALUE','FontSize', 15)
ylabel('HIST','FontSize', 15)
title('Tunneled BIG', 'FontSize', 25)

subplot(3,3,8)
hold on
 axis([ 0 400 0 0.5]);
[N,X] = hist(ls,20);
N=N/sum(N);
% plot(mean(l),0.5,'*r','markerSize',10)
% startPoints=[0 0 0 0];
% fittedmodel = fit(X',N', 'a*x^b+a2*x^b2','Start', startPoints);
hold on
bar(X,N)
% plot(fittedmodel)
leg=legend(['Avarage: '  num2str(round(mean(ls))) ' ms,' ' Median: '  num2str(round(median(ls))) ' ms'],'Location','northeast') ;
set(leg,'FontSize',15);
xlabel('VALUE','FontSize', 15)
ylabel('HIST','FontSize', 15)
title('Tunneled SMALL', 'FontSize', 25)

subplot(3,3,3)
hold on
axis([ 0 1500 0 0.2]);
[N,X] = hist(mn,30);
N=N/sum(N);
% plot(mean(mn),0.5,'*r','markerSize',10)
% startPoints=[0 -10 0 -10];
% fittedmodel = fit(X',N', 'a*x^b+a2*x^b2','Start', startPoints);
hold on
bar(X,N)
% plot(fittedmodel)
leg=legend(['Avarage: '  num2str(round(mean(mn))) ' ms' ' Median: '  num2str(round(median(mn))) ' ms'],'Location','northeast') ;
set(leg,'FontSize',15);
xlabel('VALUE','FontSize', 15)
ylabel('HIST','FontSize', 15)
title('Drifts Duration in ms', 'FontSize', 25,'fontweight','bold')

subplot(3,3,6)
hold on
axis([ 0 1500 0 0.2]);
[N,X] = hist(m,40);
N=N/sum(N);
% plot(mean(m),0.5,'*r','markerSize',10)
% startPoints=[0 -10 0 -10];
% fittedmodel = fit(X',N', 'a*x^b+a2*x^b2','Start', startPoints);
hold on
bar(X,N)
% plot(fittedmodel)
leg=legend(['Avarage: '  num2str(round(mean(m))) ' ms' ' Median: '  num2str(round(median(m))) ' ms'],'Location','northeast') ;
set(leg,'FontSize',15);
xlabel('VALUE','FontSize', 15)
ylabel('HIST', 'FontSize', 15)
title('Tunneled BIG', 'FontSize', 25)

subplot(3,3,9)
hold on
axis([ 0 1500 0 0.2]);
[N,X] = hist(ms,60);
N=N/sum(N);
% plot(mean(m),0.5,'*r','markerSize',10)
% startPoints=[0 -10 0 -10];
% fittedmodel = fit(X',N', 'a*x^b+a2*x^b2','Start', startPoints);
hold on
bar(X,N)
% plot(fittedmodel)
leg=legend(['Avarage: '  num2str(round(mean(ms))) ' ms,' ' Median: '  num2str(round(median(ms))) ' ms' ],'Location','northeast') ;
set(leg,'FontSize',15);
xlabel('VALUE','FontSize', 15)
ylabel('HIST', 'FontSize', 15)
title('Tunneled SMALL', 'FontSize', 25)

%% drifts
figure(3)

subplot(3,2,1)
hold on
axis([ -5 5 0 0.1]);
[N,X] = hist(log(gn),40);
N=N/sum(N);
% plot(X,N,'r')
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
title('Amplitude of Drift in Degrees', 'FontSize', 25)

subplot(3,2,3)
hold on
axis([ -5 5 0 0.1]);
[N,X] = hist(log(g),40);
N=N/sum(N);
% plot(X,N,'r')
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
title('Tunneled BIG', 'FontSize', 25)

subplot(3,2,5)
hold on
axis([ -5 5 0 0.1]);
[N,X] = hist(log(gs),40);
N=N/sum(N);
% plot(X,N,'r')
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
title('Tunneled SMALL', 'FontSize', 25)

subplot(3,2,2)
hold on
axis([ 0 4 0 0.1]);
[N,X] = hist(log(hn),40);
N=N/sum(N);
% plot(X,N,'r')
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

subplot(3,2,4)
hold on
axis([ 0 4 0 0.1]);
[N,X] = hist(log(h),40);
N=N/sum(N);
% plot(X,N,'r')
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
title('Tunneled BIG', 'FontSize', 25)

subplot(3,2,6)
hold on
axis([ 0 4 0 0.1]);
[N,X] = hist(log(hs),40);
N=N/sum(N);
% plot(X,N,'r')
fittedmodel = fit(X',N', 'gauss2');
hold on
bar(X,N)
plot(fittedmodel)
xisval=get(gca,'XTick');
set(gca,'XTick',xisval);
set(gca,'XTickLabel',round(exp(xisval),2));
leg=legend(['Peaks: ' num2str(round(exp(fittedmodel.b1),1)) ',' num2str(round(exp(fittedmodel.b2),1)) ' deg/sec' ],'Location','northeast') ;
set(leg,'FontSize',15);
xlabel('VALUE','FontSize', 15)
ylabel('HIST of log values','FontSize', 15)
title('Tunneled SMALL', 'FontSize', 25)

% subplot(3,3,3)
% hold on
% axis([ 0 1500 0 0.2]);
% [N,X] = hist(mn,30);
% N=N/sum(N);
% % plot(mean(mn),0.5,'*r','markerSize',10)
% % startPoints=[0 -10 0 -10];
% % fittedmodel = fit(X',N', 'a*x^b+a2*x^b2','Start', startPoints);
% hold on
% bar(X,N)
% % plot(fittedmodel)
% leg=legend(['Avarage: '  num2str(round(mean(mn))) ' ms,' ' Median: '  num2str(round(median(mn))) ' ms' ],'Location','northeast') ;
% set(leg,'FontSize',15);
% xlabel('VALUE','FontSize', 15)
% ylabel('HIST','FontSize', 15)
% title('Drifts Duration in ms', 'FontSize', 25,'fontweight','bold')
% 
% subplot(3,3,6)
% hold on
% axis([ 0 1500 0 0.2]);
% [N,X] = hist(m,40);
% N=N/sum(N);
% % plot(mean(m),0.5,'*r','markerSize',10)
% % startPoints=[0 -10 0 -10];
% % fittedmodel = fit(X',N', 'a*x^b+a2*x^b2','Start', startPoints);
% hold on
% bar(X,N)
% % plot(fittedmodel)
% leg=legend(['Avarage: '  num2str(round(mean(m))) ' ms,' ' Median: '  num2str(round(median(m))) ' ms' ],'Location','northeast') ;
% set(leg,'FontSize',15);
% xlabel('VALUE','FontSize', 15)
% ylabel('HIST', 'FontSize', 15)
% title('Tunneled BIG', 'FontSize', 25)
% 
% subplot(3,3,9)
% hold on
% axis([ 0 1500 0 0.2]);
% [N,X] = hist(ms,60);
% N=N/sum(N);
% % plot(mean(m),0.5,'*r','markerSize',10)
% % startPoints=[0 -10 0 -10];
% % fittedmodel = fit(X',N', 'a*x^b+a2*x^b2','Start', startPoints);
% hold on
% bar(X,N)
% % plot(fittedmodel)
% leg=legend(['Avarage: '  num2str(round(mean(ms))) ' ms,' ' Median: '  num2str(round(median(ms))) ' ms' ],'Location','northeast') ;
% set(leg,'FontSize',15);
% xlabel('VALUE','FontSize', 15)
% ylabel('HIST', 'FontSize', 15)
% title('Tunneled SMALL', 'FontSize', 25)


%% Saccsdes:
figure(2)

subplot(3,3,1)
hold on
axis([ -2 4 0 0.1]);
[N,X] = hist(log(en),40);
N=N/sum(N);
% plot(X,N,'r')
fittedmodel = fit(X',N', 'gauss2');
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
title('Amplitude of Saccades in Degrees', 'FontSize', 25)

subplot(3,3,4)
axis([ -2 4 0 0.1]);
[N,X] = hist(log(e),40);
N=N/sum(N);
% plot(X,N,'r')
fittedmodel = fit(X',N', 'gauss4');
hold on
bar(X,N)
plot(fittedmodel)
xisval=get(gca,'XTick');
set(gca,'XTick',xisval);
set(gca,'XTickLabel',round(exp(xisval),2));
leg=legend(['Peaks: '  num2str(round(exp(fittedmodel.b2),1)) ','  num2str(round(exp(fittedmodel.b3),1)) ' deg'],'Location','northeast') ;
set(leg,'FontSize',15);
xlabel('VALUE','FontSize', 15)
ylabel('HIST of log values','FontSize', 15)
title('Tunneled BIG', 'FontSize', 25)

subplot(3,3,7)
axis([ -2 4 0 0.1]);
[N,X] = hist(log(es),40);
N=N/sum(N);
% plot(X,N,'r')
fittedmodel = fit(X',N', 'gauss4');
hold on
bar(X,N)
plot(fittedmodel)
xisval=get(gca,'XTick');
set(gca,'XTick',xisval);
set(gca,'XTickLabel',round(exp(xisval),2));
leg=legend(['Peaks: '  num2str(round(exp(fittedmodel.b4),1)) ',' num2str(round(exp(fittedmodel.b2),1)) ' deg'],'Location','northeast') ;
set(leg,'FontSize',15);
xlabel('VALUE','FontSize', 15)
ylabel('HIST of log values','FontSize', 15)
title('Tunneled SMALL', 'FontSize', 25)


subplot(3,3,2)
hold on
axis([ 2 8 0 0.1]);
[N,X] = hist(log(fn),40);
N=N/sum(N);
% plot(X,N,'r')
fittedmodel = fit(X',N', 'gauss2');
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
title('av-Velocity of Saccades in DegperSec', 'FontSize', 25)

subplot(3,3,5)
hold on
axis([ 2 8 0 0.1]);
[N,X] = hist(log(f),40);
N=N/sum(N);
% plot(X,N,'r')
fittedmodel = fit(X',N', 'gauss7');
hold on
bar(X,N)
plot(fittedmodel)
xisval=get(gca,'XTick');
set(gca,'XTick',xisval);
set(gca,'XTickLabel',round(exp(xisval),2));
% leg=legend(['Peak: '  num2str(round(exp(fittedmodel.b2),1)) ' deg/sec'],'Location','northeast') ;
leg=legend(['Peaks: '  num2str(round(exp(3.8),1))  ','  num2str(round(exp(5),1)) ' deg/sec'],'Location','northeast') ;
set(leg,'FontSize',15);
xlabel('VALUE','FontSize', 15)
ylabel('HIST of log values','FontSize', 15)
title('Tunneled BIG', 'FontSize', 25)

subplot(3,3,8)
hold on
axis([ 2 8 0 0.1]);
[N,X] = hist(log(fs),40);
N=N/sum(N);
% plot(X,N,'r')
fittedmodel = fit(X',N', 'gauss5');
hold on
bar(X,N)
plot(fittedmodel)
xisval=get(gca,'XTick');
set(gca,'XTick',xisval);
set(gca,'XTickLabel',round(exp(xisval),2));
% leg=legend(['Peak: '  num2str(round(exp(fittedmodel.b2),1)) ' deg/sec'],'Location','northeast') ;
leg=legend(['Peaks: '   num2str(round(exp(fittedmodel.b5),1)) ',' num2str(round(exp(fittedmodel.b4),1)) ' deg/sec'],'Location','northeast') ;
set(leg,'FontSize',15);
xlabel('VALUE','FontSize', 15)
ylabel('HIST of log values','FontSize', 15)
title('Tunneled SMALL', 'FontSize', 25)

subplot(3,3,3)
hold on
axis([ -1 3 0 0.2]);
[N,X] = hist(log(cn),18);

N=N/sum(N);
% plot(X,N,'r')
fittedmodel = fit(X',N', 'gauss1');
hold on
bar(X,N)
plot(fittedmodel)
xisval=get(gca,'XTick');
set(gca,'XTick',xisval);
set(gca,'XTickLabel',round(exp(xisval),2));
leg=legend(['Peak: ' num2str(round(exp(fittedmodel.b1),1)) ' #/sec' ],'Location','northeast') ;
set(leg,'FontSize',15);
xlabel('VALUE','FontSize', 15)
ylabel('HIST of log values','FontSize', 15)
title('Number of Saccades per sec', 'FontSize', 25)

subplot(3,3,6)
hold on
 axis([ -1 3 0 0.2]);
[N,X] = hist(log(c),18);

N=N/sum(N);
% plot(X,N,'r')
fittedmodel = fit(X',N', 'gauss1');
hold on
bar(X,N)
plot(fittedmodel)
xisval=get(gca,'XTick');
set(gca,'XTick',xisval);
set(gca,'XTickLabel',round(exp(xisval),2));
leg=legend(['Peak: ' num2str(round(exp(fittedmodel.b1),1)) ' #/sec' ],'Location','northeast') ;
set(leg,'FontSize',15);
xlabel('VALUE','FontSize', 15)
ylabel('HIST of log values','FontSize', 15)
title('Tunneled - BIG', 'FontSize', 25)

subplot(3,3,9)
hold on
 axis([ -1 3 0 0.2]);
[N,X] = hist(log(cs),40);

N=N/sum(N);
% plot(X,N,'r')
fittedmodel = fit(X',N', 'gauss1');
hold on
bar(X,N)
plot(fittedmodel)
xisval=get(gca,'XTick');
set(gca,'XTick',xisval);
set(gca,'XTickLabel',round(exp(xisval),2));
leg=legend(['Peak: ' num2str(round(exp(fittedmodel.b1),1)) ' #/sec' ],'Location','northeast') ;
set(leg,'FontSize',15);
xlabel('VALUE','FontSize', 15)
ylabel('HIST of log values','FontSize', 15)
title('Tunneled SMALL', 'FontSize', 25)


%% max vel of sacc

% % plots of the Saccades maxV (3a):
% subplot(3,3,5)
% hold on
%  axis([ 2.7 8 0 0.1]);
% [N,X] = hist(log(f2),40);
% N=N/sum(N);
% % plot(X,N,'r')
% fittedmodel = fit(X',N', 'gauss3');
% hold on
% bar(X,N)
% plot(fittedmodel)
% xisval=get(gca,'XTick');
% set(gca,'XTick',xisval);
% set(gca,'XTickLabel',round(exp(xisval),2));
% leg=legend(['Peaks: '  num2str(round(exp(fittedmodel.b2),1))  ','  num2str(round(exp(fittedmodel.b3),1)) ' deg/sec'],'Location','northeast') ;
% set(leg,'FontSize',15);
% xlabel('VALUE','FontSize', 15)
% ylabel('HIST of log values','FontSize', 15)
% title('log MAX Velocity of Saccades in DegperSec', 'FontSize', 25)
% title('Tunneled BIG', 'FontSize', 25)
% 
% subplot(3,3,4)
% hold on
% axis([ 2.7 8 0 0.1]);
% [N,X] = hist(log(fn2),40);
% N=N/sum(N);
% % plot(X,N,'r')
% fittedmodel = fit(X',N', 'gauss4');
% hold on
% bar(X,N)
% plot(fittedmodel)
% xisval=get(gca,'XTick');
% set(gca,'XTick',xisval);
% set(gca,'XTickLabel',round(exp(xisval),2));
% leg=legend(['Peak: '  num2str(round(exp(fittedmodel.b1),1)) ' deg/sec'],'Location','northeast') ;
% set(leg,'FontSize',15);
% xlabel('VALUE','FontSize', 15)
% ylabel('HIST of log values','FontSize', 15)
% title('MAX Velocity of Saccades in DegperSec- NATURAL', 'FontSize', 25)
% 
% subplot(3,3,6)
% % plots of the Saccades maxV (3a):
% hold on
%  axis([ 2.7 8 0 0.1]);
% [N,X] = hist(log(fs2),40);
% N=N/sum(N);
% % plot(X,N,'r')
% fittedmodel = fit(X',N', 'gauss2');
% hold on
% bar(X,N)
% plot(fittedmodel)
% xisval=get(gca,'XTick');
% set(gca,'XTick',xisval);
% set(gca,'XTickLabel',round(exp(xisval),2));
% leg=legend(['Peak: '  num2str(round(exp(fittedmodel.b2),1)) ' deg/sec'],'Location','northeast') ;
% set(leg,'FontSize',15);
% xlabel('VALUE','FontSize', 15)
% ylabel('HIST of log values','FontSize', 15)
% title('Tunneled SMALL', 'FontSize', 25)

%%
% vmax vs amp
figure(4)

subplot(3,2,1)
rel_en=en(fn2<en*95);
rel_fn2=fn2(fn2<en*95);
plot(rel_en,rel_fn2,'.k')
axis([ 0 30 0 2000]);
fittedmodel = fit(rel_en',rel_fn2', 'poly1');
hold on
plot(fittedmodel)
leg=legend(['slope : ' num2str(round(fittedmodel.p1,1)) ]);
set(leg,'FontSize',15);
ylabel(' Vmax [deg/sec]','FontSize', 15)
xlabel('Amp [deg]','FontSize', 15)
title([' NATURAL - "saccadic main sequence" '],'FontSize', 25)

subplot(3,2,3)
rel_e=e(f2<e*95);
rel_f2=f2(f2<e*95);
plot(rel_e,rel_f2,'.b')
axis([ 0 30 0 2000]);
fittedmodel = fit(rel_e',rel_f2', 'poly1');
hold on
plot(fittedmodel)
leg=legend(['slope : ' num2str(round(fittedmodel.p1,1)) ]);
set(leg,'FontSize',15);
ylabel(' Vmax [deg/sec]','FontSize', 15)
xlabel('Amp [deg]','FontSize', 15)
title([' Tunneled BIG - "saccadic main sequence" '],'FontSize', 25)

subplot(3,2,5)
rel_es=es(fs2<es*95);
rel_fs2=fs2(fs2<es*95);
plot(rel_es,rel_fs2,'.r')
axis([ 0 30 0 2000]);
fittedmodel = fit(rel_es',rel_fs2', 'poly1');
hold on
plot(fittedmodel)
leg=legend(['slope : ' num2str(round(fittedmodel.p1,1)) ]);
set(leg,'FontSize',15);
ylabel(' Vmax [deg/sec]','FontSize', 15)
xlabel('Amp [deg]','FontSize', 15)
title([' Tunneled SMALL - "saccadic main sequence" '],'FontSize', 25)

subplot(2,2,2)
hold on
plot(rel_en,rel_fn2,'.k')
plot(rel_e,rel_f2,'.b')
plot(rel_es,rel_fs2,'.r')
axis([ 0 20 0 1500]);
leg=legend( 'NATURAL','Tunneled BIG ','Tunneled SMALL','Location','northwest');
set(leg,'FontSize',15);
ylabel(' Vmax [deg/sec]','FontSize', 15)
xlabel('Amp [deg]','FontSize', 15)
title([' "saccadic main sequence" '],'FontSize', 25)

subplot(2,2,4)
binNum=15;
isStd='off';% 'off' for median, 'on' for mean

hold on
[x_med_out,y_med,y_low,y_high] =binned_plot(rel_en,rel_fn2,binNum,'y_mean_std',isStd,'style','k');
% xs=[find(round(x_med_out)==2,1),find(round(x_med_out)==6,1),find(round(x_med_out)==10,1),find(round(x_med_out)==15,1)];
xs=[2,10,15];
for i=1:length(xs)
h1=plot([x_med_out(xs(i)) x_med_out(xs(i))],[y_high(xs(i)) y_low(xs(i))],'k','MarkerSize',10);
axis([ 0 16 0 1200]);
end
binned_plot(rel_en,rel_fn2,binNum,'y_mean_std',isStd,'style','k')
axis([ 0 16 0 1200]);
l1=num2str(round((y_high(xs)-y_low(xs)),1)');

hold on
[x_med_out,y_med,y_low,y_high] = binned_plot(rel_e,rel_f2,binNum,'y_mean_std',isStd,'style','b');
% xs=[find(round(x_med_out)==2,1),find(round(x_med_out)==6,1),find(round(x_med_out)==10,1),find(round(x_med_out)==16,1)];%30 36 39 40];
xs=[4,11,14];%30 36 39 40];
for i=1:length(xs)
h2=plot([x_med_out(xs(i)) x_med_out(xs(i))],[y_high(xs(i)) y_low(xs(i))],'b','MarkerSize',10);
end
binned_plot(rel_e,rel_f2,binNum,'y_mean_std',isStd,'style','b');
axis([ 0 16 0 1200]);
l2=num2str(round((y_high(xs)-y_low(xs)),1)');

hold on
[x_med_out,y_med,y_low,y_high] =binned_plot(rel_es,rel_fs2,binNum,'y_mean_std',isStd,'style','r');
% xs=[find(round(x_med_out)==2,1),find(round(x_med_out)==6,1),find(round(x_med_out)==10,1),find(round(x_med_out)==15,1)];
xs=[10,14,15];
for i=1:length(xs)
h3=plot([x_med_out(xs(i)) x_med_out(xs(i))],[y_high(xs(i)) y_low(xs(i))],'r','MarkerSize',10);
axis([ 0 16 0 1200]);
end
binned_plot(rel_es,rel_fs2,binNum,'y_mean_std',isStd,'style','r')
axis([ 0 17 0 1200]);
l3=num2str(round((y_high(xs)-y_low(xs)),1)');

leg=legend( [h1,h2,h3],l1 ,l2,l3 , 'Location','northwest') ;
set(leg,'FontSize',15);
ylabel(' Vmax [deg/sec]','FontSize', 15)
xlabel('Amp [deg]','FontSize', 15)
title(['Binned Medians and Quartiles '],'FontSize', 25)

% tilefigs;
% 
% figure()
% plot(ms(hs<exp(1.6)),hs(hs<exp(1.6)),'.r')
% hold on
% plot(ms(hs>=exp(1.6)),hs(hs>=exp(1.6)),'.b')
% leg=legend( 'first peak', 'second peak' , 'Location','northwest') ;
% set(leg,'FontSize',15);
% ylabel(' Velocity of Drift','FontSize', 15)
% xlabel('Duration of Drift','FontSize', 15)
% title('Velocity vs Duration of drifts','FontSize', 25)
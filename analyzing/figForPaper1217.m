% 18/12/2017 figures for paper

startup;
clear
close all

figure(2)
ha2=tight_subplot(3, 6,[.1 .04],[.1 .1],[.1 .1]);
figure(20)
ha20=tight_subplot(2, 4,[.1 .04],[.1 .1],[.1 .1]);
figure(200)
ha200=tight_subplot(4, 6,[.1 .04],[.1 .1],[.1 .1]);

figure(3)
ha3=tight_subplot(2, 3,[.12 .06],[.1 .1],[.1 .1]);


subjects= {'SM','LS','LB','RW','AS' };
temp_driftTime=[]; temp_saccPerSec=[]; temp_driftAmp=[]; temp_driftVel=[]; temp_saccAmp=[]; temp_saccVel=[]; temp_saccMaxVel=[]; 
temp_driftTime_s=[]; temp_saccPerSec_s=[]; temp_driftAmp_s=[]; temp_driftVel_s=[]; temp_saccAmp_s=[];  temp_saccVel_s=[]; temp_saccMaxVel_s=[]; 
temp_driftTime_sw=[]; temp_saccPerSec_sw=[]; temp_driftAmp_sw=[]; temp_driftVel_sw=[]; temp_saccAmp_sw=[];  temp_saccVel_sw=[]; temp_saccMaxVel_sw=[];
temp_driftTime_n=[]; temp_saccPerSec_n=[]; temp_driftAmp_n=[]; temp_driftVel_n=[]; temp_saccAmp_n=[];  temp_saccVel_n=[]; temp_saccMaxVel_n=[];
temp_driftTime_N=[]; temp_saccPerSec_N=[]; temp_driftAmp_N=[]; temp_driftVel_N=[]; temp_saccAmp_N=[];  temp_saccVel_N=[]; temp_saccMaxVel_N=[];
temp_driftTime_other=[]; temp_driftAmp_other=[]; temp_driftTime_border=[]; temp_driftAmp_border=[]; temp_driftVel_other=[]; temp_driftVel_border=[]; temp_saccAmp_border=[]; temp_saccAmp_ver=[]; temp_saccAmp_hor=[];
temp_driftTime_strait=[]; temp_driftAmp_strait=[]; temp_driftTime_circle=[]; temp_driftAmp_circle=[]; temp_driftTime_otherShape=[]; temp_driftAmp_otherShape=[]; temp_driftVel_strait=[]; temp_driftVel_circle=[]; temp_driftVel_otherShape=[]; 
temp_driftTime_other_s=[]; temp_driftAmp_other_s=[]; temp_driftTime_border_s=[]; temp_driftAmp_border_s=[]; temp_driftVel_other_s=[]; temp_driftVel_border_s=[]; temp_saccAmp_border_s=[]; temp_saccAmp_ver_s=[]; temp_saccAmp_hor_s=[];
temp_driftTime_strait_s=[]; temp_driftAmp_strait_s=[]; temp_driftTime_circle_s=[]; temp_driftAmp_circle_s=[]; temp_driftTime_otherShape_s=[]; temp_driftAmp_otherShape_s=[]; temp_driftVel_strait_s=[]; temp_driftVel_circle_s=[]; temp_driftVel_otherShape_s=[]; 

temp_shapePlaceDrift=zeros(2,3); temp_shapePlaceDrift_s=zeros(2,3);

for sub_i=1:length(subjects)
    sub=subjects(sub_i);
    sub=sub{1,1};
load(['C:\Users\bnapp\Documents\tunnelledVisionPaper\analyzing\resultsVectors\' sub '\normvectorsForStat.mat'])
temp_driftTime=[temp_driftTime driftTime]; temp_saccPerSec=[temp_saccPerSec saccPerSec]; temp_driftAmp=[temp_driftAmp driftAmp]; temp_driftVel=[temp_driftVel driftVel]; temp_saccAmp=[temp_saccAmp saccAmp]; temp_saccVel=[temp_saccVel saccVel]; temp_saccMaxVel=[temp_saccMaxVel saccMaxVel]; 
temp_driftTime_s=[temp_driftTime_s driftTime_s]; temp_saccPerSec_s=[temp_saccPerSec_s saccPerSec_s]; temp_driftAmp_s=[temp_driftAmp_s driftAmp_s]; temp_driftVel_s=[temp_driftVel_s driftVel_s]; temp_saccAmp_s=[temp_saccAmp_s saccAmp_s];  temp_saccVel_s=[temp_saccVel_s saccVel_s]; temp_saccMaxVel_s=[temp_saccMaxVel_s saccMaxVel_s]; 
temp_driftTime_sw=[temp_driftTime_sw driftTime_sw]; temp_saccPerSec_sw=[temp_saccPerSec_sw saccPerSec_sw]; temp_driftAmp_sw=[temp_driftAmp_sw driftAmp_sw]; temp_driftVel_sw=[temp_driftVel_sw driftVel_sw]; temp_saccAmp_sw=[temp_saccAmp_sw saccAmp_sw]; temp_saccVel_sw=[temp_saccVel_sw saccVel_sw]; temp_saccMaxVel_sw=[temp_saccMaxVel_sw saccMaxVel_sw];
temp_driftTime_n=[temp_driftTime_n driftTime_n]; temp_saccPerSec_n=[temp_saccPerSec_n saccPerSec_n]; temp_driftAmp_n=[temp_driftAmp_n driftAmp_n]; temp_driftVel_n=[temp_driftVel_n driftVel_n]; temp_saccAmp_n=[temp_saccAmp_n saccAmp_n]; temp_saccVel_n=[temp_saccVel_n saccVel_n]; temp_saccMaxVel_n=[temp_saccMaxVel_n saccMaxVel_n];
temp_driftTime_N=[temp_driftTime_N driftTime_N]; temp_saccPerSec_N=[temp_saccPerSec_N saccPerSec_N]; temp_driftAmp_N=[temp_driftAmp_N driftAmp_N]; temp_driftVel_N=[temp_driftVel_N driftVel_N]; temp_saccAmp_N=[temp_saccAmp_N saccAmp_N]; temp_saccVel_N=[temp_saccVel_N saccVel_N]; temp_saccMaxVel_N=[temp_saccMaxVel_N saccMaxVel_N];
temp_driftTime_other=[temp_driftTime_other driftTime_other]; temp_driftAmp_other=[temp_driftAmp_other driftAmp_other]; temp_driftTime_border=[temp_driftTime_border driftTime_border]; temp_driftAmp_border=[temp_driftAmp_border driftAmp_border]; temp_driftVel_other=[temp_driftVel_other driftVel_other]; temp_driftVel_border=[temp_driftVel_border driftVel_border]; temp_saccAmp_border=[temp_saccAmp_border saccAmp_border]; temp_saccAmp_ver=[temp_saccAmp_ver saccAmp_ver]; temp_saccAmp_hor=[temp_saccAmp_hor saccAmp_hor];
temp_driftTime_strait=[temp_driftTime_strait driftTime_strait]; temp_driftAmp_strait=[temp_driftAmp_strait driftAmp_strait]; temp_driftTime_circle=[temp_driftTime_circle driftTime_circle]; temp_driftAmp_circle=[temp_driftAmp_circle driftAmp_circle]; temp_driftTime_otherShape=[temp_driftTime_otherShape driftTime_otherShape]; temp_driftAmp_otherShape=[temp_driftAmp_otherShape driftAmp_otherShape]; temp_driftVel_strait=[temp_driftVel_strait driftVel_strait]; temp_driftVel_circle=[temp_driftVel_circle driftVel_circle]; temp_driftVel_otherShape=[temp_driftVel_otherShape driftVel_otherShape]; 
temp_driftTime_other_s=[temp_driftTime_other_s driftTime_other_s]; temp_driftAmp_other_s=[temp_driftAmp_other_s driftAmp_other_s]; temp_driftTime_border_s=[temp_driftTime_border_s driftTime_border_s]; temp_driftAmp_border_s=[temp_driftAmp_border_s driftAmp_border_s]; temp_driftVel_other_s=[temp_driftVel_other_s driftVel_other_s]; temp_driftVel_border_s=[temp_driftVel_border_s driftVel_border_s]; temp_saccAmp_border_s=[temp_saccAmp_border_s saccAmp_border_s]; temp_saccAmp_ver_s=[temp_saccAmp_ver_s saccAmp_ver_s]; temp_saccAmp_hor_s=[temp_saccAmp_hor_s saccAmp_hor_s];
temp_driftTime_strait_s=[temp_driftTime_strait_s driftTime_strait_s]; temp_driftAmp_strait_s=[temp_driftAmp_strait_s driftAmp_strait_s]; temp_driftTime_circle_s=[temp_driftTime_circle_s driftTime_circle_s]; temp_driftAmp_circle_s=[temp_driftAmp_circle_s driftAmp_circle_s]; temp_driftTime_otherShape_s=[temp_driftTime_otherShape_s driftTime_otherShape_s]; temp_driftAmp_otherShape_s=[temp_driftAmp_otherShape_s driftAmp_otherShape_s]; temp_driftVel_strait_s=[temp_driftVel_strait_s driftVel_strait_s]; temp_driftVel_circle_s=[temp_driftVel_circle_s driftVel_circle_s]; temp_driftVel_otherShape_s=[temp_driftVel_otherShape_s driftVel_otherShape_s]; 

temp_shapePlaceDrift=temp_shapePlaceDrift+shapePlaceDrift; temp_shapePlaceDrift_s=temp_shapePlaceDrift_s+shapePlaceDrift_s;

perSub_saccPerSec{sub_i}=saccPerSec; perSub_saccPerSec_n{sub_i}=saccPerSec_n; perSub_saccPerSec_N{sub_i}=saccPerSec_N; perSub_saccPerSec_s{sub_i}=saccPerSec_s; 
perSub_driftTime{sub_i}=driftTime; perSub_driftTime_n{sub_i}=driftTime_n; perSub_driftTime_N{sub_i}=driftTime_N; perSub_driftTime_s{sub_i}=driftTime_s; 
perSub_driftAmp{sub_i}=driftAmp; perSub_driftAmp_n{sub_i}=driftAmp_n; perSub_driftAmp_N{sub_i}=driftAmp_N; perSub_driftAmp_s{sub_i}=driftAmp_s; 
perSub_saccAmp{sub_i}=saccAmp; perSub_saccAmp_n{sub_i}=saccAmp_n; perSub_saccAmp_N{sub_i}=saccAmp_N; perSub_saccAmp_s{sub_i}=saccAmp_s; 
perSub_driftVel{sub_i}=driftVel; perSub_driftVel_n{sub_i}=driftVel_n; perSub_driftVel_N{sub_i}=driftVel_N; perSub_hs{sub_i}=driftVel_s; 

% meanAmp(sub_i,1:4)=[mean(driftAmp_N(driftAmp_N~=0)) mean(driftAmp(driftAmp~=0)) mean(driftAmp_n(driftAmp_n~=0)) mean(driftAmp_s(driftAmp_s~=0))];
% pAmp(sub_i,1:2)=[ranksum(driftAmp_N(driftAmp_N>0),driftAmp(driftAmp>0)) ranksum(driftAmp_n(driftAmp_n>0),driftAmp_s(driftAmp_s>0))];

[rate(sub_i,1:4),speed(sub_i,1:4)]=fig2ab_motorStats(ha2,sub,sub_i,driftVel,driftVel_n,driftVel_N,driftVel_s,saccPerSec,saccPerSec_n,saccPerSec_N,saccPerSec_s);
fig2d_vars(ha200,sub,sub_i,saccMaxVel_N,saccMaxVel,saccMaxVel_s,saccMaxVel_n,saccAmp_N,saccAmp,saccAmp_s,saccAmp_n,driftTime,driftTime_n,driftTime_N,driftTime_s,driftVel,driftVel_n,driftVel_N,driftVel_s);
end

driftTime=temp_driftTime; saccPerSec=temp_saccPerSec; driftAmp=temp_driftAmp; driftVel=temp_driftVel; saccAmp=temp_saccAmp; saccVel=temp_saccVel; saccMaxVel=temp_saccMaxVel;
driftTime_s=temp_driftTime_s; saccPerSec_s=temp_saccPerSec_s; driftAmp_s=temp_driftAmp_s; driftVel_s=temp_driftVel_s; saccAmp_s=temp_saccAmp_s; saccVel_s=temp_saccVel_s; saccMaxVel_s=temp_saccMaxVel_s;
driftTime_sw=temp_driftTime_sw; saccPerSec_sw=temp_saccPerSec_sw; driftAmp_sw=temp_driftAmp_sw; driftVel_sw=temp_driftVel_sw; saccAmp_sw=temp_saccAmp_sw; saccVel_sw=temp_saccVel_sw; saccMaxVel_sw=temp_saccMaxVel_sw;
driftTime_n=temp_driftTime_n; saccPerSec_n=temp_saccPerSec_n; driftAmp_n=temp_driftAmp_n; driftVel_n=temp_driftVel_n; saccAmp_n=temp_saccAmp_n; saccVel_n=temp_saccVel_n; saccMaxVel_n=temp_saccMaxVel_n;
driftTime_N=temp_driftTime_N; saccPerSec_N=temp_saccPerSec_N; driftAmp_N=temp_driftAmp_N; driftVel_N=temp_driftVel_N; saccAmp_N=temp_saccAmp_N; saccVel_N=temp_saccVel_N; saccMaxVel_N=temp_saccMaxVel_N;
driftTime_border=temp_driftTime_border; driftAmp_border=temp_driftAmp_border; driftTime_other=temp_driftTime_other; driftAmp_other=temp_driftAmp_other; driftVel_other=temp_driftVel_other; driftVel_border=temp_driftVel_border; saccAmp_border=temp_saccAmp_border; saccAmp_ver=temp_saccAmp_ver; saccAmp_hor=temp_saccAmp_hor ;
driftTime_strait=temp_driftTime_strait; driftAmp_strait=temp_driftAmp_strait; driftTime_circle=temp_driftTime_circle; driftAmp_circle=temp_driftAmp_circle; driftTime_otherShape=temp_driftTime_otherShape; driftAmp_otherShape=temp_driftAmp_otherShape; driftVel_strait=temp_driftVel_strait; driftVel_circle=temp_driftVel_circle; driftVel_otherShape=temp_driftVel_otherShape; 
driftTime_border_s=temp_driftTime_border_s; driftAmp_border_s=temp_driftAmp_border_s; driftTime_other_s=temp_driftTime_other_s; driftAmp_other_s=temp_driftAmp_other_s; driftVel_other_s=temp_driftVel_other_s; driftVel_border_s=temp_driftVel_border_s; saccAmp_border_s=temp_saccAmp_border_s; saccAmp_ver_s=temp_saccAmp_ver_s; saccAmp_hor_s=temp_saccAmp_hor_s ;
driftTime_strait_s=temp_driftTime_strait_s; driftAmp_strait_s=temp_driftAmp_strait_s; driftTime_circle_s=temp_driftTime_circle_s; driftAmp_circle_s=temp_driftAmp_circle_s; driftTime_otherShape_s=temp_driftTime_otherShape_s; driftAmp_otherShape_s=temp_driftAmp_otherShape_s; driftVel_strait_s=temp_driftVel_strait_s; driftVel_circle_s=temp_driftVel_circle_s; driftVel_otherShape_s=temp_driftVel_otherShape_s; 

shapePlaceDrift=temp_shapePlaceDrift; shapePlaceDrift_s=temp_shapePlaceDrift_s;
%
sub='ALL';
sub_i=6;
meanAmp(1:4)=[mean(driftAmp_N(driftAmp_N~=0)) mean(driftAmp(driftAmp~=0)) mean(driftAmp_n(driftAmp_n~=0)) mean(driftAmp_s(driftAmp_s~=0))];
steAmp(1:4)=[ste(driftAmp_N(driftAmp_N~=0)) ste(driftAmp(driftAmp~=0)) ste(driftAmp_n(driftAmp_n~=0)) ste(driftAmp_s(driftAmp_s~=0))];

meanDur(1:4)=[mean(driftTime_N(driftTime_N~=0)) mean(driftTime(driftTime~=0)) mean(driftTime_n(driftTime_n~=0)) mean(driftTime_s(driftTime_s~=0))];
steDur(1:4)=[ste(driftTime_N(driftTime_N~=0)) ste(driftTime(driftTime~=0)) ste(driftTime_n(driftTime_n~=0)) ste(driftTime_s(driftTime_s~=0))];

pAmp(1:2)=[ranksum(driftAmp_N(driftAmp_N>0),driftAmp(driftAmp>0)) ranksum(driftAmp_n(driftAmp_n>0),driftAmp_s(driftAmp_s>0))];

% [rate(6,1:4),speed(6,1:4)]=fig2ab_motorStats(ha2,sub,sub_i,driftVel,driftVel_n,driftVel_N,driftVel_s,saccPerSec,saccPerSec_n,saccPerSec_N,saccPerSec_s);
rate=rate(1:5,:);
speed=speed(1:5,:);


% fig2c_convInstVel;
sub='ALL';
sub_i=6;
fig2d_vars(ha200,sub,sub_i,saccMaxVel_N,saccMaxVel,saccMaxVel_s,saccMaxVel_n,saccAmp_N,saccAmp,saccAmp_s,saccAmp_n,driftTime,driftTime_n,driftTime_N,driftTime_s,driftVel,driftVel_n,driftVel_N,driftVel_s);

fig3b_saccTypes;
fig3c_borderDriftShape;

%%
% extra - velocity conv on borders
figure(300)
ha300=tight_subplot(2, 4,[.1 .04],[.1 .1],[.1 .1]);
figure(30)
ha30=tight_subplot(2, 4,[.1 .04],[.1 .1],[.1 .1]);

fig_extra2c_convVelocityBorders;

% %%  sup : 3 sec control for figures 4+3 !!! change Amos's code !!!
figure(3344)
ha3344=tight_subplot(4, 6,[.1 .04],[.1 .1],[.1 .1]);
% fig3344_sup_three_sec_control;

%% sup : figure3, borders for b, per subject for c.
figure(33)
ha33=tight_subplot(3, 6,[.1 .04],[.1 .1],[.1 .1]);
fig33b_sup_motorStatsBorders;

figure(333)
ha333=tight_subplot(2, 6,[.1 .04],[.1 .1],[.1 .1]);
fig333c_sup_convInstVelPerSub;


%% autocorrelations:
%fig6_autocorr;

% tilefigs;
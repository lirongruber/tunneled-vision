function fig2d_vars(ha200,sub,sub_i,saccMaxVel_N,saccMaxVel,saccMaxVel_s,saccMaxVel_n,saccAmp_N,saccAmp,saccAmp_s,saccAmp_n,driftTime,driftTime_n,driftTime_N,driftTime_s,driftVel,driftVel_n,driftVel_N,driftVel_s)

figure(200)
set(gcf,'units','normalized','outerposition',[0 0 1 1])
% subplot(4,6,sub_i)
axes(ha200(sub_i));
t_saccAmp=saccAmp(saccAmp~=0);
t_saccMaxVel=saccMaxVel(saccAmp~=0);
saccAmp=t_saccAmp(t_saccMaxVel<95*t_saccAmp);
saccMaxVel=t_saccMaxVel(t_saccMaxVel<95*t_saccAmp);
[fittedmodel2,gof2,output2] = fit(saccAmp',saccMaxVel', 'poly1');

t_saccAmp_N=saccAmp_N(saccAmp_N~=0);
t_saccMaxVel_N=saccMaxVel_N(saccAmp_N~=0);
saccAmp_N=t_saccAmp_N(t_saccMaxVel_N<95*t_saccAmp_N);
saccMaxVel_N=t_saccMaxVel_N(t_saccMaxVel_N<95*t_saccAmp_N);
[fittedmodel1,gof1,output1] = fit(saccAmp_N',saccMaxVel_N', 'poly1');

plot(saccAmp,saccMaxVel,'.b')
hold all
plot(saccAmp_N,saccMaxVel_N,'.k')
plot(fittedmodel2,'b')
set( findobj(gca,'type','line'), 'LineWidth', 2);
plot(fittedmodel1,'k')
set( findobj(gca,'type','line'), 'LineWidth', 2);

text(2,1600,['R2 = ' num2str(round(gof2.rsquare,2)) ],'Color','b')
text(2,1300,['R2 = ' num2str(round(gof1.rsquare,2)) ],'Color','k')
legend('off')
axis([ 0 30 0 2000]);
if sub_i==1
    ylabel(' Vmax  [deg/sec]','FontSize', 20)
else
    ylabel([])
end
xlabel('Sacc Amp [deg]','FontSize', 20)
title(sub,'FontSize', 25)
set(gca,'box','off')

% subplot(4,6,sub_i+6)
axes(ha200(sub_i+6));

t_saccAmp_s=saccAmp_s(saccAmp_s~=0);
t_saccMaxVel_s=saccMaxVel_s(saccAmp_s~=0);
saccAmp_s=t_saccAmp_s(t_saccMaxVel_s<95*t_saccAmp_s);
saccMaxVel_s=t_saccMaxVel_s(t_saccMaxVel_s<95*t_saccAmp_s);
[fittedmodel4,gof4,output4] = fit(saccAmp_s',saccMaxVel_s', 'poly1');

t_saccAmp_n=saccAmp_n(saccAmp_n~=0);
t_saccMaxVel_n=saccMaxVel_n(saccAmp_n~=0);
saccAmp_n=t_saccAmp_n(t_saccMaxVel_n<95*t_saccAmp_n);
saccMaxVel_n=t_saccMaxVel_n(t_saccMaxVel_n<95*t_saccAmp_n);
[fittedmodel3,gof3,output3] = fit(saccAmp_n',saccMaxVel_n', 'poly1');

plot(saccAmp_s,saccMaxVel_s,'.m')
hold all
plot(saccAmp_n,saccMaxVel_n,'.k')
plot(fittedmodel4,'m')
set( findobj(gca,'type','line'), 'LineWidth', 2);
plot(fittedmodel3,'k')
set( findobj(gca,'type','line'), 'LineWidth', 2);

text(2,1600,['R2 = ' num2str(round(gof4.rsquare,2)) ],'Color','m')
text(2,1300,['R2 = ' num2str(round(gof3.rsquare,2)) ],'Color','k')
legend('off')
%     leg=legend(['R^2 : ' num2str(round(gof4.rsquare,2)) ],['R^2 : ' num2str(round(gof3.rsquare,2)) ]);
% set(leg,'FontSize',20);
axis([ 0 30 0 2000]);
if sub_i==1
    ylabel('Vmax [deg/sec]','FontSize', 20)
else
    ylabel([])
end
xlabel('Sacc Amp [deg]','FontSize', 20)
set(gca,'box','off')

if sub_i==6
    %     subplot(4,6,6)
    axes(ha200(6));
    hold off
    step=3;
    mean1=[];
    mean2=[];
    errBar1=[];
    errBar2=[];
    N1=[];
    N2=[];
    i=0;
    for bins=0:step:15
        i=i+1;
        mean1(i)=mean(abs(output1.residuals(saccAmp_N>bins & saccAmp_N<bins+step)));
        errBar1(i)=std(abs(output1.residuals(saccAmp_N>bins & saccAmp_N<bins+step)));
        N1(i)=size(abs(output1.residuals(saccAmp_N>bins & saccAmp_N<bins+step)),1);
        mean2(i)=mean(abs(output2.residuals(saccAmp>bins & saccAmp<bins+step)));
        errBar2(i)=std(abs(output2.residuals(saccAmp>bins & saccAmp<bins+step)));
        N2(i)=size(abs(output2.residuals(saccAmp>bins & saccAmp<bins+step)),1);
    end
    figure(201)
    subplot(1,2,1)
    plot(0:step:15,mean1,'k', 'LineWidth',3)
    hold on
    plot(0:step:15,mean2,'b', 'LineWidth',3)
    H=shadedErrorBar(0:step:15,mean1,errBar1./sqrt(N1),'k');
    H=shadedErrorBar(0:step:15,mean2,errBar2./sqrt(N2),'b');
    plot([7.5 7.5],[0 130],'--k')
    
    axis([0 10 0 125]);
    ylabel('Res Mean','FontSize', 20)
    xlabel('Amp [deg]','FontSize', 20)
    leg=legend( 'Natural LARGE','Tunneled LARGE ');
    set(leg,'FontSize',15,'Position',[0.9040    0.8363    0.0896    0.0551]);
    legend boxoff
    NumTicks = 3;
    L = get(gca,'YLim');
    set(gca,'YTick',linspace(L(1),L(2),NumTicks))
    title('Linear-fit Residuals','FontSize', 25)
    set(gca,'box','off')
    %     subplot(4,6,12)
    axes(ha200(12));
    hold off
    step=3;
    mean3=[];
    mean4=[];
    errBar3=[];
    errBar4=[];
    N3=[];
    N4=[];
    i=0;
    for bins=0:step:15
        i=i+1;
        mean3(i)=mean(abs(output3.residuals(saccAmp_n>bins & saccAmp_n<bins+step)));
        errBar3(i)=std(abs(output3.residuals(saccAmp_n>bins & saccAmp_n<bins+step)));
        N3(i)=size(abs(output3.residuals(saccAmp_n>bins & saccAmp_n<bins+step)),1);
        mean4(i)=mean(abs(output4.residuals(saccAmp_s>bins & saccAmp_s<bins+step)));
        errBar4(i)=std(abs(output4.residuals(saccAmp_s>bins & saccAmp_s<bins+step)));
        N4(i)=size(abs(output4.residuals(saccAmp_s>bins & saccAmp_s<bins+step)),1);
    end
    figure(201)
    subplot(1,2,2)
    plot(0:step:15,mean3,'k', 'LineWidth',3)
    hold on
    plot(0:step:15,mean4,'m', 'LineWidth',3)
    H=shadedErrorBar(0:step:15,mean3,errBar3./sqrt(N3),'k');
    H=shadedErrorBar(0:step:15,mean4,errBar4./sqrt(N4),'m');
    plot([3 3],[0 130],'--k')
    
    axis([0 10 0 125]);
    ylabel('Res Mean','FontSize', 20)
    xlabel('Amp [deg]','FontSize', 20)
    leg=legend( 'Natural SMALL','Tunneled SMALL ');
    set(leg,'FontSize',15,'Position',[0.9040    0.6163    0.0896    0.0551]);
    legend boxoff
    NumTicks = 3;
    L = get(gca,'YLim');
    set(gca,'YTick',linspace(L(1),L(2),NumTicks))
    %     title(['Residuals'],'FontSize', 25)
    set(gca,'box','off')
end

figure(200)
% subplot(4,6,sub_i+12)
axes(ha200(sub_i+12));
driftTime=driftTime(driftVel~=0);
driftVel=driftVel(driftVel~=0);
driftTime_N=driftTime_N(driftVel_N~=0);
driftVel_N=driftVel_N(driftVel_N~=0);

plot(driftTime./1000,driftVel,'.b')
% text(600,20,['N=' num2str(size(driftTime,2))],'color','b','FontSize', 15)
hold all
plot(driftTime_N./1000,driftVel_N,'.k')
% text(600,15,['N=' num2str(size(driftTime_N,2))],'color','k','FontSize', 15)
title(sub,'FontSize', 25)
[h,p,ci,stats] = vartest2(driftVel,driftVel_N);
if h==1
    text(1,15,'*','color','k','FontSize', 15)
end

figure(200)
varT_temp=driftVel(driftTime<500);
S=size(varT_temp,2);
S=floor(S/5);
varsT=[var(varT_temp(1:S)) var(varT_temp(S+1:2*S)) var(varT_temp(2*S+1:3*S)) var(varT_temp(3*S+1:4*S)) var(varT_temp(4*S+1:end))];
steT=round(ste(varsT),1);

varN_temp=driftVel_N(driftTime_N<500);
S=size(varN_temp,2);
S=floor(S/5);
varsN=[var(varN_temp(1:S)) var(varN_temp(S+1:2*S)) var(varN_temp(2*S+1:3*S)) var(varN_temp(3*S+1:4*S)) var(varN_temp(4*S+1:end))];
steN=round(ste(varsN),1);

varT=round(var(driftVel(driftTime<500)),1);
meanT=round(mean(driftVel(driftTime<500)),1);
varN=round(var(driftVel_N(driftTime_N<500)),1);
meanN=round(mean(driftVel_N(driftTime_N<500)),1);

varT=round(var(driftVel),1);
meanT=round(mean(driftVel),1);
varN=round(var(driftVel_N),1);
meanN=round(mean(driftVel_N),1);

% xlabel('Duration [ms]','FontSize', 20)
if strcmp(sub,'ALL')
%     leg=legend(['Var(d<500)=' num2str(varT)  '+-' num2str(steT)],['Var(d<500)=' num2str(varN) '+-' num2str(steN)]);
    leg=legend(['CV=' num2str(round(varT/meanT,2))],['CV=' num2str(round(varN/meanN,2))]);
    set(leg,'FontSize',15,'Position',[0.8390    0.3953    0.0896    0.0551]);
    legend boxoff
%     title('Speed Variance', 'FontSize', 25)
end
if sub_i==1
    ylabel('Speed [deg/sec]','FontSize', 20)
else
    ylabel([])
end
axis([ 0 2 0 20]);
set(gca,'box','off')

figure(200)
% subplot(4,6,sub_i+18)
axes(ha200(sub_i+18));
driftTime_s=driftTime_s(driftVel_s~=0);
driftVel_s=driftVel_s(driftVel_s~=0);
driftTime_n=driftTime_n(driftVel_n~=0);
driftVel_n=driftVel_n(driftVel_n~=0);

plot(driftTime_s./1000,driftVel_s,'.m')
% text(600,20,['N=' num2str(size(driftTime_s,2))],'color','m','FontSize', 15)
hold all
plot(driftTime_n./1000,driftVel_n,'.k')
% text(600,15,['N=' num2str(size(driftTime_n,2))],'color','k','FontSize', 15)
[h,p,ci,stats] = vartest2(driftVel_s,driftVel_n);
if h==1
    text(1,15,'*','color','k','FontSize', 15)
end

figure(200)
varT_temp=driftVel_s(driftTime_s<500);
S=size(varT_temp,2);
S=floor(S/5);
varsT=[var(varT_temp(1:S)) var(varT_temp(S+1:2*S)) var(varT_temp(2*S+1:3*S)) var(varT_temp(3*S+1:4*S)) var(varT_temp(4*S+1:end))];
steT=round(ste(varsT),1);

varN_temp=driftVel_n(driftTime_n<500);
S=size(varN_temp,2);
S=floor(S/5);
varsN=[var(varN_temp(1:S)) var(varN_temp(S+1:2*S)) var(varN_temp(2*S+1:3*S)) var(varN_temp(3*S+1:4*S)) var(varN_temp(4*S+1:end))];
steN=round(ste(varsN),1);

varT=round(var(driftVel_s(driftTime_s<500)),1);
meanT=round(mean(driftVel_s(driftTime_s<500)),1);
varN=round(var(driftVel_n(driftTime_n<500)),1);
meanN=round(mean(driftVel_n(driftTime_n<500)),1);

varT=round(var(driftVel_s),1);
meanT=round(mean(driftVel_s),1);
varN=round(var(driftVel_n),1);
meanN=round(mean(driftVel_n),1);

xlabel('Pause duration [sec]','FontSize', 20)
if strcmp(sub,'ALL')
%     leg=legend(['Var(d<500)=' num2str(varT)  '+-' num2str(steT)],['Var(d<500)=' num2str(varN) '+-' num2str(steN)]);
    leg=legend(['CV=' num2str(round(varT/meanT,2)) ],['CV=' num2str(round(varN/meanN,2))]);
    set(leg,'FontSize',15,'Position',[0.8390    0.1753    0.0896    0.0551]);
    legend boxoff
    %     rectangle('Position',[-100 9 550 8],'Curvature',[1 1],'EdgeColor','g','LineWidth',3);
end
if sub_i==1
    ylabel('Speed [deg/sec]','FontSize', 20)
else
    ylabel([])
end
axis([ 0 2 0 20]);
set(gca,'box','off')

end
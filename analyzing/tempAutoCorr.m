% autocorr simulations
clear all
% close all
x=10:10:800;
h=0;

perTime=100; %ms
%                  X: NS(11) S(25) NB(11) B(20)   
all_fracPeriodTrials=[0.05 0.27  0.08 0.26 ];  allB=[-0.09 -0.03 -0.09 -0.04 ];
%                  Y: NS(13) S(25) NB(10) B(17)   
% all_fracPeriodTrials=[ 0.19 0.45 0.06 0.32 ];  allB=[-0.07  -0.03 -0.1  -0.05 ];

formodel=0;
if formodel==1 
all_fracPeriodTrials=[0.2  0.4   0.6  0.8];  allB=[-0.02 -0.02 -0.02 -0.02];
end
if formodel==2
all_fracPeriodTrials=[0.4  0.4  0.4  0.4];  allB=[-0.01 -0.02  -0.03 -0.04 ];
end
colors=['k' 'm' 'k' 'b' ];
A=2*pi/perTime;
for fig=1:size(all_fracPeriodTrials,2)
    fracPeriodTrials=all_fracPeriodTrials(fig);
    B=allB(fig);
    color=colors(fig);
    h=h+0.1;
    ydiff1=sin(A*x).*exp(B*x);%+0.1*rand(1,size(x,2));
    ydiff2=exp(B*x);%+0.1*rand(1,size(x,2));
    yfinal=fracPeriodTrials*ydiff1+(1-fracPeriodTrials)*ydiff2;
    
    ydiff=yfinal;
    y(1)=ydiff(1);
    for i=2:size(ydiff,2)
        y(i)=ydiff(i)+y(i-1);
    end
    
    figure(1)
    subplot(2,2,1)
    title('Travelled Distance - integral')
    hold all
    plot(x,y)
    axis([0 200 0 4])
%     if formodel~=0
%         color='k';
%     end
%     text(30,40-h*40,['percent periodic trials=' num2str(fracPeriodTrials)],'color',color,'FontSize',15)
   
    subplot(2,2,2)
    %
    figure(5)
    subplot(2,6,6)
    
    title('Travelled Distance autocorr')
    hold all
    [xcf,lags,bounds]=crosscorr(y,y,max(20,size(x,2)/2));
    if formodel==0
    plot(lags(round(size(lags,2)/2):end).*100,xcf(round(size(lags,2)/2):end),'--','color',color)
    text(205,1-h-0.5,['period=' num2str(fracPeriodTrials) '  B=' num2str(B)],'color',color,'FontSize',15)
    else
    plot(lags(round(size(lags,2)/2):end).*10,xcf(round(size(lags,2)/2):end))
    text(200,1-h-0.5,['period=' num2str(fracPeriodTrials) '  B=' num2str(B)],'FontSize',15)
    end
    if formodel==0
%     f=fit(lags(round(size(lags,2)/2):end)'.*10,xcf(round(size(lags,2)/2):end)','exp1','StartPoint', [1 -0.05]);
%     plot(f,'k')
%     text(150,1-h,['Tau decay=' num2str(round(1/-round(f.b,2))) 'ms'],'color',color,'FontSize',15)
    legend('off')
%     legend(['period=' num2str(fracPeriodTrials) '  B=' num2str(B)],'location','southEast')
    ylabel('')
    end
    axis([0 200 0 1])
    
    
end

    figure(1)
subplot(2,2,3)
    title('Instantaneous Velocity - signal')
    hold all
    plot(x,ydiff1)
    plot(x,ydiff2)
    text(30,0.8,'(1) sin(A*x)*exp(B*x)','color','k','FontSize',15)
    text(30,0.6,'(2) exp(B*x)','color','k','FontSize',15)
    axis([0 200 -0.5 1])
    
    subplot(2,2,4)
    title('Instantaneous Velocity autocorr')
    hold all
    [xcf,lags,bounds]=crosscorr(ydiff1,ydiff1,max(20,size(x,2)/2));
    plot(lags(round(size(lags,2)/2):end).*10,xcf(round(size(lags,2)/2):end))
    [xcf,lags,bounds]=crosscorr(ydiff2,ydiff2,max(20,size(x,2)/2));
    plot(lags(round(size(lags,2)/2):end).*10,xcf(round(size(lags,2)/2):end))
    axis([0 200 -.2 1])

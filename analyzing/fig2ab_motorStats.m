function [rate,speed]=fig2ab_motorStats(ha2,sub,sub_i,driftVel,driftVel_n,driftVel_N,driftVel_s,saccPerSec,saccPerSec_n,saccPerSec_N,saccPerSec_s)

histB=0.5;
figure(2)
set(gcf,'units','normalized','outerposition',[0 0 1 1])
% subplot(3,6,sub_i)
axes(ha2(sub_i));
meansSaccRate=[ mean(saccPerSec_N) mean(saccPerSec) mean(saccPerSec_n) mean(saccPerSec_s) ];
rate=[ median(saccPerSec_N) median(saccPerSec) median(saccPerSec_n) median(saccPerSec_s) ];
steSaccRate=[ste(saccPerSec_N) ste(saccPerSec)  ste(saccPerSec_n) ste(saccPerSec_s) ];
methods={ 'Nat L','Tun L','Nat S', 'Tun S'};
plot(1:2,meansSaccRate(1:2),'b');
hold all
% plot(1,meansSaccRate(1),'.k');
plot(3:4,meansSaccRate(3:4),'m');
% plot(3,meansSaccRate(4),'.k');
errorbar(1,meansSaccRate(1),steSaccRate(1),'-','Color','k');
errorbar(2,meansSaccRate(2),steSaccRate(2),'-','Color','b');
errorbar(3,meansSaccRate(3),steSaccRate(3),'-','Color','k');
errorbar(4,meansSaccRate(4),steSaccRate(4),'-','Color','m');
[h,pB,ci,stats1]=ttest2(saccPerSec,saccPerSec_N);
[h,pS,ci,stats2]=ttest2(saccPerSec_s,saccPerSec_n);
% [~,p]=ttest2([saccPerSec_s saccPerSec],[saccPerSec_n saccPerSec_N]);
[h,p,ci,stats3]=ttest2(saccPerSec_n, saccPerSec_N);
% if sub_i==6
%     text(5,7,[num2str(round(meansSaccRate(1),2)) '+-' num2str(round(steSaccRate(1),2))],'color','k')
%     text(5,6,[num2str(round(meansSaccRate(2),2)) '+-' num2str(round(steSaccRate(2),2))],'color','b')
%     text(5,5,[num2str(round(meansSaccRate(3),2)) '+-' num2str(round(steSaccRate(3),2))],'color','k')
%     text(5,4,[num2str(round(meansSaccRate(4),2)) '+-' num2str(round(steSaccRate(4),2))],'color','m')
% end
 

title(sub, 'FontSize', 25)

if pB<0.05
    if sub_i==1
    text(1.2,1.5, '*','Fontsize',25)
    text(1.5,2.5,'}','Fontsize',25,'Rotation',270)
    else
    text(1.2,7, '*','Fontsize',25)
    text(1.3,7,'}','Fontsize',25,'Rotation',90)
    end
end
if pS<0.05
    if sub_i==1
        text(3.2,1.5, '*','Fontsize',25)
        text(3.5,2.5,'}','Fontsize',25,'Rotation',270)
    else
        text(3.2,7, '*','Fontsize',25)
        text(3.3,7,'}','Fontsize',25,'Rotation',90)
    end
end
if p<0.05
    if sub_i==1
        text(1.7,0.2, '*','Fontsize',40)
        text(2.2,1.5,'}','Fontsize',40,'Rotation',270)
    else
        text(1.7,6, '*','Fontsize',40)
        text(1.9,6,'}','Fontsize',40,'Rotation',90)
    end
end
set(gca, 'XTick', 1:4, 'XTickLabel', methods,'Fontsize',20);
set(gca,'XTickLabelRotation',45);
title(sub, 'FontSize', 25)
axis([ 0 5 0 8]);
if sub_i==1
    ylabel('saccadic rate [\#/sec]','Fontsize',20)
else
    ylabel([])
end
if strcmp(sub,'ALL')
%     title('Saccadic Rate','Fontsize',25);
end
    set(gca,'box','off')

figure(2)
% subplot(3,6,sub_i+6)
axes(ha2(sub_i+6));

speed(1)=median(driftVel_N(driftVel_N>0));
figure(99)
h1=histogram(driftVel_N(driftVel_N>0),0:histB:30,'Normalization','probability','FaceColor','k');
num_N=size(driftVel_N(driftVel_N>0),2);

figure(2)
yy1=smooth(h1.BinCounts./sum(h1.BinCounts));
% plot(0:histB:9.8,h1.BinCounts./sum(h1.BinCounts),'k');
plot(0:histB:29.8,yy1,'k')
hold all

% % % yy1fit=polyfit(0:histB:29.8,h1.BinCounts./sum(h1.BinCounts),4);
% % % x1fit = linspace(0,29.8);
% % % yy1 = polyval(yy1fit,x1fit);
% % % plot(x1fit,yy1,'color','k')
% % % hold all
speed(2)=median(driftVel(driftVel>0));
figure(99)
h2=histogram(driftVel(driftVel>0),0:histB:30,'Normalization','probability','FaceColor','b');
num=size(driftVel(driftVel>0),2);

figure(2)
yy2=smooth(h2.BinCounts./sum(h2.BinCounts));
% plot(0:histB:9.8,h2.BinCounts./sum(h2.BinCounts),'b')
% title(['N=' num2str(num_N) ' T='  num2str(num)])
plot(0:histB:29.8,yy2,'b')

% % % yy2fit=polyfit(0:histB:29.8,h2.BinCounts./sum(h2.BinCounts),4);
% % % x2fit = linspace(0,29.8);
% % % yy2 = polyval(yy2fit,x2fit);
% % % plot(x2fit,yy1,'color','b')

axis([ 0 15 0 0.2]);
plot( mean(driftVel_N(driftVel_N>0))*[1,1,1,1,1], 0:0.1:0.4,'k--')
plot( mean(driftVel(driftVel>0))*[1,1,1,1,1], 0:0.1:0.4,'b--')
if sub_i==6
% text(11,0.1,[num2str(round(mean(driftVel_N(driftVel_N>0)),2)) '+-' num2str(round(ste(driftVel_N(driftVel_N>0)),2))],'FontSize',20);
% text(11,0.07,[num2str(round(mean(driftVel(driftVel>0)),2)) '+-' num2str(round(ste(driftVel(driftVel>0)),2)) ],'Color','blue','FontSize',20);
end
% xlabel('Speed [deg/sec]','FontSize',20)
% [sB,tB]=ttest2(driftVel_N(driftVel_N>0),driftVel(driftVel>0));
p=ranksum(driftVel_N(driftVel_N>0),driftVel(driftVel>0));
if p<0.05
    text(( median(driftVel_N(driftVel_N>0))+median(driftVel(driftVel>0)))/2-0.4,0.17,'*','FontSize',25)
    if  median(driftVel_N(driftVel_N>0)) >median(driftVel(driftVel>0))
        text(( median(driftVel_N(driftVel_N>0))+median(driftVel(driftVel>0)))/2-0.4,0.17,'*','Color','r','FontSize',25)
    end
end

if sub_i==1
    ylabel('fraction of pauses','FontSize', 20)
else
    ylabel([])
    set(gca, 'YTick', 0.1:0.1:0.2, 'YTickLabel', {'','',''},'Fontsize',20);
end
if strcmp(sub,'ALL')
    leg=legend('Natural Large', 'Tunneled Large','Location','NorthEast') ;
    set(leg,'FontSize', 25,'Position',[0.8890    0.5463    0.0556    0.0551]);
    legend boxoff
%     title('Drift Speed', 'FontSize', 25)
end
set(gca,'box','off')

speed(3)=median(driftVel_n(driftVel_n>0));
figure(99)
h1=histogram(driftVel_n(driftVel_n>0),0:histB:30,'Normalization','probability','FaceColor','k');
num_N=size(driftVel_n(driftVel_n>0),2);

figure(2)
% subplot(3,6,sub_i+12)
axes(ha2(sub_i+12));
yy3=smooth(h1.BinCounts./sum(h1.BinCounts));
% plot(0:histB:9.8,h1.BinCounts./sum(h1.BinCounts),'k');
plot(0:histB:29.8,yy3,'k')
hold all

% % % yy1fit=polyfit(0:histB:29.8,h1.BinCounts./sum(h1.BinCounts),4);
% % % x1fit = linspace(0,29.8);
% % % yy3 = polyval(yy1fit,x1fit);
% % % plot(x1fit,yy3,'color','k')
% % % hold all
speed(4)=median(driftVel_s(driftVel_s>0));
figure(99)
h2=histogram(driftVel_s(driftVel_s>0),0:histB:30,'Normalization','probability','FaceColor','m');
num=size(driftVel_s(driftVel_s>0),2);

figure(2)
% subplot(3,6,sub_i+12)
axes(ha2(sub_i+12));
yy4=smooth(h2.BinCounts./sum(h2.BinCounts));
% plot(0:histB:9.8,h2.BinCounts./sum(h2.BinCounts),'m')
% title(['N=' num2str(num_N) ' T='  num2str(num)])
plot(0:histB:29.8,yy4,'m')

% % % yy2fit=polyfit(0:histB:29.8,h2.BinCounts./sum(h2.BinCounts),4);
% % % x2fit = linspace(0,29.8);
% % % yy4 = polyval(yy2fit,x2fit);
% % % plot(x2fit,yy4,'color','m')

axis([ 0 15 0 0.2]);

plot( mean(driftVel_n(driftVel_n>0))*[1,1,1,1,1], 0:0.1:0.4,'k--')
plot( mean(driftVel_s(driftVel_s>0))*[1,1,1,1,1], 0:0.1:0.4,'m--')
if sub_i==6
% text(11,0.1,[num2str(round(mean(driftVel_n(driftVel_n>0)),2)) '+-' num2str(round(ste(driftVel_n(driftVel_n>0)),2))],'FontSize',20);
% text(11,0.07,[num2str(round(mean(driftVel_s(driftVel_s>0)),2)) '+-' num2str(round(ste(driftVel_s(driftVel_s>0)),2))], 'Color','m','FontSize',20);
end
xlabel('Speed [deg/sec]','FontSize',20)
% [s,t]=ttest2(driftVel_n(driftVel_n>0),driftVel_s(driftVel_s>0));
p=ranksum(driftVel_n(driftVel_n>0),driftVel_s(driftVel_s>0));
if p<0.05
    text(( median(driftVel_n(driftVel_n>0))+median(driftVel_s(driftVel_s>0)))/2-0.4,0.17,'*','FontSize',25)
end
if sub_i==1
    ylabel('fraction of pauses','FontSize', 20)
else
    set(gca, 'YTick', 0.1:0.1:0.2, 'YTickLabel', {'','',''},'Fontsize',20);
    ylabel([])
end
if strcmp(sub,'ALL')
    leg=legend('Natural Small', 'Tunneled Small') ;
    set(leg,'FontSize', 25,'Position',[0.8890    0.2463    0.0556    0.0551]);
    legend boxoff
%     title('Drift Speed', 'FontSize', 25)
end
set(gca,'box','off')
close(99)

% % % yy1=1:60;
% % % yy2=1:60;
% % % yy3=1:60;
% % % yy4=1:60;

end
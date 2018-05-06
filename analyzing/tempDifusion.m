time=1:10:5000;
titles={'NB', 'B','NS','S'};
figure(1)
for type=1:4
    currX=distXPerCond{type};
    currX(currX==0)=nan;
    currY=distYPerCond{type};
    currY(currY==0)=nan;
    
    subplot(3,4,type)
%     plot(time,nanmean(currX))
    shadedErrorBar(time,nanmean(currX),nanstd(currX));
    hold on
    xlabel('Time [ms]','FontSize',25)
    ylabel('Dist horizontal [deg]','FontSize',25)
    title(titles{type},'FontSize',25)
    axis([0 2000 0 1])
    
    subplot(3,4,type+4)
%     plot(time,nanmean(currY))
    shadedErrorBar(time,nanmean(currY),nanstd(currY));
    hold on
    xlabel('Time [ms]','FontSize',25)
    ylabel('Dist vertical [deg]','FontSize',25)
    axis([0 2000 0 1])
    
%     subplot(3,4,type+8)
% %     plot(time,nanmean(sqrt(currX.^2+currY.^2)))
%     currXY=sqrt(currX(1:300,:).^2+currY(1:300,:).^2);
%     shadedErrorBar(time,nanmean(currXY),nanstd(currXY)./300);
%     hold on
%     xlabel('Time [ms]')
%     ylabel('Dist [deg]')
%     axis([0 2000 0 1])
end
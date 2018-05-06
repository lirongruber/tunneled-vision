clear
close all
nameoffile={'cir.fig','par.fig', 'rec.fig', 'squ.fig','tri.fig'};
% nameoffile={'cir2.fig','par2.fig', 'rec2.fig', 'squ2.fig','tri2.fig'};
for k=1:length(nameoffile)
    curnameoffile=nameoffile{k};
    open(['C:\Users\bnapp\Documents\tunnelledVisionPaper\imagesForFigur3\' curnameoffile]);
    h = gcf;
    axesObjs = get(h, 'Children');  %axes handles
    dataObjs = get(axesObjs, 'Children');
    x=[];
    y=[];
    for i=1:length(dataObjs)
        if strcmp(dataObjs(i).Type,'line')
            x=[x fliplr(dataObjs(i).XData)];
            y=[y fliplr(dataObjs(i).YData)];
            %                plot(dataObjs(i).XData,dataObjs(i).YData)
        else
%             break
        end
    end
    
    figure(k+10);
    ha=tight_subplot(2, 1,[.1 .02],[.2 .1],[.2 .05]);
    axes(ha(1));
    %     subplot(2,1,1)
    plot(0:10:10*length(x)-10,x,'LineWidth',5)
    %     axis([0 10*length(x)-10 0 1500])
    axis([0 8000 0 1500])
%     axis([0 3000 0 1500])
    set(gca,'xtick',[], 'FontSize', 60);
    ylabel('Horizontal', 'FontSize', 80)
    
    axes(ha(2));
    %     subplot(2,1,2)
    plot(0:10:10*length(y)-10,y,'LineWidth',5)
    %     axis([0 10*length(y)-10 0 1080])
    axis([0 8000 0 1500])
%     axis([0 3000 0 1500])
    set(gca, 'FontSize', 60);
    ylabel('Vertical', 'FontSize', 80)
    xlabel('time [ms]', 'FontSize', 80)
    figure(k)
end
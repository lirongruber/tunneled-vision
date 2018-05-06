clear
close all
nameoffile={'xy_cir1.mat','xy_par1.mat', 'xy_rec1.mat', 'xy_squ1.mat','xy_tri1.mat'};
% nameoffile={'xy_cir2.mat','xy_par2.mat', 'xy_rec2.mat', 'xy_squ2.mat','xy_tri2.mat'};
for k=1:length(nameoffile)
    curnameoffile=nameoffile{k};
    load(['C:\Users\bnapp\Documents\tunnelledVisionPaper\imagesForFigur3\' curnameoffile]);
    x=XY_vecs_deg(1,:);
    y=XY_vecs_deg(2,:);
    figure(k);
    ha=tight_subplot(2, 1,[.1 .02],[.2 .1],[.2 .05]);
    axes(ha(1));
    plot(0.001:0.01:length(x)/100,x,'LineWidth',5)
    axis([0 10 -10 10])
    
    set(gca,'xtick',[], 'FontSize', 60);
    ylabel('Horizontal', 'FontSize', 80)
    
    axes(ha(2));
    plot(0.001:0.01:length(y)/100,y,'LineWidth',5)
    axis([0 10 -10 10])

    set(gca, 'FontSize', 60);
    ylabel('Vertical', 'FontSize', 80)
%     xlabel('time [sec]', 'FontSize', 80)
    text(0.50,-20,'time[ms]', 'FontSize', 80)
    figure(k)
end

% new drift borders analysis

% clear
% close all

binS=10;
% what sub data do I want?
shape='all'; % 'all' 'circle' 'parallelog' 'square' 'triangle' 'rectangle'
session='all'; % 'all' '1';
trial='all';% 'all' '1.mat';
coreectORwrong='c'; %'all' 'c' 'w';
cal=0;

%general parameters:
res=0.01;% 0.01 sec
screen_dis=1;% meter
PIXEL2METER=0.000264583;
doPlot=0; %for sacDiffAmos
analogs={'NB','B', 'NS','S'};

ratio_B_perAnalog={};
ratio_notB_perAnalog={};
for analog_i=1:4
    disp(analog_i)
    analog=analogs{1,analog_i};
    nameOfFile=[shape 'Shape' analog 'Analog' session 'Session' trial 'Trial' coreectORwrong 'Answer'];
    nameOfFile(regexp(nameOfFile,'[.]'))=[];
    if strcmp(analog,'B') || strcmp(analog,'NB')
        analogType='B';
    else if strcmp(analog,'S') || strcmp(analog,'NS')
            analogType='S';
        end
    end
    sub_i=0;
    for subjects= {'LB','LS' ,'AS' ,'RW','SM'} %,'LB','LS' ,'AS' ,'RW','SM'
        sub_i=sub_i+1;
        disp(sub_i)
        ratio_B_perSubAnalog=[];
        ratio_notB_perSubAnalog=[];
        t=0;
        labeled_saccade_vecs={};
        f=fullfile('C:\Users\bnapp\Documents\tunnelledVisionPaper\analyzing\cleanedData\', subjects);
        files = dir(f{1,1});
        for file = files'
            if strcmp(file.name,'.')==0 && strcmp(file.name,'..')==0
                currFile = load(file.name);
                % shape
                if  strcmp(shape,'all')==1 || strcmp(currFile.myimgfiles{1,1}{1,1},shape)
                    % correct\wrong only
                    if  strcmp(coreectORwrong,'all')==1 || ((strcmp(coreectORwrong,'c') && max(currFile.iscorrects{1,1})==1 ) || (strcmp(coreectORwrong,'w') && max(currFile.iscorrects{1,1})==0 ))
                        % analog type
                        if  strcmp(analog,'all')==1 || strcmp(file.name(4),analog(1))
                            if  length(analog)==2
                                if strcmp(analogType,'B')
                                    session=[1,3];
                                else if strcmp(analogType,'S')
                                        session=[2,4];
                                    end
                                end
                            end
                            % session number
                            if  strcmp(session,'all')==1 || strcmp(file.name(5),num2str(session(1))) || strcmp(file.name(5),num2str(session(2)))
                                % trial number
                                if  strcmp(trial,'all')==1 || strcmp(file.name(7:end),trial)
                                    
                                    %here come the main analysis:
                                    fileName=file.name(1:5);
                                    sessionNum=str2num(file.name(7:length(file.name)-4));
                                    picName=shape; %'circle' 'triangle' etc
                                    [imdatas,chan_h_pix,chan_v_pix,chan_h, chan_v,saccade_vec, ~] =sacDiffAmos(cal,fileName,sessionNum,picName,doPlot);
                                    
                                    if ~isempty(find(saccade_vec{1,1}))
                                        t=t+1;
                                        [row ,col]=find(saccade_vec{1,1});
                                        last=col(end);
                                        saccade_vec=saccade_vec{1,1}(:,1:last);
                                        XY_vec_pix=[chan_h_pix;chan_v_pix];
                                        XY_vec_deg=[chan_h;chan_v];
                                        imdata=imdatas{1};
                                        
                                        % 5. saccades - row 4(BIG)
                                        [labeled_saccade_vec,sacc_time_ms,sacc_amp_degrees,sacc_vel_deg2sec,sacc_maxvel_deg2sec]=typeOfSaccade(saccade_vec,XY_vec_pix,XY_vec_deg,imdata,res,analogType);                                        % 6. drifts -  row 5
                                        [labeled_saccade_vec,drift_time_ms,drift_dist_degrees,drift_amp_degrees,drift_vel_deg2sec]=drifts(labeled_saccade_vec,XY_vec_deg,XY_vec_pix,res,imdata,analogType);
                                        
                                        labeled_saccade_vecs{t}=labeled_saccade_vec;
                                        
                                        if  size(labeled_saccade_vec,2)>2 && size(labeled_saccade_vec,1)>=9
                                            ratio_B=[];
                                            ratio_notB=[];
                                            
                                            borders=find(labeled_saccade_vec(9,:)==1);
                                            borders=borders(borders<=size(drift_dist_degrees,2));
                                            ratio_B=(drift_amp_degrees(borders)-drift_dist_degrees(borders))./(drift_amp_degrees(borders)+drift_dist_degrees(borders));
                                            ratio_B=ratio_B(~isnan(ratio_B));
                                            
                                            not_borders=find(labeled_saccade_vec(9,:)==0);
                                            not_borders=not_borders(not_borders<=size(drift_dist_degrees,2));
                                            ratio_notB=(drift_amp_degrees(not_borders)-drift_dist_degrees(not_borders))./(drift_amp_degrees(not_borders)+drift_dist_degrees(not_borders));
                                            ratio_notB=ratio_notB(~isnan(ratio_notB));
                                            
                                            ratio_B_perSubAnalog=[ratio_B_perSubAnalog ratio_B];
                                            ratio_notB_perSubAnalog=[ratio_notB_perSubAnalog ratio_notB];
                                        end
                                    end
                                end
                            end
                        end
                    end
                    
                end
            end
        end
        if isempty(ratio_notB_perSubAnalog)
            ratio_notB_perAnalog{analog_i,sub_i}=[];
        else
            ratio_notB_perAnalog{analog_i,sub_i}=ratio_notB_perSubAnalog;
        end
        if isempty(ratio_B_perSubAnalog) 
            ratio_B_perAnalog{analog_i,sub_i}=[];
        else
            ratio_B_perAnalog{analog_i,sub_i}=ratio_B_perSubAnalog;
        end
    end
    
end
%%
all_ratio_B={};
all_ratio_notB={};
for analog_i=1:4
    all_ratio_B{analog_i}=[ratio_B_perAnalog{analog_i,1} ratio_B_perAnalog{analog_i,2} ratio_B_perAnalog{analog_i,3} ratio_B_perAnalog{analog_i,4} ratio_B_perAnalog{analog_i,5}];
    all_ratio_notB{analog_i}=[ratio_notB_perAnalog{analog_i,1} ratio_notB_perAnalog{analog_i,2} ratio_notB_perAnalog{analog_i,3} ratio_notB_perAnalog{analog_i,4} ratio_notB_perAnalog{analog_i,5}];
    MEAN_numberOfDrift_B(analog_i)=nanmean(all_ratio_B{analog_i});
    Var_numberOfDrift_B(analog_i)=nanvar(all_ratio_B{analog_i});
    MEAN_numberOfDrift_notB(analog_i)=nanmean(all_ratio_notB{analog_i});
    Var_numberOfDrift_notB(analog_i)=nanvar(all_ratio_notB{analog_i});
    
end
for sub_i=1:5
    for analog_i=1:4
        temp_numberOfDrift_B(analog_i,sub_i)=size(ratio_B_perAnalog{analog_i,sub_i},2);
        temp_numberOfDrift_notB(analog_i,sub_i)=size(ratio_notB_perAnalog{analog_i,sub_i},2);
    end
end
for sub_i=1:5
    for analog_i=1:4
        numberOfDrift_B(analog_i,sub_i)=temp_numberOfDrift_B(analog_i,sub_i)./(temp_numberOfDrift_B(analog_i,sub_i)+temp_numberOfDrift_notB(analog_i,sub_i));
        numberOfDrift_notB(analog_i,sub_i)=temp_numberOfDrift_notB(analog_i,sub_i)./(temp_numberOfDrift_B(analog_i,sub_i)+temp_numberOfDrift_notB(analog_i,sub_i));
    end
end


%%
c1=[0 .45 .7];%'c';
c2=[.8 .4 0];%'m';
c3=[.8 .6 .7];%'k';

%%

% figure(1)
%
% for sub_i=1:5
%     figure(99)
%     h1=histogram(ratio_notB_perAnalog{1,sub_i},0:bins:1,'Normalization','probability','FaceColor','k');
%     yy1=smooth(h1.BinCounts./sum(h1.BinCounts));
%     h2=histogram(ratio_B_perAnalog{1,sub_i},0:bins:1,'Normalization','probability','FaceColor','b');
%     yy2=smooth(h2.BinCounts./sum(h2.BinCounts));
%
%     figure(1)
%     subplot(4,6,sub_i)
%     plot(0:Hbins:1-Hbins,yy1,'k')
%     hold on
%     plot(0:Hbins:1-Hbins,yy2,'b')
%     title(analogs{1})
%
%
%     figure(99)
%     h1=histogram(ratio_notB_perAnalog{2,sub_i},0:bins:1,'Normalization','probability','FaceColor','k','FaceAlpha',0.5);
%     yy1=smooth(h1.BinCounts./sum(h1.BinCounts));
%     h2=histogram(ratio_B_perAnalog{2,sub_i},0:bins:1,'Normalization','probability','FaceColor','b','FaceAlpha',0.5);
%     yy2=smooth(h2.BinCounts./sum(h2.BinCounts));
%
%     figure(1)
%     subplot(4,6,sub_i+6)
%     plot(0:Hbins:1-Hbins,yy1,'k')
%     hold on
%     plot(0:Hbins:1-Hbins,yy2,'b')
%     title(analogs{2})
%
%     figure(99)
%     h1=histogram(ratio_notB_perAnalog{3,sub_i},0:bins:1,'Normalization','probability','FaceColor','k');
%     yy1=smooth(h1.BinCounts./sum(h1.BinCounts));
%     h2=histogram(ratio_B_perAnalog{3,sub_i},0:bins:1,'Normalization','probability','FaceColor','b');
%     yy2=smooth(h2.BinCounts./sum(h2.BinCounts));
%
%     figure(1)
%     subplot(4,6,sub_i+12)
%     plot(0:Hbins:1-Hbins,yy1,'k')
%     hold on
%     plot(0:Hbins:1-Hbins,yy2,'b')
%     title(analogs{3})
%
%     figure(99)
%     h1=histogram(ratio_notB_perAnalog{4,sub_i},0:bins:1,'Normalization','probability','FaceColor','k');
%     yy1=smooth(h1.BinCounts./sum(h1.BinCounts));
%     h2=histogram(ratio_B_perAnalog{4,sub_i},0:bins:1,'Normalization','probability','FaceColor','b');
%     yy2=smooth(h2.BinCounts./sum(h2.BinCounts));
%
%     figure(1)
%     subplot(4,6,sub_i+18)
%     plot(0:Hbins:1-Hbins,yy1,'k')
%     hold on
%     plot(0:Hbins:1-Hbins,yy2,'b')
%     title(analogs{4})
% end
analogs={'Natural Large','Tunneled Large', 'Natural Small','Tunneled Small'};
bins=0.1;
Hbins=bins;
smoothSize=3;
colors={'k', 'b','k','m'};
for analog_i=1:4
    %     subplot(4,6,analog_i*6)
    figure(99)
    h1=histogram(all_ratio_notB{1,analog_i},0:bins:1,'Normalization','probability','FaceColor','k','FaceAlpha',0.5);
    yy1=smooth(h1.BinCounts./sum(h1.BinCounts),smoothSize);
    [~,mods_notB(analog_i)]=max(yy1);
    h2=histogram(all_ratio_B{1,analog_i},0:bins:1,'Normalization','probability','FaceColor',[1 .4 0],'FaceAlpha',0.5);
    yy2=smooth(h2.BinCounts./sum(h2.BinCounts),smoothSize);
    [~,mods_B(analog_i)]=max(yy2);
    
    
    %     figure(10)
    %     subplot(2,2,analog_i)
    figure(3)
    if analog_i<3
        axes(ha3(analog_i+1));
    else
        axes(ha3(analog_i+2));
    end
    hold off
    index=Hbins/2:Hbins:1-Hbins/2;
    %     plot(index,cumsum(yy1),'color','k')
    %     hold on
    %     plot(index,cumsum(yy2),[1 .4 0])
    yy1fit=polyfit(Hbins/2:Hbins:1-Hbins/2,yy1',4);
    x1fit = linspace(Hbins/2,1-Hbins/2);
    y1fit = polyval(yy1fit,x1fit);
    
    plot(index,yy1','o','color',colors{analog_i},'MarkerSize',5)
    hold on
    plot(x1fit,y1fit,'color',colors{analog_i})
    
    yy2fit=polyfit(Hbins/2:Hbins:1-Hbins/2,yy2',4);
    x2fit = linspace(Hbins/2,1-Hbins/2);
    y2fit = polyval(yy2fit,x1fit);
    
    plot(index,yy2','o','color',[1 .4 0],'MarkerSize',5)
    hold on
    plot(x2fit,y2fit,'color',[1 .4 0])
    
%     xx1=Hbins/2:Hbins/1:1-Hbins/2;
%     yy1=spline(index,yy1,xx1);
%     yy2=spline(index,yy2,xx1);
    
%     plot(xx1,yy1,'color',[1 .4 0])
%     hold on
%     plot(xx1,yy2,'b')
%     
%     [~,p(analog_i)]=ttest2(all_ratio_notB{1,analog_i},all_ratio_B{1,analog_i});
%     p(analog_i)=ranksum([all_ratio_notB{1,analog_i} all_ratio_notB{1,analog_i} all_ratio_notB{1,analog_i}],all_ratio_B{1,analog_i});
    p(analog_i)=ranksum( [all_ratio_notB{1,analog_i}],all_ratio_B{1,analog_i});

    plot(nanmean(all_ratio_notB{1,analog_i})*[1 1],[0 0.2],['--' colors{analog_i}] )
    M=round(nanmean(all_ratio_notB{1,analog_i}),2);
    STE=round(nanstd(all_ratio_notB{1,analog_i})/sqrt(size(all_ratio_notB{1,analog_i},2))+0.001,2);
    STD=round(nanstd(all_ratio_notB{1,analog_i}),2);
%     text(nanmean(all_ratio_notB{1,analog_i}),0.15,[ num2str(M) '+-' num2str(STE) ' (' num2str(size(all_ratio_notB{1,analog_i},2)) ')' ' mode=' num2str(index(mods_notB(analog_i)))],'FontSize',20,'color',[1 .4 0] )
        text(0.1,0.16,[ num2str(M) '+-' num2str(STE) ' (' num2str(size(all_ratio_notB{1,analog_i},2)) ')' ],'FontSize',15,'color','k' )
%         text(0.1,0.16,[ num2str(M) '+-' num2str(STE) ],'FontSize',15,'color',colors{analog_i} )

    plot(nanmean(all_ratio_B{1,analog_i})*[1 1],[0 0.2],'--','color',[1 .4 0])
    M=round(nanmean(all_ratio_B{1,analog_i}),2);
    STE=round(nanstd(all_ratio_B{1,analog_i})/sqrt(size(all_ratio_B{1,analog_i},2)),2);
    STD=round(nanstd(all_ratio_B{1,analog_i}),2);
%     text(nanmean(all_ratio_B{1,analog_i}),0.19,[ num2str(M) '+-' num2str(STE) ' (' num2str(size(all_ratio_B{1,analog_i},2)) ')' ' mode=' num2str(index(mods_B(analog_i)))],'FontSize',20,'color','b')
        text(0.1,0.18,[ num2str(M) '+-' num2str(STE) ' (' num2str(size(all_ratio_B{1,analog_i},2)) ')' ],'FontSize',15,'color',[1 .4 0] )
%         text(0.1,0.18,[ num2str(M) '+-' num2str(STE)  ],'FontSize',15,'color',[1 .4 0] )
% if p(analog_i)>0.05
    text(0.7,0.2,['p= ' num2str(round(p(analog_i),3))],'FontSize',20)
% else
%     text(0.2,0.3,['p \langle 0.05'],'Interpreter','tex','FontSize',20)
% end
    
    if analog_i==1
        text(0.1,0.18,'Border','FontSize',25,'color',[1 .4 0])
%         title('Border Drift Curvature','Fontsize',25 )
    end
    axis([Hbins/2 1-Hbins/2 0 0.2])
%     axis([Hbins/2 1-Hbins/2 0 1])
    xlabel('Curvature Index','Fontsize',20)
    ylabel(analogs{analog_i},'Fontsize',20)
    %     legend( 'Borders','Not border')
        set(gca,'box','off')

end
close(99)
axes(ha3(2));
ylabel('')
text(0.06,0.18,'Natural Large','FontSize',20,'color','k')
text(0.06,0.16,'Border','FontSize',20,'color',[1 .4 0])
axes(ha3(3));
ylabel('')
text(0.06,0.18,'Tunneled Large','FontSize',20,'color','b')
text(0.06,0.16,'Border','FontSize',20,'color',[1 .4 0])
axes(ha3(5));
ylabel('')
text(0.06,0.18,'Natural Small','FontSize',20,'color','k')
text(0.06,0.16,'Border','FontSize',20,'color',[1 .4 0])
axes(ha3(6));
ylabel('')
text(0.06,0.18,'Tunneled Small','FontSize',20,'color','m')
text(0.06,0.16,'Border','FontSize',20,'color',[1 .4 0])
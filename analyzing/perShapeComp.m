% comparing different shapes:

clear
close all

i=0;
c_cell{1}=[ ];
g_cell{1}=[ ];
h_cell{1}=[ ];
e_cell{1}=[ ];
f_cell{1}=[ ];
f2_cell{1}=[ ];
l_cell{1}=[ ];
m_cell{1}=[ ];

for sub={'MS','RP' , 'NA' ,'SG'};
    if strcmp(sub,'RP')
        load(['C:\Users\lirongr\Documents\actvie-vision\naturalV\resultVectors\ALL\nvectorsForStat.mat'])
    else
        load(['C:\Users\lirongr\Documents\actvie-vision\naturalV\resultVectors\' sub{1,1} '\nvectorsForStat.mat'])
    end
    av_c=mean(cn);
    av_g=mean(gn);
    av_h=mean(hn);
    av_e=mean(en);
    av_f=mean(fn);
    av_f2=mean(fn2);
    av_m=mean(mn);
    av_l=mean(ln);
    for shape= { 'circle' ,'rectangle', 'triangle', 'square' ,'parallelog'}
        %     for shape= { 'findCircles', 'findRects' ,'findTriangles','findParallel','findSquares'}
        i=i+1;
        load(['C:\Users\lirongr\Documents\actvie-vision\analyzing\resultsVectors\' sub{1,1} '\' shape{1,1} 'ShapewithoutBlackB  AnalogallSessionallTrialcAnswer.mat'])
        load(['C:\Users\lirongr\Documents\actvie-vision\analyzing\resultsVectors\' sub{1,1} '\' shape{1,1} 'ShapewithoutBlackS  AnalogallSessionallTrialcAnswer.mat'])
        %    load(['C:\Users\lirongr\Documents\actvie-vision\naturalV\resultVectors\' sub{1,1} '\' shape{1,1} 'ShapeallCountingSessionnoneContrastSession.mat'])
        t=length(num_of_sacc);
        %         analog='B  ';
        analog='S  ';
        vecsForStatForsubData(analog,t,time_of_trial_in_sec,num_of_sacc_per_sec,whiteTimes,saccs_amp_degrees,drifts_amp_degrees,saccs_vel_deg2sec,saccs_maxvel_deg2sec,drifts_vel_deg2sec,saccs_time_ms,drifts_time_ms);
        %         vecsForStatForNaturalV(t,num_of_sacc_per_sec,saccs_amp_degrees,drifts_amp_degrees,saccs_vel_deg2sec,saccs_maxvel_deg2sec,drifts_vel_deg2sec,saccs_time_ms,drifts_time_ms);
        load('C:\Users\lirongr\Documents\actvie-vision\naturalV\resultVectors\SMALLvectorsForStat.mat')
        %                 load('C:\Users\lirongr\Documents\actvie-vision\naturalV\resultVectors\vectorsForStat.mat')
        %           load('C:\Users\lirongr\Documents\actvie-vision\naturalV\resultVectors\nvectorsForStat.mat')
        c_cell{i}=[ c_cell{1} c./av_c];
        g_cell{i}=[ g_cell{1} g./av_g];
        h_cell{i}=[ h_cell{1} h./av_h];
        e_cell{i}=[ e_cell{1} e./av_e];
        f_cell{i}=[ f_cell{1} f./av_f];
        f2_cell{i}=[ f2_cell{1} f2./av_f2];
        l_cell{i}=[ l_cell{1} l./av_l];
        m_cell{i}=[ m_cell{1} m./av_m];
        
        
        %         c_cell{i}=[ c_cell{1} cn./av_c];
        %         g_cell{i}=[ g_cell{1} gn./av_g];
        %     h_cell{i}=[ h_cell{1} hn./av_h];
        %     e_cell{i}=[ e_cell{1} en./av_e];
        %     f_cell{i}=[ f_cell{1} fn./av_f];
        %     f2_cell{i}=[ f2_cell{1} fn2./av_f2];
        %     l_cell{i}=[ l_cell{1} ln./av_l];
        %     m_cell{i}=[ m_cell{1} mn./av_m];
    end
end

%% drifts
figure(1)

for i=1:5
    subplot(5,2,i*2-1)
    hold on
    axis([ -5 5 0 0.1]);
    [N,X] = hist(log(g_cell{i}),40);
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
    title('Amplitude of Drift in Degrees', 'FontSize', 25)
    
end

for i=1:5
    subplot(5,2,i*2)
    hold on
    axis([ -4 4 0 0.1]);
    [N,X] = hist(log(h_cell{i}),40);
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
end


%% Saccsdes:
figure(2)

for i=1:5
    subplot(5,3,i*3-2)
    hold on
    axis([ -4 4 0 0.1]);
    [N,X] = hist(log(e_cell{i}),40);
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
    title('Amplitude of Saccades in Degrees', 'FontSize', 25)
end

for i=1:5
    subplot(5,3,i*3-1)
    hold on
    axis([ -4 4 0 0.1]);
    [N,X] = hist(log(f_cell{i}),40);
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
    title('Av Velocity of Saccades in DegperSec', 'FontSize', 25)
end

for i=1:5
    subplot(5,3,i*3)
    hold on
    axis([ -3 3 0 0.2]);
    [N,X] = hist(log(c_cell{i}),18);
    N=N/sum(N);
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
end



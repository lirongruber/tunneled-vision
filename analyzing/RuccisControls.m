% CORRELATIONS AND VELOCITIES FOR RUCCIS CONTROLS

subjects={'SM','LS','LB','RW','AS'};
windowAvSize_forMean=2;%1
windowAvSize_forStd=5;%3

figure(8)
ha8=tight_subplot(2, 4,[.1 .04],[.1 .1],[.1 .1]);
set(gcf,'units','normalized','outerposition',[0 0 1 1])
figure(9)
ha9=tight_subplot(3, 4,[.1 .04],[.1 .1],[.1 .1]);
set(gcf,'units','normalized','outerposition',[0 0 1 1])

for type=1:4
    allSub_MeanVel=nan(1,300);%[];
    allSub_MeanFilterVel=nan(1,300);
    allSub_MeanVar=nan(1,300);%[];
    allSub_MeanCur=nan(1,300);
    allSub_MeanPupil=nan(1,300);
    allSub_SaccAmp=nan;
    allSub_SaccMaxVel=nan;
    allSub_durDrift=nan;
    allSub_durDrift_woLast=nan;
    allSub_pre_durDrift_woLast=nan;
    allSub_MeanVel_woLast=nan(1,300);
    
    
    if type==1
        color='k';
    else
        if type==2
            color='b';
        else
            if type==3
                color='k';
            else
                if type==4
                    color='m';
                end
            end
        end
    end
    
    for sub_i=1:length(subjects)
        ISI_Amp=[];
        ISI_Speed=[];
        MeanVel=[];
        MeanVelFilter=[];
        MeanVar=[];
        durDrift=[];
        MeanCurvature=[];
        MeanPupil=[];
        SaccAmp=[];
        SaccMaxVel=[];
        sub=subjects(sub_i);
        sub=sub{1,1};
        if type==1
            load(['C:\Users\bnapp\Documents\tunnelledVisionPaper\analyzing\resultsVectors_forRucci\' sub '\allShapeNBAnalogallSessionallTrialcAnswer.mat']);
        else
            if type==2
                load(['C:\Users\bnapp\Documents\tunnelledVisionPaper\analyzing\resultsVectors_forRucci\' sub '\allShapeBAnalogallSessionallTrialcAnswer.mat']);
            else
                if type==3
                    load(['C:\Users\bnapp\Documents\tunnelledVisionPaper\analyzing\resultsVectors_forRucci\' sub '\allShapeNSAnalogallSessionallTrialcAnswer.mat']);
                else
                    if type==4
                        load(['C:\Users\bnapp\Documents\tunnelledVisionPaper\analyzing\resultsVectors_forRucci\' sub '\allShapeSAnalogallSessionallTrialcAnswer.mat']);
                    end
                end
            end
        end
        relD=0;
        relT=0;
        
        for t=1:length(labeled_saccade_vecs)
            labeled_saccade_vec=labeled_saccade_vecs{1,t};
            XY_vec_deg=XY_vecs_deg{1,t};
            pd_vec_zscored=pd_vecs_zscored{1,t};
            
            for i =1:size(labeled_saccade_vec,2)-1
                temp=(XY_vec_deg(:,((labeled_saccade_vec(1,i)+labeled_saccade_vec(2,i)):labeled_saccade_vec(1,i+1)))');
                tempP=(pd_vec_zscored(:,((labeled_saccade_vec(1,i)+labeled_saccade_vec(2,i)):labeled_saccade_vec(1,i+1)))');
                tempS=(XY_vec_deg(:,(labeled_saccade_vec(1,i):(labeled_saccade_vec(1,i)+labeled_saccade_vec(2,i))))');
                if length(temp)>10 && size(labeled_saccade_vec,2)>2
                    tempX_filtered = sgolayfilt(temp(:,1),1,3);
                    tempY_filtered = sgolayfilt(temp(:,2),1,3);
                    temp_filtered=[tempX_filtered , tempY_filtered];
%                     figure(11)
%                     plot(temp(:,1),temp(:,2))
%                     hold on
%                     plot(temp_filtered(:,1),temp_filtered(:,2))
%                     hold off
                    currAmp=[];
                    currAmpFilter=[];
                    local_curvature=[];
                    currP=tempP;
                    currSA=EULength(tempS);
                    currSV=0;
                    for si=2:size(tempS,1)
                        d=EULength(tempS(si-1:si,:));
                        currSV=max(currSV,d);
                    end
                    currSV=currSV/0.01;
                    for j=2:length(temp)
                        currAmp(j-1) = sqrt((temp(j,1)-temp(j-1,1))^2+(temp(j,2)-temp(j-1,2))^2);
                        currAmpFilter(j-1) = sqrt((temp_filtered(j,1)-temp_filtered(j-1,1))^2+(temp_filtered(j,2)-temp_filtered(j-1,2))^2);
                        curveWindow=5;
                        parmForCurve=(curveWindow-1)/2;
                        if j>parmForCurve && j<length(temp)-parmForCurve
                            temp_c=temp(j-parmForCurve:j+parmForCurve,:);
                            while length(unique(temp_c(:,1)))~=length(temp_c(:,1))
                                [C,ia,ic] = unique(temp_c);
                                replaceInd=find(sort(ia)'-(1:length(ia)),1);
                                temp_c(replaceInd,1)=temp_c(replaceInd,1)+0.001;
                            end
                            pp=spline(temp_c(:,1)',temp_c(:,2)');
                            pieces=pp.pieces;
                            order=pp.order;
                            curvature=[];
                            for p=1:pieces
                                curvature(p)=abs((2*pp.coefs(p,order-2))/((1+pp.coefs(p,order-1)^2)^1.5));
                            end
                            local_curvature(j)=max(curvature);
                        else if j>length(temp)-parmForCurve
                                local_curvature(1:parmForCurve)=local_curvature(parmForCurve+1);
                                local_curvature(length(temp)-parmForCurve:length(temp)-1)=local_curvature(length(temp)-parmForCurve-1);
                            end
                        end
                    end
                    if isempty(find(currAmp==0)) && sum(currAmp)<10
                        relD=relD+1;
                        %for any given drift
                        M=movmean(currAmp.*100,windowAvSize_forMean);
                        MF=movmean(currAmpFilter.*100,windowAvSize_forMean);
                        V=movvar(currAmp.*100,windowAvSize_forStd);
                        C=local_curvature;
                        P=movmean(currP,1);
                        SA=currSA;
                        SV=currSV;
%                         M=M(1:10);
%                         V=V(1:10);
                        
                        MeanVel(relD,1:length(M))=M;%(1:10);
                        MeanVelFilter(relD,1:length(M))=MF;
                        durDrift(relD)=length(M);
                        MeanVar(relD,1:length(M))=V;%(1:10);
                        MeanCurvature(relD,1:length(M))=C;
                        MeanPupil(relD,1:length(M))=P(1:end-1);
                        SaccAmp(relD)=SA;
                        SaccMaxVel(relD)=SV;
                    end
                    
                end
            end
        end
        MeanVel(MeanVel==0)=nan;
        MeanVel=[MeanVel nan(size(MeanVel,1), 300-size(MeanVel,2))];
        MeanVelFilter(MeanVelFilter==0)=nan;
        MeanVelFilter=[MeanVelFilter nan(size(MeanVelFilter,1), 300-size(MeanVelFilter,2))];
        durDrift(durDrift==0)=nan;
        MeanVar(MeanVar==0)=nan;
        MeanVar=[MeanVar nan(size(MeanVar,1), 300-size(MeanVar,2))];
        MeanCurvature(MeanCurvature==0)=nan;
        MeanCurvature=[MeanCurvature nan(size(MeanCurvature,1), 300-size(MeanCurvature,2))];
        MeanPupil(MeanPupil==0)=nan;
        MeanPupil=[MeanPupil nan(size(MeanPupil,1), 300-size(MeanPupil,2))];
        
        allSub_MeanVel=[allSub_MeanVel; MeanVel(:,1:min(length(MeanVel),300))];
        allSub_MeanFilterVel=[allSub_MeanFilterVel; MeanVelFilter(:,1:min(length(MeanVelFilter),300)) ];
        allSub_MeanVar=[allSub_MeanVar ; MeanVar(:,1:min(length(MeanVar),300))];
        allSub_MeanCur=[allSub_MeanCur ; MeanCurvature(:,1:min(length(MeanCurvature),300))];
        allSub_MeanPupil=[allSub_MeanPupil ; MeanPupil(:,1:min(length(MeanPupil),300))];
        allSub_SaccAmp=[allSub_SaccAmp ; SaccAmp'];
        allSub_SaccMaxVel=[allSub_SaccMaxVel ; SaccMaxVel'];
        allSub_durDrift=[allSub_durDrift ; durDrift'];
        allSub_pre_durDrift_woLast=[allSub_pre_durDrift_woLast ; durDrift(1:end-1)'];
        allSub_durDrift_woLast=[allSub_durDrift_woLast ; durDrift(2:end)'];
        allSub_MeanVel_woLast=[allSub_MeanVel_woLast ; MeanVel(2:end,1:min(length(MeanVel),300)) ];
        
        % saccAmp - MeanPauseSpeed
        axes(ha8(floor(2)));
        p1=plot(SaccAmp,nanmean(MeanVel,2),'.','color',color);
        p1.Color(4) = 0.2;
        hold on
        axis([0 15 0 15])
        xlabel('Pre-Saccade Amplitude [deg]','FontSize', 20)
        ylabel('Pause Speed [deg/sec]','FontSize', 20)
        set(gca,'box','off')
        
        % saccMaxVel - MeanPauseSpeed
        axes(ha8(floor(3)));
        p1=plot(SaccMaxVel,nanmean(MeanVel,2),'.','color',color);
        p1.Color(4) = 0.2;
        hold on
        axis([0 300 0 15])
        xlabel('Pre-Saccade MaxVel [deg/sec]','FontSize', 20)
%         if floor((type+1)/2)==1
%             ylabel('Pause Speed [deg/sec]','FontSize', 20)
%         end
        set(gca,'box','off')
        
        % MeanPupilSize - MeanPauseSpeed
        axes(ha8(floor(4)));
        p1=plot(nanmean(MeanPupil,2),nanmean(MeanVel,2),'.','color',color);
        p1.Color(4) = 0.2;
        hold on
        axis([-3 3 0 15])
        xlabel('Mean Pupil Size [AU]','FontSize', 20)
%         if floor((type+1)/2)==1
%             ylabel('Pause Speed [deg/sec]','FontSize', 20)
%         end
        set(gca,'box','off')
        
        % Pre-ISI VS speed drift
        axes(ha8(floor(6)));
        temp=nanmean(MeanVel,2);
        p1=plot(temp(2:end),durDrift(1:end-1).*10,'.','color',color);
        p1.Color(4) = 0.2;
        hold on
        axis([0 15 0 2000])
        ylabel('pre-ISI [ms]','FontSize', 20)
        xlabel('Pause Speed [deg/sec]','FontSize', 20)
        set(gca,'box','off')
        
        % Pre-ISI VS amp drift
        axes(ha8(floor(7)));
        temp=nanmean(MeanVel,2);
        p1=plot(temp(2:end)'.*durDrift(2:end)./100,durDrift(1:end-1).*10,'.','color',color);
        p1.Color(4) = 0.2;
        hold on
        axis([0 12 0 2000])
%         ylabel('pre-ISI [ms]','FontSize', 20)
        xlabel('Pause Amplitude [deg]','FontSize', 20)
        set(gca,'box','off')
        
        %pupil
        axes(ha9(floor(type)));
        p1=plot(10:10:10*size(MeanPupil,2),nanmean(MeanPupil),'color',color);
        p1.Color(4) = 0.2;
        hold on
        axis([0 110 -1 1])
        set(gca,'xtick',[])
        xlabel('Time [ms]','FontSize', 20)
        if type==1
            ylabel('Pupil Size [AU]','FontSize', 20)
        else
            set(gca,'ytick',[])
        end
        set(gca,'box','off')
        
        % speed
        axes(ha9(floor(type+4)));
        p1=plot(10:10:10*size(MeanVel,2),nanmean(MeanVel),'color',color);
        p1.Color(4) = 0.3;
        hold on
        axis([0 110 0 11])
        set(gca,'xtick',[])
        title('')
        xlabel('Time [ms]','FontSize', 20)
        if type==1
            ylabel('Speed [deg/sec]','FontSize', 20)
        else
            set(gca,'ytick',[])
        end
        set(gca,'box','off')
        
        %speed filtered
        axes(ha9(floor(type+8)));
        p1=plot(10:10:10*size(MeanVelFilter,2),nanmean(MeanVelFilter),'color',color);
        p1.Color(4) = 0.3;
        hold on
        axis([0 110 0 11])
        title('')
        xlabel('Time [ms]','FontSize', 20)
        if type==1
            ylabel('(SG-filtered) Speed [deg/sec]','FontSize', 20)
        else
            set(gca,'ytick',[])
        end
        set(gca,'box','off')
    end
        
    % pupil Size
    axes(ha9(floor(type)));
    errorbar(10:10:10*size(allSub_MeanPupil,2),nanmean(allSub_MeanPupil),nanstd(allSub_MeanPupil)./sqrt(size(allSub_MeanPupil,1)-sum(isnan(allSub_MeanPupil))),'color',color,'LineWidth',3)
    
    %mean Speed
    axes(ha9(floor(type+4)));
    errorbar(10:10:10*size(allSub_MeanVel,2),nanmean(allSub_MeanVel),nanstd(allSub_MeanVel)./sqrt(size(allSub_MeanVel,1)-sum(isnan(allSub_MeanVel))),'color',color,'LineWidth',3)
    
    %mean Speed filtered
    axes(ha9(floor(type+8)));
    errorbar(10:10:10*size(allSub_MeanFilterVel,2),nanmean(allSub_MeanFilterVel),nanstd(allSub_MeanFilterVel)./sqrt(size(allSub_MeanFilterVel,1)-sum(isnan(allSub_MeanFilterVel))),'color',color,'LineWidth',3)
  
    % correlation
    temp=nanmean(allSub_MeanVel,2);
    temp1=nanmean(allSub_MeanFilterVel,2);
    Speed_forCorr{type}=temp(2:end);
    SaccAmp_forCorr{type}=allSub_SaccAmp(2:end);
    temp2=nanmean(allSub_MeanVel_woLast,2);
    
    Speed2_forCorr{type}=temp2(2:end);
    Amp_forCorr{type}=temp2(2:end).*allSub_durDrift_woLast(2:end);
    ISI_forCorr{type}=allSub_pre_durDrift_woLast(2:end);
    
    Ampcurrent_forCorr{type}=temp(2:end).*allSub_durDrift(2:end);
    ISIcurrent_for_CORR{type}=allSub_durDrift(2:end);
    
%     [SaccAmp_PauseSpeed,pval]=corr(allSub_SaccAmp(2:end),temp(2:end));
%     axes(ha8(floor(1)));
%     text(5,type+11,['r=' num2str(round(SaccAmp_PauseSpeed,2)) '  p=' num2str(round(pval,4))],'FontSize',15);
    SaccMaxVel_forCorr{type}=allSub_SaccMaxVel(2:end);
%     [SaccMxVel_PauseSpeed,pval]=corr(allSub_SaccMaxVel(2:end),temp(2:end));
%     axes(ha8(floor(2)));
%     text(200,type+11,['r=' num2str(round(SaccMxVel_PauseSpeed,2)) '  p=' num2str(round(pval,4))],'FontSize',15);
    m_allSub_MeanPupil=nanmean(allSub_MeanPupil,2);
    PupilSize_forCorr{type}=m_allSub_MeanPupil(2:end);
%     [SaccMeanPupil_PauseSpeed,pval]=corr(m_allSub_MeanPupil(2:end),temp(2:end));
%     axes(ha8(floor(3)));
%     text(3,type+11,['r=' num2str(round(SaccMeanPupil_PauseSpeed,2)) '  p=' num2str(round(pval,4))],'FontSize',15);
    
    axes(ha8(floor(1)));
    errorbar(type,nanmean(allSub_SaccAmp),2*ste(allSub_SaccAmp(2:end)),'color',color,'LineWidth',2)
    hold on
    plot(type,nanmean(allSub_SaccAmp),'.','color',color,'MarkerSize',25)
    axis([0 5 0 8])
    ylabel('Saccades Amplitude [deg]','FontSize', 20)
    set(gca,'xtick',[])
    methods={ 'Nat L','Tun L','Nat S', 'Tun S'};
    set(gca, 'XTick', 1:4, 'XTickLabel', methods,'Fontsize',20);
    set(gca,'XTickLabelRotation',45);
    set(gca,'box','off')
    
    temp=nanmean(allSub_MeanVel(:,1:11),2);
    temp1=nanmean(allSub_MeanFilterVel(:,1:11),2);
    temp2=nanmean(allSub_MeanPupil(:,1:11),2);
    [PupilSize_PauseSpeed,pval]=corr(temp(2:end),temp2(2:end));
    axes(ha9(floor(type+4)));
%     text(30,0.8,['r=' num2str(PupilSize_PauseSpeed) '  p=' num2str(pval)],'FontSize',15);
    [PupilSize_PauseSpeedFiltered,pval]=corr(temp1(2:end),temp2(2:end));
    axes(ha9(floor(type+8)));
%     text(30,0.8,['r=' num2str(PupilSize_PauseSpeedFiltered) '  p=' num2str(pval)],'FontSize',15);
PupilConcat=[];
VelConcat=[];
for i=1:10
temp_PupilConcat= allSub_MeanPupil(i,:);
PupilConcat=[PupilConcat temp_PupilConcat];
temp_VelConcat= allSub_MeanVel(i,:);
VelConcat=[VelConcat temp_VelConcat];
end
PupilConcat=PupilConcat(~isnan(PupilConcat));
VelConcat=VelConcat(~isnan(VelConcat));
[r,p]=corr(PupilConcat',VelConcat');

   
% % %     l=(length(lags)-1)/2;
% %     l=1;
% %     figure(21)
% %     hold on
% % %     plot(0:10:length(lags)*10/2+10,xcf(l:end),'color',color)
% %     plot(lags.*10,xcf,'color',color)
% %     plot([-200,200],[bounds(1),bounds(1)],[color '--'])
% %     plot([-200,200],[bounds(2),bounds(2)],[color '--'])
% %     xlabel('Time Lag [ms]','FontSize', 20)
% %     ylabel('CrossCor','FontSize', 20)
end

 
conc_Speed_forCorr=[Speed_forCorr{1,1}'  Speed_forCorr{1,2}' Speed_forCorr{1,3}' Speed_forCorr{1,4}'];
conc_SaccAmp_forCorr=[SaccAmp_forCorr{1,1}'  SaccAmp_forCorr{1,2}' SaccAmp_forCorr{1,3}' SaccAmp_forCorr{1,4}'];
conc_SaccMaxVel_forCorr=[SaccMaxVel_forCorr{1,1}'  SaccMaxVel_forCorr{1,2}' SaccMaxVel_forCorr{1,3}' SaccMaxVel_forCorr{1,4}'];
conc_PupilSize_forCorr=[PupilSize_forCorr{1,1}'  PupilSize_forCorr{1,2}' PupilSize_forCorr{1,3}' PupilSize_forCorr{1,4}'];

conc_Speed2_forCorr=[Speed2_forCorr{1,1}'  Speed2_forCorr{1,2}' Speed2_forCorr{1,3}' Speed2_forCorr{1,4}'];
conc_Amp_forCorr=[Amp_forCorr{1,1}' Amp_forCorr{1,2}' Amp_forCorr{1,3}' Amp_forCorr{1,4}' ];
conc_ISI_forCorr=[ISI_forCorr{1,1}' ISI_forCorr{1,2}' ISI_forCorr{1,3}' ISI_forCorr{1,4}'];
conc_ISIcurrent_forCORR=[ISIcurrent_for_CORR{1,1}' ISIcurrent_for_CORR{1,2}' ISIcurrent_for_CORR{1,3}' ISIcurrent_for_CORR{1,4}'];
conc_Ampcurrent_forCorr=[Ampcurrent_forCorr{1,1}' Ampcurrent_forCorr{1,2}' Ampcurrent_forCorr{1,3}' Ampcurrent_forCorr{1,4}'];
   
[SaccAmp_PauseSpeed,pval]=corr(conc_SaccAmp_forCorr',conc_Speed_forCorr');
    axes(ha8(floor(2)));
    text(10,type+11,['r^2=' num2str(round(SaccAmp_PauseSpeed^2,3)) ],'FontSize',20);
    
    [SaccMxVel_PauseSpeed,pval]=corr(conc_SaccMaxVel_forCorr',conc_Speed_forCorr');
    axes(ha8(floor(3)));
    text(200,type+11,['r^2=' num2str(round(SaccMxVel_PauseSpeed^2,3)) ],'FontSize',20);
    
    [SaccMeanPupil_PauseSpeed,pval]=corr(conc_PupilSize_forCorr',conc_Speed_forCorr');
    axes(ha8(floor(4)));
    text(1.5,type+11,['r^2=' num2str(round(SaccMeanPupil_PauseSpeed^2,3))],'FontSize',20);
    
    [PreISI_PauseSpeed,pval]=corr(conc_ISI_forCorr',conc_Speed2_forCorr');
    axes(ha8(floor(6)));
    text(10,2000,['r^2=' num2str(round(PreISI_PauseSpeed^2,3))],'FontSize',20);
    
    [PreISI_PauseAmp,pval]=corr(conc_ISI_forCorr',conc_Amp_forCorr');
    axes(ha8(floor(7)));
    text(8,2000,['r^2=' num2str(round(PreISI_PauseAmp^2,3))],'FontSize',20);
    %
    % not plotted 
    %
    [ISI_PauseSpeed,pval]=corr(conc_ISIcurrent_forCORR',conc_Speed_forCorr');
    axes(ha8(floor(6)));
    text(10,2000,['r^2=' num2str(round(ISI_PauseSpeed^2,3))],'FontSize',20);
    
    [ISI_PauseAmp,pval]=corr(conc_ISIcurrent_forCORR',conc_Ampcurrent_forCorr');
    axes(ha8(floor(7)));
    text(8,2000,['r^2= ' num2str(round(ISI_PauseAmp^2,3))],'FontSize',20);
    
    
    
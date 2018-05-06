% convergence of velocity and var of velocity

% NOT SEPERATING HORIZONTAL AND VERTICAL
subjects={'SM','LS','LB','RW','AS'};
windowAvSize_forMean=2;%1
windowAvSize_forStd=5;%3

figure(20)
ha20=tight_subplot(2, 4,[.1 .04],[.1 .1],[.1 .1]);
set(gcf,'units','normalized','outerposition',[0 0 1 1])

for type=1:4
    allSub_MeanVel=nan(1,300);%[];
    allSub_durDrift=[];
    allSub_MeanVar=nan(1,300);%[];
    allSub_MeanCur=nan(1,300);
    
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
        MeanVel=[];
        MeanVar=[];
        durDrift=[];
        MeanCurvature=[];
        sub=subjects(sub_i);
        sub=sub{1,1};
        if type==1
            load(['C:\Users\bnapp\Documents\tunnelledVisionPaper\analyzing\resultsVectors_forXY\' sub '\allShapeNBAnalogallSessionallTrialcAnswer.mat']);
        else
            if type==2
                load(['C:\Users\bnapp\Documents\tunnelledVisionPaper\analyzing\resultsVectors_forXY\' sub '\allShapeBAnalogallSessionallTrialcAnswer.mat']);
            else
                if type==3
                    load(['C:\Users\bnapp\Documents\tunnelledVisionPaper\analyzing\resultsVectors_forXY\' sub '\allShapeNSAnalogallSessionallTrialcAnswer.mat']);
                else
                    if type==4
                        load(['C:\Users\bnapp\Documents\tunnelledVisionPaper\analyzing\resultsVectors_forXY\' sub '\allShapeSAnalogallSessionallTrialcAnswer.mat']);
                    end
                end
            end
        end
        relD=0;
        relT=0;
        
        for t=1:length(labeled_saccade_vecs)
            labeled_saccade_vec=labeled_saccade_vecs{1,t};
            XY_vec_deg=XY_vecs_deg{1,t};
            
            for i =1:size(labeled_saccade_vec,2)-1
                temp=(XY_vec_deg(:,((labeled_saccade_vec(1,i)+labeled_saccade_vec(2,i)):labeled_saccade_vec(1,i+1)))');
                if length(temp)>10 && size(labeled_saccade_vec,2)>2
                    currAmp=[];
                    local_curvature=[];
                    for j=2:length(temp)
                        currAmp(j-1) = sqrt((temp(j,1)-temp(j-1,1))^2+(temp(j,2)-temp(j-1,2))^2);
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
                        V=movvar(currAmp.*100,windowAvSize_forStd);
                        C=local_curvature;
%                         M=M(1:10);
%                         V=V(1:10);
                        
                        MeanVel(relD,1:length(M))=M;%(1:10);
                        durDrift(relD)=length(M);
                        MeanVar(relD,1:length(M))=V;%(1:10);
                        MeanCurvature(relD,1:length(M))=C;
                    end
                    
                end
            end
        end
        MeanVel(MeanVel==0)=nan;
        MeanVel=[MeanVel nan(size(MeanVel,1), 300-size(MeanVel,2))];
        durDrift(durDrift==0)=nan;
        MeanVar(MeanVar==0)=nan;
        MeanVar=[MeanVar nan(size(MeanVar,1), 300-size(MeanVar,2))];
        MeanCurvature(MeanCurvature==0)=nan;
        MeanCurvature=[MeanCurvature nan(size(MeanCurvature,1), 300-size(MeanCurvature,2))];
        
        allSub_MeanVel=[allSub_MeanVel; MeanVel(:,1:min(length(MeanVel),300))];
        allSub_MeanVar=[allSub_MeanVar ; MeanVar(:,1:min(length(MeanVar),300))];
        allSub_MeanCur=[allSub_MeanCur ; MeanCurvature(:,1:min(length(MeanCurvature),300))];
        
        
        axes(ha20(floor((type+1)/2)));
        
        %         subplot(2,6,sub_i)
%         errorbar(10:10:10*size(MeanVel,2),nanmean(MeanVel),nanstd(MeanVel)./sqrt(size(MeanVel,1)-sum(isnan(MeanVel))),'color',color)
        p1=plot(10:10:10*size(MeanVel,2),nanmean(MeanVel),'color',color);
        p1.Color(4) = 0.2;
        hold on
        axis([0 110 0 11])
        title(sub,'FontSize', 25)
        xlabel('Time [ms]','FontSize', 20)
        if floor((type+1)/2)==1
            ylabel('Speed [deg/sec]','FontSize', 20)
        end
        set(gca,'box','off')
        
        axes(ha20(floor((type+1)/2)+4));
        p1=plot(10:10:10*size(MeanCurvature,2),nanmean(MeanCurvature),'color',color);
        p1.Color(4) = 0.2;
        hold on
        axis([0 110 0 1000])
        xlabel('Time [ms]','FontSize', 20)
        if floor((type+1)/2)==1
            ylabel('Curvature [kappa]','FontSize', 20)
        end
        set(gca,'box','off')
        
        
        axes(ha20(floor((type+1)/2)+2));
%         errorbar(10:10:10*size(MeanVel,2),nanmean(MeanVel),nanstd(MeanVel)./sqrt(size(MeanVel,1)-sum(isnan(MeanVel))),'color',color)
        p1=plot(10:10:10*size(MeanVel,2),nanmean(MeanVel),'color',color);
        p1.Color(4) = 0.3;
        hold on
        axis([0 400 0 11])
        title('')
        xlabel('Time [ms]','FontSize', 20)
        if floor((type+1)/2+2)==1
            ylabel('Speed [deg/sec]','FontSize', 20)
        end
        set(gca,'box','off')
        
        axes(ha20(floor((type+1)/2)+2+4));
        p1=plot(10:10:10*size(MeanCurvature,2),nanmean(MeanCurvature),'color',color);
        p1.Color(4) = 0.2;
        hold on
        axis([0 400 0 1000])
        xlabel('Time [ms]','FontSize', 20)
        if floor((type+1)/2)==1
            ylabel('Curvature [kappa]','FontSize', 20)
        end
        set(gca,'box','off')
        
    end
    
    axes(ha20(floor((type+1)/2)));
    %     subplot(2,6,6)
    errorbar(10:10:10*size(allSub_MeanVel,2),nanmean(allSub_MeanVel),nanstd(allSub_MeanVel)./sqrt(size(allSub_MeanVel,1)-sum(isnan(allSub_MeanVel))),'color',color,'LineWidth',3)
    hold on
    axis([0 110 0 11])
    if type==2
    title('','FontSize', 25)
    else
    title('')    
    end
    xlabel('Time [ms]','FontSize', 20)
    if floor((type+1)/2)==1
        ylabel('Speed [deg/sec]','FontSize', 20)
    end
    set(gca,'box','off')
    
    axes(ha20(floor((type+1)/2)+4));
    errorbar(10:10:10*size(allSub_MeanCur,2),nanmean(allSub_MeanCur),nanstd(allSub_MeanCur)./sqrt(size(allSub_MeanCur,1)-sum(isnan(allSub_MeanCur))),'color',color,'LineWidth',3)
    hold on
    if type==2
    title('','FontSize', 25)
    else
    title('')    
    end
   
    axes(ha20(floor((type+1)/2)+2));
%     %  subplot(2,6,12)
        errorbar(10:10:10*size(allSub_MeanVel,2),nanmean(allSub_MeanVel),nanstd(allSub_MeanVel)./sqrt(size(allSub_MeanVel,1)-sum(isnan(allSub_MeanVel))),'color',color,'LineWidth',3)
    hold on
        axis([0 400 0 11])
    title('')
    xlabel('Time [ms]','FontSize', 20)
    if floor((type+1)/2+2)==1
        ylabel('Speed [deg/sec]','FontSize', 20)
    end
    set(gca,'box','off')
    
    axes(ha20(floor((type+1)/2)+2+4));
    errorbar(10:10:10*size(allSub_MeanCur,2),nanmean(allSub_MeanCur),nanstd(allSub_MeanCur)./sqrt(size(allSub_MeanCur,1)-sum(isnan(allSub_MeanCur))),'color',color,'LineWidth',3)
    hold on
    if type==2
    title('','FontSize', 25)
    else
    title('')    
    end
    
    % correlation
    MC=nanmean(allSub_MeanCur);
    MC=MC(~isnan(MC));
    MV=nanmean(allSub_MeanVel);
    MV=MV(~isnan(MV));
    
    [xcf,lags,bounds]=crosscorr(MC,MV);
%     l=(length(lags)-1)/2;
    l=1;
    figure(21)
    hold on
%     plot(0:10:length(lags)*10/2+10,xcf(l:end),'color',color)
    plot(lags.*10,xcf,'color',color)
    plot([-200,200],[bounds(1),bounds(1)],[color '--'])
    plot([-200,200],[bounds(2),bounds(2)],[color '--'])
    xlabel('Time Lag [ms]','FontSize', 20)
    ylabel('CrossCor','FontSize', 20)
end
% leg=legend('Natural Large','Tunneled Large','Natural Small','Tunneled Small');
% set(leg,'FontSize', 15,'Position',[0.8890    0.8263    0.0556    0.0551]);
% legend boxoff
% axes(ha5(1));
% legend('Natural Large','Tunneled Large')
%  legend boxoff
%  axes(ha5(2));
% legend('Natural Small','Tunneled Small')
%  legend boxoff
%  
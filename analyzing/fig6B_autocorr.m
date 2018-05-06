
% Checking differences between border and not border 
clear
corrLags=15;
subjects= {'SM','LS','LB','RW','AS'};

for type=4:-1:1
    
    if type==1
        color='k';
    else
        if type==2
            color='c';
        else
            if type==3
                color='k';
            else
                if type==4
                    color='r';
                end
            end
        end
    end
    
    AllTsignAmpCorrX=[];
    AllTsignAmpCorrY=[];
    AllTsignDistCorrX=[];
    AllTsignDistCorrY=[];
    
    for sub_i=1:length(subjects)
        sub=subjects(sub_i);
        sub=sub{1,1};
        if type==1
            load(['C:\Users\bnapp\Documents\tunnelledVisionPaper\analyzing\resultsVectors_forXY\' sub '\allShapeBAnalogallSessionallTrialcAnswer.mat']);
        else
            if type==2
                load(['C:\Users\bnapp\Documents\tunnelledVisionPaper\analyzing\resultsVectors_forXY\' sub '\allShapeBAnalogallSessionallTrialcAnswer.mat']);
            else
                if type==3
                    load(['C:\Users\bnapp\Documents\tunnelledVisionPaper\analyzing\resultsVectors_forXY\' sub '\allShapeSAnalogallSessionallTrialcAnswer.mat']);
                else
                    if type==4
                        load(['C:\Users\bnapp\Documents\tunnelledVisionPaper\analyzing\resultsVectors_forXY\' sub '\allShapeSAnalogallSessionallTrialcAnswer.mat']);
                    end
                end
            end
        end
        relDX=0;
        relTX=0;
        signAmpCorrX=zeros(1,corrLags*2+1);
        signDistCorrX=zeros(1,corrLags*2+1);
        
        relDY=0;
        relTY=0;
        signAmpCorrY=zeros(1,corrLags*2+1);
        signDistCorrY=zeros(1,corrLags*2+1);
        borderD=0;
        
        ampsPerTrialX=zeros(1,50);
        distsPerTrialX=zeros(1,50);
        ampsPerTrialY=zeros(1,50);
        distsPerTrialY=zeros(1,50);
        
        for t=1:length(labeled_saccade_vecs)
            labeled_saccade_vec=labeled_saccade_vecs{1,t};
            relInx=zeros(1,size(labeled_saccade_vec,2)-1);
            for  ii=1:size(labeled_saccade_vec,2)-1
                   if labeled_saccade_vec(9,ii)==1 
                       borderD=borderD+1;
                       relInx(ii)=1;
                   end
            end
            if type==1 ||type==3 
                relInx=relInx+1;
                relInx(relInx==2)=0;
            end
            if length(relInx)==1
                relInx=0;
            end
            XY_vec_deg=XY_vecs_deg{1,t};   
            
            for i =find(relInx)
                tempX=(XY_vec_deg(1,((labeled_saccade_vec(1,i)+labeled_saccade_vec(2,i)):labeled_saccade_vec(1,i+1)))');
                tempY=(XY_vec_deg(2,((labeled_saccade_vec(1,i)+labeled_saccade_vec(2,i)):labeled_saccade_vec(1,i+1)))');
                if length(tempX)>corrLags && size(labeled_saccade_vec,2)>2
                    relDX=relDX+1;
                    currAmp=[];
                    currDist=[];
                    for j=2:length(tempX)
                        currAmp(j-1) = tempX(j)-tempX(j-1);
                        currDist(j-1)=tempX(j)-tempX(1);
                    end
                    %for any given drift
                    if length((find(currAmp)))<corrLags*2/3
                       relDX=relDX-1;
                    else
                    ampsPerTrialX(relDX,1:length(currAmp))= currAmp;
                    distsPerTrialX(relDX,1:length(currDist))= currDist;
                    end
%                     ampsPerTrialX=[ampsPerTrialX  currAmp];
%                     distsPerTrialX=[distsPerTrialX  currDist];
                end
                if length(tempY)>corrLags && size(labeled_saccade_vec,2)>2
                    relDY=relDY+1;
                    currAmp=[];
                    currDist=[];
                    for j=2:length(tempY)
                        currAmp(j-1) = tempY(j)-tempY(j-1);
                        currDist(j-1)=tempY(j)-tempY(1);
                    end
                    %for any given drift
                    if length((find(currAmp)))<corrLags*2/3
                        relDY=relDY-1;
                    else
                        ampsPerTrialY(relDY,1:length(currAmp))= currAmp;
                        distsPerTrialY(relDY,1:length(currDist))= currDist;
                    end
                    %                     ampsPerTrialY=[ampsPerTrialY currAmp];
                    %                     distsPerTrialY=[distsPerTrialY currDist];
                end
                
            end
            if ~isempty(ampsPerTrialX)
                relTX=relTX+1;
                for num_d=1:relDX
                    [xcf_amp,lags_amp,bounds_amp]=crosscorr(ampsPerTrialX(num_d,:),ampsPerTrialX(num_d,:),corrLags);%min(corrLags,length(find(ampsPerTrialX(num_d,:)))-1));
                    [xcf_dist,lags_dist,bounds_dist]=crosscorr(distsPerTrialX(num_d,:),distsPerTrialX(num_d,:),corrLags);%min(corrLags,length(find(distsPerTrialX(num_d,:)))-1));
                    for l=-corrLags:1:corrLags
                        if max(lags_amp==l)>0
                            if xcf_amp(lags_amp==l)>bounds_amp(1) || xcf_amp(lags_amp==l)<bounds_amp(2)
                                signAmpCorrX(num_d,l+corrLags+1)=xcf_amp(lags_amp==l);
                            end
                            if xcf_dist(lags_dist==l)>bounds_dist(1) || xcf_dist(lags_dist==l)<bounds_dist(2)
                                signDistCorrX(num_d,l+corrLags+1)=xcf_dist(lags_dist==l);
                            end
                        end
                    end
                end
            end
            if ~isempty(ampsPerTrialY)
                relTY=relTY+1;
                for num_d=1:relDY
                    [xcf_amp,lags_amp,bounds_amp]=crosscorr(ampsPerTrialY(num_d,:),ampsPerTrialY(num_d,:),corrLags);%min(corrLags,length(find(ampsPerTrialY(num_d,:)))-1));
                    [xcf_dist,lags_dist,bounds_dist]=crosscorr(distsPerTrialY(num_d,:),distsPerTrialY(num_d,:),corrLags);%min(corrLags,length(find(distsPerTrialY(num_d,:)))-1));
                    for l=-corrLags:1:corrLags
                        if max(lags_amp==l)>0
                            if xcf_amp(lags_amp==l)>bounds_amp(1) || xcf_amp(lags_amp==l)<bounds_amp(2)
                                signAmpCorrY(num_d,l+corrLags+1)=xcf_amp(lags_amp==l);
                            end
                            if xcf_dist(lags_dist==l)>bounds_dist(1) || xcf_dist(lags_dist==l)<bounds_dist(2)
                                signDistCorrY(num_d,l+corrLags+1)=xcf_dist(lags_dist==l);
                            end
                        end
                    end
                end
            end
            
        end
        
        
        AllTsignAmpCorrX = [AllTsignAmpCorrX ; signAmpCorrX];
        AllTsignAmpCorrY = [AllTsignAmpCorrY ; signAmpCorrY];
        AllTsignDistCorrX = [AllTsignDistCorrX ; signDistCorrX];
        AllTsignDistCorrY = [AllTsignDistCorrY ; signDistCorrY];
        
    end
    
    signAmpCorrX = AllTsignAmpCorrX ;
    signAmpCorrY = AllTsignAmpCorrY ;
    signDistCorrX = AllTsignDistCorrX ;
    signDistCorrY = AllTsignDistCorrY ;
    
    figure(62)
    set(gcf,'units','normalized','outerposition',[0 0 1 1])
    figure(61)
    set(gcf,'units','normalized','outerposition',[0 0 1 1])
    
    if type==1 figure(62); figN=5; end
    if type==3 figure(62); figN=6; end
    
    if type==2 figure(61); figN=5; end
    if type==4 figure(61); figN=6; end
    
    subplot(2,4,figN)
    signAmpCorrX(signAmpCorrX>0.5)=0.5;
    imagesc(signAmpCorrX(:,corrLags+1:end),[-1 1])
    colormap('jet')
    caxis([-0.5 0.5])
    colorbar
    if figN==5
        ylabel('trials','FontSize',20)
    end
    xlabel('time lags [ms]','FontSize',20)
    axis([1 15 0 size(signAmpCorrX,1)])
    xticks(6:5:25);
    xticklabels({'50','100','150','200','250'});
    GAP=round(size(signAmpCorrX,1)/5);
    yticks(10:GAP:size(signAmpCorrX,1));
    yticklabels({'SM','LS','LB','RW','AS'});
    NEW=signAmpCorrX(:,corrLags+1:end);
    temp1=find(NEW(:,11)>0);
    temp2=find(NEW(:,11)>NEW(:,10));
    temp3=find(NEW(:,11)>NEW(:,12));
    tempint=intersect(temp1,temp2);
    tempint=intersect(tempint,temp3);
    numberOfPer100=size(tempint,1)/size(signAmpCorrX,1)*100;
    title(['100ms periodic trials=' num2str(round(numberOfPer100)) '\%'],'FontSize',20)
    
    
    if type==1 figure(62); figN=7; end
    if type==3 figure(62); figN=8; end
    
    if type==2 figure(61); figN=7; end
    if type==4 figure(61); figN=8; end
    
    subplot(2,4,figN)
    imagesc(signAmpCorrY(:,corrLags+1:end),[-1 1])
    colormap('jet')
    caxis([-0.5 0.5])
    colorbar
    xlabel('time lags [ms]','FontSize',20)
    axis([1 15 0 size(signAmpCorrY,1)])
    xticks(6:5:25);
    xticklabels({'50','100','150','200','250'});
    GAP=round(size(signAmpCorrY,1)/5);
    yticks(10:GAP:size(signAmpCorrY,1));
    yticklabels({'SM','LS','LB','RW','AS'});
    NEW=signAmpCorrY(:,corrLags+1:end);
    temp1=find(NEW(:,11)>0);
    temp2=find(NEW(:,11)>NEW(:,10));
    temp3=find(NEW(:,11)>NEW(:,12));
    tempint=intersect(temp1,temp2);
    tempint=intersect(tempint,temp3);
    numberOfPer100=size(tempint,1)/size(signAmpCorrY,1)*100;
    title(['100ms periodic trials=' num2str(round(numberOfPer100)) '\%'],'FontSize',20)
    
    
    if type==1 figure(62); figN=5; end
    if type==3 figure(62); figN=6; end
    
    if type==2 figure(61); figN=5; end
    if type==4 figure(61); figN=6; end
    
    subplot(4,4,figN)
    hold on
    NEW=signAmpCorrX;
    sumX=sum(NEW);
    bar(10:10:corrLags*10,sumX(corrLags+2:end)./size(NEW,1),color,'FaceAlpha',0.5);
    xticks(0:50:corrLags*10-1)
    if figN==5
        ylabel({' sum of';'sign corr'},'FontSize',20)
    end
    axis([0 170 -0.02 0.091])
    if figN==5
        title({'Horizontal' 'Inst Velocity - LARGE'},'FontSize',25)
        figure(61); title('');
    end
    if figN==6
        title('SMALL','FontSize',25)
        figure(61); title('');
    end
    
    if type==1 figure(62); figN=7; end
    if type==3 figure(62); figN=8; end
    
    if type==2 figure(61); figN=7; end
    if type==4 figure(61); figN=8; end
    
    subplot(4,4,figN)
    hold on
    NEW=signAmpCorrY;
    sumY=sum(NEW);
    bar(10:10:corrLags*10,sumY(corrLags+2:end)./size(NEW,1),color,'FaceAlpha',0.5);
    xticks(0:50:corrLags*10-1)
    axis([0 170 -0.02 0.091])
    if figN==7
        title({'Vertical' 'Inst Velocity - LARGE'},'FontSize',25)
        figure(61); title('');
    end
    if figN==8
        title('SMALL','FontSize',25)
        figure(61); title('');
    end
    %
    figure(63)
    set(gcf,'units','normalized','outerposition',[0 0 1 1])
    if type==1 || type==2
        subplot(4,4,13)
        title('Travelled Dist - LARGE','FontSize',25)
        ylabel({' sum of';'sign corr'})
    else
        ylabel('')
    end
    if type==3 || type==4
        subplot(4,4,14)
        title('SMALL','FontSize',25)
    end
    hold on
    NEW=signDistCorrX;
    sumX=sum(NEW);
    plot(10:10:corrLags*10,sumX(corrLags+2:end)./size(NEW,1),[color '.']);
    f=fit((10:10:corrLags*10)',(sumX(corrLags+2:end)./size(NEW,1))','exp1','Lower',[0.8 -0.05],'Upper',[1.2 -0.001]);
    hold on
    plot(f,color);
    if type==1 || type==2
        subplot(4,4,13)
        ylabel({' sum of';'sign corr'},'FontSize',20)
    else
        ylabel('')
    end
    legend('off')
    
    if type==1 || type==3
        text(75,0.8,['Tau decay='  num2str(10*round(1/-round(f.b*10,2))) 'ms'],'color',color,'FontSize',20)
    else
        text(75,0.6,['Tau decay='  num2str(10*round(1/-round(f.b*10,2))) 'ms'],'color',color,'FontSize',20);
    end
    xticks(0:100:corrLags*10-1)
    xlabel('')
    axis([0 150 0 1])
    
    if type==1 || type==2
        subplot(4,4,15)
        title('Travelled Dist - LARGE','FontSize',25)
    end
    if type==3 || type==4
        subplot(4,4,16)
        title('SMALL','FontSize',25)
    end
    hold on
    NEW=signDistCorrY;
    sumY=sum(NEW);
    plot(10:10:corrLags*10,sumY(corrLags+2:end)./size(NEW,1),[color '.']);
    f=fit((10:10:corrLags*10)',(sumY(corrLags+2:end)./size(NEW,1))','exp1','Lower',[0.8 -0.05],'Upper',[1.2 -0.001]);
%     if type==1
%         f.b=-.015;
%         x=10:10:corrLags*10;
%         y=0.7*exp(-.015*x);
%         plot(x,y)
%     end
%     if type==3
%         f.b=-.02;
%         x=10:10:corrLags*10;
%         y=0.8*exp(-.015*x);
%         plot(x,y)
%     end
    hold on
    plot(f,color);
    legend('off')
    if type==1 || type==3
        text(75,0.8,['Tau decay=' num2str(10*round(1/-round(f.b*10,2))) 'ms'],'color',color,'FontSize',20)
    else
        text(75,0.6,['Tau decay=' num2str(10*round(1/-round(f.b*10,2))) 'ms'],'color',color,'FontSize',20)
    end
    xticks(0:100:corrLags*10-1)
    xlabel('')
    ylabel('')
    axis([0 150 0 1])
    
end

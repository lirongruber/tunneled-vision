subjects= {'SM','LS','LB','RW','AS'};

for type=4:-1:1
    
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
    
    AllTDistX=[];
    AllTDistY=[];
    
    for sub_i=1:length(subjects)
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
        relDX=0;
        relTX=0;
        DistX=nan(1,500);
        
        relDY=0;
        relTY=0;
        DistY=nan(1,500);
        
        for t=1:length(labeled_saccade_vecs)
            labeled_saccade_vec=labeled_saccade_vecs{1,t};
            XY_vec_deg=XY_vecs_deg{1,t};
            
            distsPerTrialX=nan(1,500);
            distsPerTrialY=nan(1,500);
            
            for i =1:size(labeled_saccade_vec,2)-1
                tempX=(XY_vec_deg(1,((labeled_saccade_vec(1,i)+labeled_saccade_vec(2,i)):labeled_saccade_vec(1,i+1)))');
                tempY=(XY_vec_deg(2,((labeled_saccade_vec(1,i)+labeled_saccade_vec(2,i)):labeled_saccade_vec(1,i+1)))');
                
                if length(tempX)>10 && size(labeled_saccade_vec,2)>2
                    relDX=relDX+1;
                    currDist=[];
                    for j=2:length(tempX)
                        currDist(j-1)=abs(tempX(j)-tempX(1));
                    end
                    %for any given drift
                    distsPerTrialX(relDX,1:size(currDist,2))= currDist;
                end
                if length(tempY)>10 && size(labeled_saccade_vec,2)>2
                    relDY=relDY+1;
                    currDist=[];
                    for j=2:length(tempY)
                        currDist(j-1)=abs(tempY(j)-tempY(1));
                    end
                    %for any given drift
                    distsPerTrialY(relDY,1:size(currDist,2))= currDist;
                end
                
            end
            if ~isempty(distsPerTrialX)
                relTX=relTX+1;
                DistX=[DistX ; distsPerTrialX];
            end
            if ~isempty(distsPerTrialY)
                relTY=relTY+1;
                DistY=[DistY ; distsPerTrialY];
            end
            
            AllTDistX = [AllTDistX ; DistX];
            AllTDistY = [AllTDistY ; DistY];
            
        end
        
        distXPerSub{sub_i} = AllTDistX ;
        distYPerSub{sub_i} = AllTDistY ;
        
    end
    distXPerCond{type}=[distXPerSub{1}; distXPerSub{2}; distXPerSub{3}; distXPerSub{4}; distXPerSub{5}];
    distYPerCond{type}=[distYPerSub{1}; distYPerSub{2}; distYPerSub{3}; distYPerSub{4};distYPerSub{5}];
end
%%
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
    shadedErrorBar(time,nanmean(currX),nanstd(currX)./300);
    hold on
    xlabel('Time [ms]')
    ylabel('Dist horizontal [deg]')
    title(titles{type})
    axis([0 2000 0 1])
    
    subplot(3,4,type+4)
%     plot(time,nanmean(currY))
    shadedErrorBar(time,nanmean(currY),nanstd(currY)./300);
    hold on
    xlabel('Time [ms]')
    ylabel('Dist vertical [deg]')
    axis([0 2000 0 1])
    
    subplot(3,4,type+8)
%     plot(time,nanmean(sqrt(currX.^2+currY.^2)))
    shadedErrorBar(time,nanmean(sqrt(currX.^2+currY.^2)),nanstd(sqrt(currX.^2+currY.^2))./300);
    hold on
    xlabel('Time [ms]')
    ylabel('Dist [deg]')
    axis([0 2000 0 1])
end
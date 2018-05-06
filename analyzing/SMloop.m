% SMS loop: drifts + saccades
% some sensory parameter : amount/percent of white pixels throughout the
% saccade/fixation
% output: SM_value
% row 1:2 saccade motor 3:4 drift motor (amp+vel)
% row 5:6 saccade sensory 7:8 drift sensory (sum +diff sum)

function [SM_value,SM_interDrift_value,corrMatrix]=SMloop(labeled_saccade_vec,M_saccade_vec,XY_vec_pix,XY_vec_deg,imdata,analogType)

S_saccade_vec=labeled_saccade_vec(1:3,1:end-1);
imdata=imdata./256;

wideSetup=[1 3/2 0];
if strcmp(analogType,'B')
    ms=158;
else
    ms=10;
end
wW=1920;
wH=1080;
if strcmp(analogType,'N') %for naturalV control
    ms=158/6;
end


for i=1:size(S_saccade_vec,2)
    if i<size(S_saccade_vec,2)
        if labeled_saccade_vec(4,i)~=0
            currFixationX=XY_vec_pix(1,(S_saccade_vec(1,i)+S_saccade_vec(2,i)):S_saccade_vec(1,i+1));
            currFixationY= XY_vec_pix(2,(S_saccade_vec(1,i)+S_saccade_vec(2,i)):S_saccade_vec(1,i+1));
            %for inter-drift-corr:
            currFixationXdeg=XY_vec_deg(1,(S_saccade_vec(1,i)+S_saccade_vec(2,i)):S_saccade_vec(1,i+1));
            currFixationYdeg= XY_vec_deg(2,(S_saccade_vec(1,i)+S_saccade_vec(2,i)):S_saccade_vec(1,i+1));
            %
            fixationSum=0;
            fixationDifSum=0;
            driftInterDifAmp=0;
            driftInterDifSen=0;
            lenF=S_saccade_vec(1,i+1)-(S_saccade_vec(1,i)+S_saccade_vec(2,i))+1;
            if lenF>1
                for j=1:lenF-1
                    currx=currFixationX(j);
                    curry=currFixationY(j);
                    nextx=currFixationX(j+1);
                    nexty=currFixationY(j+1);
                    
                    myrect=[currx-(ms/(1+1/wideSetup(2))) curry-(ms/(1+wideSetup(2))) currx+(ms/(1+1/wideSetup(2)))+1 curry+(ms/(1+wideSetup(2)))+1];
                    nextrect=[nextx-(ms/(1+1/wideSetup(2))) nexty-(ms/(1+wideSetup(2))) nextx+(ms/(1+1/wideSetup(2)))+1 nexty+(ms/(1+wideSetup(2)))+1];
                    
                    y1=max(1,round(myrect(2))); y1=min(y1,wH);
                    y2=max(1,round(myrect(4))); y2=min(y2,wH);
                    x3=max(1,round(myrect(1))); x3=min(x3,wW);
                    x4=max(1,round(myrect(3))); x4=min(x4,wW);
                    
                    y11=max(1,round(nextrect(2))); y11=min(y11,wH);
                    y22=max(1,round(nextrect(4))); y22=min(y22,wH);
                    x33=max(1,round(nextrect(1))); x33=min(x33,wW);
                    x44=max(1,round(nextrect(3))); x44=min(x44,wW);
                    
                    
                    currWindow=imdata(y1:y2,x3:x4);
                    nextWindow=imdata(y11:y22,x33:x44);
                    
                    currSum=sum(sum(currWindow));
                    currDifSum=abs(sum(sum(nextWindow))-sum(sum(currWindow)));
                    fixationSum=fixationSum+currSum;
                    fixationDifSum=fixationDifSum+currDifSum;
                    %                 if j==1
                    %                     fixationDifSum=fixationDifSum+currSum;
                    %                 end
                    
                    %for inter-drift-corr:
                    currxdeg=currFixationXdeg(j);
                    currydeg=currFixationYdeg(j);
                    nextxdeg=currFixationXdeg(j+1);
                    nextydeg=currFixationYdeg(j+1);
                    driftInterDifAmp(j)=EUDist([currxdeg,currydeg ],[nextxdeg,nextydeg]);
                    driftInterDifSen(j)=currDifSum;
                    %
                end
            end
            S_saccade_vec(7,i)=fixationSum/(lenF*ms*ms);
            S_saccade_vec(8,i)=fixationDifSum/(lenF*ms*ms);
            M_inter_drift{i}=driftInterDifAmp;
            S_inter_drift{i}=driftInterDifSen/(ms*ms);
        else
            S_saccade_vec(7,i)=0;
            S_saccade_vec(8,i)=0;
            M_inter_drift{i}=0;
            S_inter_drift{i}=0;
        end
    end
    SM_interDrift_value{1,1}=M_inter_drift;
    SM_interDrift_value{1,2}=S_inter_drift;
    
    currSaccadeX= XY_vec_pix(1,S_saccade_vec(1,i):(S_saccade_vec(1,i)+S_saccade_vec(2,i)));
    currSaccadeY= XY_vec_pix(2,S_saccade_vec(1,i):(S_saccade_vec(1,i)+S_saccade_vec(2,i)));
    
    saccadeSum=0;
    saccadeDifSum=0;
    lenSac=S_saccade_vec(2,i);
    if lenSac>1
        for k=1:lenSac-1
            currx=currSaccadeX(k);
            curry=currSaccadeY(k);
            nextx=currSaccadeX(k+1);
            nexty=currSaccadeY(k+1);
            myrect=[currx-(ms/(1+1/wideSetup(2))) curry-(ms/(1+wideSetup(2))) currx+(ms/(1+1/wideSetup(2)))+1 curry+(ms/(1+wideSetup(2)))+1];
            nextrect=[nextx-(ms/(1+1/wideSetup(2))) nexty-(ms/(1+wideSetup(2))) nextx+(ms/(1+1/wideSetup(2)))+1 nexty+(ms/(1+wideSetup(2)))+1];
            
            y1=max(1,round(myrect(2))); y1=min(y1,wH);
            y2=max(1,round(myrect(4))); y2=min(y2,wH);
            x3=max(1,round(myrect(1))); x3=min(x3,wW);
            x4=max(1,round(myrect(3))); x4=min(x4,wW);
            
            y11=max(1,round(nextrect(2))); y11=min(y11,wH);
            y22=max(1,round(nextrect(4))); y22=min(y22,wH);
            x33=max(1,round(nextrect(1))); x33=min(x33,wW);
            x44=max(1,round(nextrect(3))); x44=min(x44,wW);
            
            currWindow=imdata(y1:y2,x3:x4);
            nextWindow=imdata(y11:y22,x33:x44);
            
            currSum=sum(sum(currWindow));
            currDifSum=abs(sum(sum(nextWindow))-sum(sum(currWindow)));
            saccadeSum=saccadeSum+currSum;
            saccadeDifSum=saccadeDifSum+currDifSum;
            %             if k==1
            %                 saccadeDifSum=saccadeDifSum+currSum;
            %             end
            
        end
    end
    
    S_saccade_vec(5,i)=saccadeSum/(lenSac);
    S_saccade_vec(6,i)=saccadeDifSum/(lenSac);
    
end
SM_value=[M_saccade_vec(4:7,:) ; S_saccade_vec(5:8,:) ; M_saccade_vec(8,:)];
% SM_value
% row 1:2 saccade motor 3:4 drift motor (amp+vel)
% row 5:6 saccade sensory 7:8 drift sensory (sum +diff sum)
SMA=SM_value(1,:)'; % saccase motor amplitude
SMV=SM_value(2,:)'; % saccade motor velocity
DMA=SM_value(3,:)'; % drift motor amplitude
DMV=SM_value(4,:)'; % drift motor velocity
SSS=SM_value(5,:)'; % saccade senosory sum
SSD=SM_value(6,:)'; % saccade senosory dif
DSS=SM_value(7,:)'; % drift senosory sum
DSD=SM_value(8,:)'; % drift senosory dif

corrMatrix=[];
% [corrMatrix]=corrSMS(SMA,SMV,DMA,DMV,SSS,SSD,DSS,DSD);


end

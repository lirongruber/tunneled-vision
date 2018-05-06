% drifts analysis
%input - res of samples (example - 0.01 sec)
%output: times,amplitudes, velocities and
%          shape-labels in row 4
%          if strait drift -  angle in row 8
%          if border - border flag in row 9
%          if strait-border - border angle in row 10


% shape-label 0 = no drift
% shape-label 1 = kinda strait
% shape-label 2 = kinda circular
% shape-label 3 = both/other/medium

% border-label 1 = border
% border-label 0 = not border


function [driftLabeled_saccade_vec,drift_time_ms,drift_dist_degrees,drift_amp_degrees,drift_vel_deg2sec]=drifts(labeled_saccade_vec,XY_vec_deg,XY_vec_pix,res,imdata,analogType)

thresholdDist=100;%in pixels
if strcmp(analogType,'B')
    thresholdDist=100;%in pixels
    thresholdDist=100;%in pixels
else
    thresholdDist=10;%in pixels
end

driftLabeled_saccade_vec=labeled_saccade_vec;
movieColors='';
movieColors(1:length(XY_vec_deg))='k';
drift_time_ms=[];
drift_amp_degrees=[];
drift_dist_degrees=[];
drift_vel_deg2sec=[];

minDriftTimeMs=40; % x*10 milsec
minLengthofDrift=0.15;% in degrees!
%para for type of drift:
smallDistofDrift=0.15; %for kinda circular
bigLenthofline=smallDistofDrift*6;%for kinda circular
bigDistofDrift=0.3; % for kinda strait

clearImdata=imdata;
clearImdata(clearImdata<150)=0;
BW1=edge(clearImdata);
BW2=edge(clearImdata,'Roberts');
BW=BW1+BW2;

[c,r]=find(BW);
curve=[r,c];
% for viewing data:
% imshow(imdata)
%

for i =1:size(labeled_saccade_vec,2)-1
    temp=[];
    tempPix=[];
    temp=(XY_vec_deg(:,((labeled_saccade_vec(1,i)+labeled_saccade_vec(2,i)):labeled_saccade_vec(1,i+1)))');
    tempPix=(XY_vec_pix(:,((labeled_saccade_vec(1,i)+labeled_saccade_vec(2,i)):labeled_saccade_vec(1,i+1)))');
    [len,~,~] = EULength(temp);
    drift_time_ms(i)=length(temp)*res*1000; % x*10 milsec
    drift_dist_degrees(i)=EUDist(XY_vec_deg(:,(labeled_saccade_vec(1,i)+labeled_saccade_vec(2,i)))',XY_vec_deg(:,(labeled_saccade_vec(1,i+1)))');
    
    drift_amp_degrees(i)=len;
    drift_vel_deg2sec(i)=drift_amp_degrees(i)/(drift_time_ms(i)/1000);
    
    if drift_amp_degrees(i)> 10 || drift_amp_degrees(i)<minLengthofDrift || drift_time_ms(i)< minDriftTimeMs
        drift_amp_degrees(i)=0;
        drift_dist_degrees(i)=0;
        drift_vel_deg2sec(i)=0;
        drift_time_ms(i)=0;
    end
    
    if drift_time_ms(i)< minDriftTimeMs || len<minLengthofDrift
        driftLabeled_saccade_vec(4,i)= 0;
    else if  len> 6*drift_dist_degrees(i) %drift_dist_degrees<smallDistofDrift  && len>bigLenthofline %2 = kinda circular
            driftLabeled_saccade_vec(4,i)= 2;
        else if drift_dist_degrees(i)> bigDistofDrift
                driftLabeled_saccade_vec(4,i)= 1;% 1 = kinda strait
            else
                driftLabeled_saccade_vec(4,i)= 3;
            end
        end
        
        
    end
    
    typed=driftLabeled_saccade_vec(4,i);
    driftFirst=tempPix(1,:);
    driftLast=tempPix(end,:);
    d1=EUDist(curve,driftFirst);
    d2=EUDist(curve,driftLast);
    [minDist1,inx_minDist1]=min(d1);
    [minDist2,inx_minDist2]=min(d2);
    closePointOnBorder_first=curve(inx_minDist1,:);
    closePointOnBorder_last=curve(inx_minDist2,:);
    if typed==1
        driftAngle=atan2d(driftLast(2)-driftFirst(2),driftLast(1)-driftFirst(1));
        driftLabeled_saccade_vec(8,i)=driftAngle;
    else
        driftLabeled_saccade_vec(8,i)=-1000;
    end
    BorderAngle=atan2d(closePointOnBorder_last(2)-closePointOnBorder_first(2),closePointOnBorder_last(1)-closePointOnBorder_first(1));
    if minDist1<thresholdDist  &&  minDist2<thresholdDist
        driftLabeled_saccade_vec(9,i)=1;
        if typed==1
        driftLabeled_saccade_vec(10,i)=BorderAngle;
        else
         driftLabeled_saccade_vec(10,i)=-1000;   
        end
    else
        driftLabeled_saccade_vec(9,i)=0;
    end

%         % for viewing data:
%         hold on
%         typed=driftLabeled_saccade_vec(4,i);
%         typeS=driftLabeled_saccade_vec(5,i);
%         if typed==0
%             disp('no drift')
%             c='k';
%             movieColors((labeled_saccade_vec(1,i)+labeled_saccade_vec(2,i)):labeled_saccade_vec(1,i+1))='k';
%         else if typed==1
%                 disp('strait')
%                 c='b';
%                 movieColors((labeled_saccade_vec(1,i)+labeled_saccade_vec(2,i)):labeled_saccade_vec(1,i+1))='b';
%             else if typed==2
%                     disp('circular')
%                     c='g';
%                     movieColors((labeled_saccade_vec(1,i)+labeled_saccade_vec(2,i)):labeled_saccade_vec(1,i+1))='b';
%                 else if typed==3
%                         disp('other')
%                         c='k';
%                         movieColors((labeled_saccade_vec(1,i)+labeled_saccade_vec(2,i)):labeled_saccade_vec(1,i+1))='b';
%                     end
%                 end
%             end
%         end
%         if typeS==1
%             cS='c';
%             movieColors((labeled_saccade_vec(1,i):labeled_saccade_vec(1,i)+labeled_saccade_vec(2,i)))='c';
%         else
%             cS='m';
%             movieColors((labeled_saccade_vec(1,i):labeled_saccade_vec(1,i)+labeled_saccade_vec(2,i)))='c';
%         end
%         plot(XY_vec_pix(1,(labeled_saccade_vec(1,i)+labeled_saccade_vec(2,i)):labeled_saccade_vec(1,i+1)),XY_vec_pix(2,(labeled_saccade_vec(1,i)+labeled_saccade_vec(2,i)):labeled_saccade_vec(1,i+1)),[c])
%         plot(XY_vec_pix(1,(labeled_saccade_vec(1,i):labeled_saccade_vec(1,i)+labeled_saccade_vec(2,i))),XY_vec_pix(2,(labeled_saccade_vec(1,i):labeled_saccade_vec(1,i)+labeled_saccade_vec(2,i))),[cS])
% %         pause(0.2)
%         %
%     
% end
% %     pause
% if length(XY_vec_pix)<1500
%     figure(10)
%     imshow(imdata)
%     hold on
%     j=1;
%     f=0;
%     for i=2:length(XY_vec_pix)/2-20
% %     for i=2:length(XY_vec_pix)-1
%         if strcmp(movieColors(i),'k')==0
%             f=f+1;
%             if strcmp(movieColors(i),movieColors(i-1))==0
%                 j=i;
%                 plot(XY_vec_pix(1,i),XY_vec_pix(2,i),['.' movieColors(i)])
%                 axis([0 1920 0 1080])
%                 M(f) = getframe(gcf);
%             else
%                 plot(XY_vec_pix(1,j:i),XY_vec_pix(2,j:i),[movieColors(i)])
%                 axis([0 1920 0 1080])
%                 M(f) = getframe(gcf);
%             end
%             pause(0.015)
%         end
%     end
%     myVideo = VideoWriter('AAA.avi');
%     myVideo.Quality = 100;
%     myVideo.FrameRate = 40;
%     open(myVideo);
%     writeVideo(myVideo, M);
%     close(myVideo);
% end
end
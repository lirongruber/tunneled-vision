% drifts analysis
%input - res of samples (example - 0.01 sec)
%output: times,amplitudes, velocities and labels in row 4:

% label 0 = no drift
% label 1 = kinda strait
% label 2 = kinda circular
% label 3 = both/other/medium


function [driftLabeled_saccade_vec,drift_time_ms,drift_dist_degrees,drift_amp_degrees,drift_vel_deg2sec]=Ehud_drifts(labeled_saccade_vec,XY_vec_deg,XY_vec_pix,res,imdata)

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

% for viewing data:
imshow(imdata)
%

for i =1:size(labeled_saccade_vec,2)-1
    temp=[];
    temp=(XY_vec_deg(:,((labeled_saccade_vec(1,i)+labeled_saccade_vec(2,i)):labeled_saccade_vec(1,i+1)))');
    [len,~,~] = EULength(temp);
    drift_time_ms(i)=length(temp)*res*1000; % x*10 milsec
    drift_dist_degrees(i)=EUDist(XY_vec_deg(:,(labeled_saccade_vec(1,i)+labeled_saccade_vec(2,i)))',XY_vec_deg(:,(labeled_saccade_vec(1,i+1)))');
    
    drift_amp_degrees(i)=len;
    drift_vel_deg2sec(i)=drift_amp_degrees(i)/(drift_time_ms(i)/1000);
    
    if drift_amp_degrees(i)> 10 || drift_amp_degrees(i)<minLengthofDrift || drift_time_ms(i)< minDriftTimeMs
        drift_amp_degrees(i)=0;
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
    % for viewing data:
    hold on
    typed=driftLabeled_saccade_vec(4,i);
    typeS=driftLabeled_saccade_vec(5,i);
    if typed==0
        disp('no drift')
        c='k';
        movieColors((labeled_saccade_vec(1,i)+labeled_saccade_vec(2,i)):labeled_saccade_vec(1,i+1))='k';
    else if typed==1
            disp('strait')
            c='b';
            movieColors((labeled_saccade_vec(1,i)+labeled_saccade_vec(2,i)):labeled_saccade_vec(1,i+1))='b';
        else if typed==2
                disp('circular')
                c='g';
                movieColors((labeled_saccade_vec(1,i)+labeled_saccade_vec(2,i)):labeled_saccade_vec(1,i+1))='g';
            else if typed==3
                    disp('other')
                    c='k';
                    movieColors((labeled_saccade_vec(1,i)+labeled_saccade_vec(2,i)):labeled_saccade_vec(1,i+1))='k';
                end
            end
        end
    end
    if typeS==1
        cS='c';
        movieColors((labeled_saccade_vec(1,i):labeled_saccade_vec(1,i)+labeled_saccade_vec(2,i)))='c';
    else
        cS='m';
        movieColors((labeled_saccade_vec(1,i):labeled_saccade_vec(1,i)+labeled_saccade_vec(2,i)))='m';
    end
    plot(XY_vec_pix(1,(labeled_saccade_vec(1,i)+labeled_saccade_vec(2,i)):labeled_saccade_vec(1,i+1)),XY_vec_pix(2,(labeled_saccade_vec(1,i)+labeled_saccade_vec(2,i)):labeled_saccade_vec(1,i+1)),[c])
    plot(XY_vec_pix(1,(labeled_saccade_vec(1,i):labeled_saccade_vec(1,i)+labeled_saccade_vec(2,i))),XY_vec_pix(2,(labeled_saccade_vec(1,i):labeled_saccade_vec(1,i)+labeled_saccade_vec(2,i))),[cS])
    pause(0.2)
    %

end
pause
% for saving a movie:
%     figure(10)
%     imshow(imdata)
%     hold on
%     j=1;
%     for i=2:length(XY_vec_pix)
%         if strcmp(movieColors(i),movieColors(i-1))==0
%             j=i;
%             plot(XY_vec_pix(1,i),XY_vec_pix(2,i),['.' movieColors(i)])
% %             axis([0 1920 0 1080])
%             M(i-1) = getframe(gcf);
%         else
%             plot(XY_vec_pix(1,j:i),XY_vec_pix(2,j:i),[movieColors(i)])
% %             axis([0 1920 0 1080])
%             M(i-1) = getframe(gcf);
%         end
% %         pause(0.015)
%     end
%     myVideo = VideoWriter('AAA.avi');
%     myVideo.Quality = 100;
%     myVideo.FrameRate = 40;
%         open(myVideo);
%     writeVideo(myVideo, M);
%     close(myVideo);
%
end
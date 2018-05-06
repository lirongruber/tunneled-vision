% saccades analysis
%input - res of samples (example - 0.01 sec),analogType
%output: times,amplitudes, velocities and labels in row 5:

% label 1 = border
% label 2 = horizontal
% label 3 = vertical
% label 4= other

function [labeled_saccade_vec,sacc_time_ms,sacc_amp_degrees,sacc_vel_deg2sec,sacc_maxvel_deg2sec]=Ehud_typeOfSaccade(saccade_vec,XY_vec_pix,XY_vecs_deg,imdata,res,analogType)

labeled_saccade_vec=saccade_vec;

if strcmp(analogType,'B')
    thresholdDist=100;%in pixels
    thresholdHslope=0.1;
    thresholdVslope=5;
else
    thresholdDist=30;%in pixels
    thresholdHslope=0.25;
    thresholdVslope=5;
end

BW1=edge(imdata);
BW2=edge(imdata,'Roberts');
BW=BW1+BW2;

[c,r]=find(BW);
curve=[r,c];

for i=1:size(saccade_vec,2)
    saccades{i}=XY_vecs_deg(:,(saccade_vec(1,i):saccade_vec(2,i)+saccade_vec(1,i)));
    sacc_time_ms(i)=length(saccades{i})*res*1000;
    sacc_length_degrees(i)=EULength(saccades{i}');
    tempLength=[];
    for j=1:length(saccades{i})-1
        tempLength(j)=EUDist(saccades{i}(:,j)',saccades{i}(:,j+1)');
    end
    maxtempLength(i)=max(tempLength);
end
sacc_amp_degrees=sacc_length_degrees;
sacc_vel_deg2sec=sacc_amp_degrees./(sacc_time_ms/1000);
sacc_maxvel_deg2sec=maxtempLength./res;

for i=1:length(sacc_time_ms)
    if sacc_amp_degrees(i)> 28
        sacc_amp_degrees(i)=0;
        sacc_vel_deg2sec(i)=0;
        sacc_maxvel_deg2sec(i)=0;
        sacc_time_ms(i)=0;
    end
end

%     figure(1)
%     imshow(imdata)
    
for i=1:size(saccade_vec,2)
    saccades{i}=XY_vec_pix(:,(saccade_vec(1,i):saccade_vec(2,i)+saccade_vec(1,i)));
    firstP=saccades{i}(:,1);
    lastP=saccades{i}(:,end);
    
    d1=EUDist(curve,firstP);
    d2=EUDist(curve,lastP);
    d3=EUDist(firstP',lastP');
    slope=(lastP(2)-firstP(2))/(lastP(1)-firstP(1));
    
    if min(d1)<thresholdDist && min(d2)<thresholdDist
        labeled_saccade_vec(5,i)=1;
    else if abs(slope)<  thresholdHslope && d3>20
            labeled_saccade_vec(5,i)=2;
        else if abs(slope)>  thresholdVslope && d3>20
                labeled_saccade_vec(5,i)=3;
            else
                labeled_saccade_vec(5,i)=4;
            end
        end
    end
%     %for debugging:

%     imshow(BW)
%     hold on
%     plot(curve(:,1),curve(:,2),'.')
%     plot(r,c,'.')
%     plot(firstP(1),firstP(2),'*r')
%     plot(lastP(1),lastP(2),'*b')
%     
%     type=labeled_saccade_vec(5,i);
%     if type==1
%         disp('border')
%     else if type==2
%             disp('horizontal')
%         else if type==3
%                 disp('vertical')
%             else if type==4
%                     disp('other')
%                 end
%             end
%         end
%     end
    
%     for example figures:

%     figure(1)
%     hold on
%     plot(saccades{i}(1,:),saccades{i}(2,:),'c')
%     if i<size(saccade_vec,2)
%     plot(XY_vec_pix(1,(labeled_saccade_vec(1,i)+labeled_saccade_vec(2,i)):labeled_saccade_vec(1,i+1)),XY_vec_pix(2,(labeled_saccade_vec(1,i)+labeled_saccade_vec(2,i)):labeled_saccade_vec(1,i+1)),'b')
%     end
% %             plot(r,c,'.')
%             plot(firstP(1),firstP(2),'*r')
%             plot(lastP(1),lastP(2),'*b')
%     
    
    
end
end

% showing visually recorded data :
%

clear
clc
close all

fileName='SM_B3';
sessionNum=1:10;
picName='triangle'; %'circle' 'triangle' etc
line='\_+';

for session_Num=sessionNum
        Name=regexp(fileName,line,'split');
        Name=Name{1,1};
        F=[Name '\' fileName '_'  num2str(session_Num)];
        full_filename = fullfile('C:\Users\bnapp\Documents\tunnelledVisionPaper\analyzing\cleanedData',F);
        load(full_filename);
        if strcmp(picName,myimgfiles{1,1}{1,1})==1
    
    %graphic view of the pictures and eye-tracks

        figure(session_Num)
        imshow(imdatas{1,1})
        hold on
        plot(gazeX,gazeY)
    
%     % pd
%     j=session_Num+max(size(sessionNum));
%         figure(j)
%         plot(pd,'.')
    
    
    % sac length
    
    % sac velocity
    
    % sac degree
    
    % sac degree-velocity
        end
end
tilefigs;

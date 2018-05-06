
function [dataLens,times,calLens,gazesX,gazesY,fixs,pds,myimgfiles,imdatas,gazesX_cal,gazesY_cal,answers,iscorrects,missedSampless]=loadAndFix(fileName,trialNum,picName)
%%%--------------------------------------------- use only from clean.m and parView.m %%%--------------


% this function loads a given session by the file name and session number
% if picName is given -  returns only sessions with that picture
% and fix to their real size (time actially) the long vectors of gaze, sac length , velocity, pupil size

cell=1;
line='\_+';
dot='\.+';
fix=[];% because it is a matlab function
%picName=regexp(picName,dot,'split');
% pix2m=0.000264583333333334; % 1 pixel (X) = 0.000264583333333334 m
% dis=1; % distance to screen

if nargin<2
    trialNum=1:10;
end

if nargin>2
    for i=trialNum
        Name=regexp(fileName,line,'split');
        Name=Name{1,1};
        F=[Name '\' fileName '_'  num2str(i)];
        SavingPath=whichComp;
        SavingPath=SavingPath(1:length(SavingPath)-6);
        full_filename = fullfile([SavingPath, '-data'],F);
        load(full_filename);
        myimgfile=regexp(myimgfile, dot, 'split'); %old data ('LG_01' or 'AM_03') -change dot to line
        if strcmp(myimgfile{1,1},picName)==1
            %how long?
            dataLen=find(gazeX,1,'last');
            dataLens{cell}=dataLen;
            times{cell}=dataLen/100;
            
            gazesX{cell}=gazeX(1:dataLen);
            gazesY{cell}=gazeY(1:dataLen);
            fixs{cell}=fix;
            missedSampless{cell}=missedSamples(1:dataLen);
            
            %             sacLen=sacLen*pix2m;
            %
            %             sacDegs{cell}=atand(sacLen/dis);
            %             sacLens{cell}=sacLen(1:dataLen);
            %
            %             sacVel=sacVel*pix2m;
            %             sacDVel=sacVel*pix2m;
            %
            %             sacVels{cell}=sacVel(1:dataLen);
            %             sacDVels{cell}=sacDVel(1:dataLen);
            pds{cell}=pd(1:dataLen);
            
            myimgfiles{cell}= myimgfile;
            imdatas{cell}=imdata;
            iscorrects{cell}=iscorrect;
            if strcmp(myimgfile{1,1},'black')
                answers{cell}=0;
            else
                answers{cell}=answer{1,1};
                if ~strcmp(answer2,'0')
                    answers{cell,2}=answer2{1,1};
                end
            end
            
            calLen=find(gazeX_cal,1,'last');
            calLens{cell}=calLen;
            gazesX_cal{cell}=gazeX_cal(1:calLen);
            gazesY_cal{cell}=gazeY_cal(1:calLen);
            
            
            cell=cell+1;
        end
    end
    if ~exist( 'imdatas', 'var') % or any other vector...
        error('no match found')
    end
else
    for i=trialNum
        Name=regexp(fileName,line,'split');
        Name=Name{1,1};
        F=[Name '\' fileName '_'  num2str(i)];
        SavingPath=whichComp;
        %         SavingPath=SavingPath(1:length(SavingPath)-6);
        full_filename = fullfile([SavingPath,F ]);
        load(full_filename);
        myimgfile=regexp(myimgfile, dot, 'split');
        %how long?
        dataLen=find(gazeX,1,'last');
        dataLens{cell}= dataLen;
        times{cell}=dataLen/100;
        
        gazesX{cell}=gazeX(1:dataLen);
        gazesY{cell}=gazeY(1:dataLen);
        fixs{cell}=fix;
        missedSampless{cell}=missedSamples(1:dataLen);
        
        pds{cell}=pd(1:dataLen);
        
        myimgfiles{cell}= myimgfile;
        imdatas{cell}=imdata;
        iscorrects{cell}=iscorrect;
        answers{cell}=answer{1,1};
        if ~strcmp(answer2,'0')
            answers{cell,2}=answer2{1,1};
        end
        
        calLen=find(gazeX_cal,1,'last');
        calLens{cell}=calLen;
        gazesX_cal{cell}=gazeX_cal(1:calLen);
        gazesY_cal{cell}=gazeY_cal(1:calLen);
        
        cell=cell+1;
    end
    
end
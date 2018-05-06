function [newimg]=resoFit(grayimg,myimgfile,analog_type,low_con_control)
%This function takes an image and :
% 1. resizing the object to fit  about 25*25 pixels ( to limit information)
% 2. resizing back to fit about 698*698 pixels or 309*309 pixels  - see word doc
% 3. finger filter it with a Gaussian with width 134  - see culcFingerToEye.m
% 4. move the object to a random place on the screen
% 5. graying the picture for less contrast (255->120).

% params:
cam_pic=0; %if the picture are camera pic - not perfect yet!!
filterSize = 134; % according to the fingers Moduli - how many pixels to include in the filter...
method='gao';
graycolor=120;
smallObjS=25*25;
if analog_type==1
%for foveola analog:
bigObjS=598*598; %for final pic size ~698*698 %  bigObjS=698*698;
gapFromEdge=200; % gap (in pixels) of objects from the screen edges
else
% for the receptors analog:
bigObjS=38*38; %for final pic size ~40*40 %bigObjS=40*40;
gapFromEdge=900; % gap (in pixels) of objects from the screen edges
filterSize=round(filterSize*sqrt(bigObjS)/698);
end

%for pictures from real camera:
if cam_pic==1
grayimg(1:100,:)=255;  grayimg(:,1:500)=255;
grayimg(800:end,:)=255;  grayimg(:,1300:end)=255;
grayimg(grayimg<graycolor)=0;% have to do that -otherwise balagan 
grayimg(grayimg>=graycolor)=255;
grayimg(grayimg==0)=250;% have to do that -otherwise balagan 
grayimg(grayimg==255)=0;
grayimg(grayimg==250)=255;
blacks=zeros(1500,2000)*255;% %%%%%%change according to screen size!
sgrayimg=size(grayimg);
blacks(1:sgrayimg(1),1:sgrayimg(2))=grayimg;
grayimg=blacks;
else
grayimg(grayimg<graycolor)=0;% have to do that -otherwise balagan 
grayimg(grayimg>=graycolor)=255;
end

%resizing and moving objects in images:
[row col]=find(grayimg);
if ~isempty(row) && ~isempty(col) && strcmp('Star.jpg',myimgfile)==0 && strcmp('small_Star.jpg',myimgfile)==0
Row= [min(row) max(row)];
Col=[min(col) max(col)];
object=grayimg(Row(1):Row(2), Col(1):Col(2));
sobject=size(object);

if  cam_pic==0
    %resizing - to small:
    smallimg=imresize(grayimg,sqrt(smallObjS/(sobject(1)*sobject(2))));
    smallimg=im2uint8(smallimg);
    smallimg(smallimg<50)=0;
    
    %resizing - to big:
    bigimg=makeImgBig(smallimg,round(sqrt(bigObjS/smallObjS)));
    temp=zeros(size(grayimg));
    temp=im2uint8( temp);
    if length(bigimg)<length(temp)
    temp(1:size(bigimg,1),1:size(bigimg,2))=bigimg; 
    bigimg=temp;
    else
     bigimg=bigimg(1:size(grayimg,1),1:size(grayimg,2));   
    end
else
    bigimg=grayimg;
end

%finger filtering:
filter = createFilterFromLevel(method,filterSize );

filtimg= bigimg;
filtimg= conv2(double(filtimg), double(filter) ,'same');
filtimg= conv2(double(filtimg), double(filter') ,'same');
filtimg=im2uint8(filtimg);
% filtimg=filtimg*0.25;

%moving:
[row , col]=find(filtimg);
movedimg=zeros(size(filtimg));
smovedimg=size(movedimg);
Row= [min(row) max(row)];
Col=[min(col) max(col)];
object=filtimg(Row(1):Row(2), Col(1):Col(2));
sobject=size(object);
gapsR=round(((smovedimg(1)-sobject(1)-gapFromEdge)-(gapFromEdge))/4);
if gapsR<0
    relRow=(size(grayimg,1)-sobject(1))/2+1;% +1 in case of 0..
else
    relRow=gapFromEdge:gapsR:abs((smovedimg(1)-sobject(1)-gapFromEdge));
end
gapsC=round(((smovedimg(2)-sobject(2)-gapFromEdge)-(gapFromEdge))/4);
if gapsC<0
    relCol=gapFromEdge;
else
    relCol=gapFromEdge:gapsC:abs((smovedimg(2)-sobject(2)-gapFromEdge));
end
newRow=ceil(relRow(ceil(rand*numel(relRow))));
newCol=ceil(relCol(ceil(rand*numel(relCol))));
movedimg=im2uint8(movedimg);
movedimg(newRow:newRow+sobject(1)-1, newCol:newCol+sobject(2)-1)=object; 


%units and graying for less contrast:
newimg=im2uint8(movedimg);
if low_con_control==0
    newimg=150/255*newimg;
else
    newimg=150/255*newimg;
%      newimg=5/255*newimg;
end

else
    newimg=grayimg.*(graycolor/255);
end
end

function [finalPic]=visitRates(XY_vec_pix,imdata,analogType,shapeForVisitRates)

wideSetup=[1 3/2 0];
if strcmp(analogType,'B')
    ms=158;
else
    ms=10;
end
wW=1920;
wH=1080;
finalPic=zeros(size(imdata));
arrivingTimes=cell(size(imdata));
[row , col]=find(imdata);
Row= [min(row) max(row)];
Col=[min(col) max(col)];
% shapeRect=imdata(Row(1):Row(2), Col(1):Col(2));
aroundImage=300; %in pixels

for i=1:length(XY_vec_pix)
    currx= XY_vec_pix(1,i);
    curry= XY_vec_pix(2,i);
    myrect=[currx-(ms/(1+1/wideSetup(2))) curry-(ms/(1+wideSetup(2))) currx+(ms/(1+1/wideSetup(2)))+1 curry+(ms/(1+wideSetup(2)))+1];
    
    y1=max(Row(1)-aroundImage,round(myrect(2))); y1=min(y1,Row(2)+aroundImage); y1=min(y1,wH); y1=max(y1,1);
    y2=max(Row(1)-aroundImage,round(myrect(4))); y2=min(y2,Row(2)+aroundImage); y2=min(y2,wH); y2=max(y2,1);
    x3=max(Col(1)-aroundImage,round(myrect(1))); x3=min(x3,Col(2)+aroundImage); x3=min(x3,wW); x3=max(x3,1);
    x4=max(Col(1)-aroundImage,round(myrect(3))); x4=min(x4,Col(2)+aroundImage); x4=min(x4,wW); x4=max(x4,1);

    if y1==y2 || x3==x4
    else
        finalPic(y1:y2,x3:x4)=finalPic(y1:y2,x3:x4)+1;
%         arrivingTimes{currx,curry}=[arrivingTimes{currx,curry} i];
    end
    currWindow=imdata(y1:y2,x3:x4);
    
end

% finalPic=finalPic./length(XY_vec_pix);
% imshow(finalPic)
% move all shape to smae place
[r,c]=find(imdata);
r=r(1);
c=c(1);
if strcmp(analogType,'B')
    if strcmp(shapeForVisitRates,'circle')
        rfinal=400;
        cfinal=450;
    else if strcmp(shapeForVisitRates,'triangle')
            rfinal=810;
            cfinal=600;
        else if strcmp(shapeForVisitRates,'square')
                rfinal=200;
                cfinal=550;
            else if strcmp(shapeForVisitRates,'rectangle')
                    rfinal=120;
                    cfinal=600;
                else if strcmp(shapeForVisitRates,'parallelog')
                        rfinal=770;
                        cfinal=600;
                    end ; end  ;end  ;end; end;
else
    rfinal=540;
    cfinal=910;
end

mover=rfinal-r;
movec=cfinal-c;

movedimg=zeros(size(finalPic));
smovedimg=size(movedimg);
if ~isempty(find(finalPic))
    [row , col]=find(finalPic);
    Row= [min(row) max(row)];
    Col=[min(col) max(col)];
    object=finalPic(Row(1):Row(2), Col(1):Col(2));
    sobject=size(object);
    % movedimg=im2uint8(movedimg);
    % movedimg(newRow:newRow+sobject(1)-1, newCol:newCol+sobject(2)-1)=object;
    if max(size(find(finalPic)))>1
        startR=Row(1)+mover;
        endR=Row(1)+mover+sobject(1)-1;
        startC=Col(1)+movec;
        endC=Col(1)+movec+sobject(2)-1;
        if startR<1
            object=object(-startR+2:end,:);
            startR=1;
        end
        if endR>wH
            object=object(1:endR-wH,:);
            endR=wH;
        end
        movedimg(startR:endR, startC:endC)=object;
    end
end
finalPic=movedimg;
% imshow(finalPic)
end
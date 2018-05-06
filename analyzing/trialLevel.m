% analysis of Trial "level" - how much white was seen

function [whiteTime]=trialLevel(XY_vec,imdata,analogType)

wideSetup=[1 3/2 0];
if strcmp(analogType,'B')
    ms=158;
else
    ms=10;
end
wW=1920;
wH=1080;
value=0;
timeOnShape=1;

for i=1:length(XY_vec)
    currx= XY_vec(1,i);
    curry= XY_vec(2,i);
    myrect=[currx-(ms/(1+1/wideSetup(2))) curry-(ms/(1+wideSetup(2))) currx+(ms/(1+1/wideSetup(2)))+1 curry+(ms/(1+wideSetup(2)))+1];
    
    y1=max(1,round(myrect(2))); y1=min(y1,wH);
    y2=max(1,round(myrect(4))); y2=min(y2,wH);
    x3=max(1,round(myrect(1))); x3=min(x3,wW);
    x4=max(1,round(myrect(3))); x4=min(x4,wW);
    
    currWindow=imdata(y1:y2,x3:x4);
    currSum=sum(sum(currWindow));
    if currSum>0
        timeOnShape=timeOnShape+1;
        value=value+currSum;
    end
 normTimeOnShape=timeOnShape/ length(XY_vec);
 s=size(currWindow);
 normValue=value/length(XY_vec)/150/s(1)/s(2);% 150 is max value for pixel (gray)- percent to white per pixel...
 whiteTime=[normTimeOnShape,normValue];
 

end
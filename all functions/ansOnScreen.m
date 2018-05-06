function [qrect,rect,picsName]= ansOnScreen(wW,wH,w,gray,NamesForAns)
% this function prepar the screen state for choosing an answer
%(must be called frim "getAnswer")

qrect=[round(wW/5) round(wH*2/15)];
rect(1,:)=[round(wW/5) round(wH*5/15) round(wW/3) round(wH*6/15)];
Screen(w,'FrameRect',gray,rect(1,:))

rect(2,:)=[round(wW/5) round(wH*7/15) round(wW/3) round(wH*8/15)];
Screen(w,'FrameRect',gray,rect(2,:))

rect(3,:)=[round(wW/5) round(wH*9/15) round(wW/3) round(wH*10/15)];
Screen(w,'FrameRect',gray,rect(3,:))

rect(4,:)=[round(wW/5) round(wH*11/15) round(wW/3) round(wH*12/15)];
Screen(w,'FrameRect',gray,rect(4,:))

rect(5,:)=[round(wW/5) round(wH*13/15) round(wW/3) round(wH*14/15)];
Screen(w,'FrameRect',gray,rect(5,:))
dot='\.+';
for i=1:max(size(NamesForAns))-1
    picsName=NamesForAns{1,i};
    picsName=regexp(picsName, dot, 'split');
    picsName= picsName{1,1};
    Screen('TextStyle', w,1);
    Screen('TextSize', w ,30);
    Screen(w,'DrawText',picsName,rect(i,1),rect(i,2));
end
end

function [answer]=getAnswerForFindingShapeExp(NamesForAns,w,wW,wH,mouseNum,gray)
% This function ask the subject after each trial to choose the correct
% number

[qrect,rect]= ansOnScreen(wW,wH,w,gray,NamesForAns);

Screen(w,'DrawText','How many did you see? ',qrect(1),qrect(2));
Screen('Flip',w);
ShowCursor('Hand');

while ~exist('answer','var')
    [~,x,y] = GetClicks(w, 0, mouseNum);
    pause(1)
    for i=1:max(size(NamesForAns))-1
        if x>=rect(i,1) && x<=rect(i,3) && y>=rect(i,2) && y<=rect(i,4)
            answer=NamesForAns{1,i};
            HideCursor;
        end
    end
end
dot='\.+';
answer=regexp(answer, dot, 'split');

disp(answer);
end






function [answer,answer2,iscorrect]=getAnswer(NamesForAns,w,wW,wH,mouseNum,gray,myimgfile)
% This function ask the subject after each session to choose the correct
% shape that was explored .(only 5 shapes are possible! )
dot='\.+';
myimgfile=regexp(myimgfile, dot, 'split');

if strcmp(myimgfile{1,1},'black')==1
    DrawFormattedText(w,'That was a black empty screen - \n \n moving on... ','center','center',[25 140 230]);
    Screen('Flip',w);
    pause(2)
    answer=[];
    answer2=[];
    iscorrect=[];
else
[qrect,rect]= ansOnScreen(wW,wH,w,gray,NamesForAns);

Screen(w,'DrawText','Which shape did you see? ',qrect(1),qrect(2));
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

answer=regexp(answer, dot, 'split');
if strcmp(answer{1,1},myimgfile{1,1})
    iscorrect=1;
    iscorrect(2)=0;
    answer2='0';
    Screen('FillRect', w, 0);
    Screen('Flip',w);
    DrawFormattedText(w,'correct !!! ','center','center',[0 200 0]);
    Screen('Flip',w);
    pause(1)
else
    iscorrect=0;
%     Screen(w,'DrawText','wrong....try again: ','center','center');
    Screen('FillRect', w, 0);
    Screen('Flip',w);
    DrawFormattedText(w, 'wrong....try again: ','center','center',[25 140 230]);
  Screen('Flip',w);
    pause(2)
    [qrect,rect]= ansOnScreen(wW,wH,w,gray,NamesForAns);
    Screen(w,'DrawText','Which shape did you see? ',qrect(1),qrect(2));
    Screen('Flip',w);
    ShowCursor('Hand');
    while ~exist('answer2','var')
        [~,x,y] = GetClicks(w, 0, mouseNum);
        pause(1)
        for i=1:max(size(NamesForAns))-1
            if x>=rect(i,1) && x<=rect(i,3) && y>=rect(i,2) && y<=rect(i,4)
                answer2=NamesForAns{1,i};
                HideCursor;
            end
        end
    end
    answer2=regexp(answer2, dot, 'split');
if strcmp(answer2{1,1},myimgfile{1,1})
     iscorrect(2)=1;
         Screen('FillRect', w, 0);
    Screen('Flip',w)
        DrawFormattedText(w,'correct !!! ','center','center',[0 200 0]);
    Screen('Flip',w);
    pause(1)
else
    iscorrect(2)=0;
    Screen('FillRect', w, 0);
    Screen('Flip',w);
    [nx, ny, ~]=DrawFormattedText(w,['wrong....the right answer is : \n \n '],'center','center',[25 140 230]);
    DrawFormattedText(w,[myimgfile{1,1}],nx,ny,[0 200 0]);
    Screen('Flip',w);
    pause(3)
    
end


end
    if ~isempty(iscorrect)
        if iscorrect(1)==1  
            disp('correct!!!');
        else if  iscorrect(2)==1
        disp('wrong :');
        disp( answer{1,1});
        disp('correct!!! (second time..)');
            else
            disp('wrong : ' );
            disp( answer{1,1});
            disp( answer2{1,1});
            end
        end
    else
        disp('black...');
    end

end




function [pd_cal,gazeX_cal,gazeY_cal,fix]=calibVer(analog_type,w,wW,wH,backgroundcolor,mouseNum,TIME_RES,eyeused,pd_cal,gazeX_cal,gazeY_cal,fix)
%verifing calibration :
plusPlace1=[200,200];
plusPlace2=[800,400];
if analog_type==1
    pluses=[wW/2,wH/2 ; plusPlace1(1),plusPlace1(2) ;wW-plusPlace1(1), wH-plusPlace1(2)];
else
    pluses=[wW/2,wH/2 ; plusPlace2(1),plusPlace2(2) ;wW-plusPlace2(1), wH-plusPlace2(2)];
end

DrawFormattedText(w, 'Follow the "+" on the screen - \n CLICK when stable \n \n (CLICK to start)','center','center',[25 140 230]);
Screen('DrawingFinished', w);
Screen('Flip',w);
pause(1)
while  KbCheck(mouseNum)==0 % waits for mouse click
end
pause(2)
for i=1:1000
    currStepTime= GetSecs;
    DrawFormattedText(w, '+','center','center',[200 100 100]);
    Screen('Flip', w);
    sample = Eyelink('NewestFloatSample');
    pd_cal(i) = sample.pa(eyeused);
    gazeX_cal(i) = sample.gx(eyeused);
    gazeY_cal(i) = sample.gy(eyeused);
    gazeX_cal(i)=gazeX_cal(i)-fix(1);
    gazeY_cal(i)=gazeY_cal(i)-fix(2);
    DrawFormattedText(w, 'X',gazeX_cal(i)-20,gazeY_cal(i)-30,[25 140 230]);
    Screen('Flip',w);
    if  KbCheck(mouseNum)
       Gaze(1,1:2)=[gazeX_cal(i),gazeY_cal(i)];
        break
    end
    WaitSecs(TIME_RES-(GetSecs -currStepTime)); %if every loop will be less than 0.01sec
end
j=i+1;
pause(1)
for i=j:2000
    currStepTime= GetSecs;
    if analog_type==1
    DrawFormattedText(w, '+',plusPlace1(1),plusPlace1(2),[200 100 100]);
    else
    DrawFormattedText(w, '+',plusPlace2(1),plusPlace2(2),[200 100 100]);
    end
    Screen('Flip', w);
    sample = Eyelink('NewestFloatSample');
    pd_cal(i) = sample.pa(eyeused);
    gazeX_cal(i) = sample.gx(eyeused);
    gazeY_cal(i) = sample.gy(eyeused);
    gazeX_cal(i)=gazeX_cal(i)-fix(1);
    gazeY_cal(i)=gazeY_cal(i)-fix(2);
    DrawFormattedText(w, 'X',gazeX_cal(i)-20,gazeY_cal(i)-30,[25 140 230]);
    Screen('Flip',w);
    if  KbCheck(mouseNum)
        Gaze(2,1:2)=[gazeX_cal(i),gazeY_cal(i)];
        break
    end
    WaitSecs(TIME_RES-(GetSecs -currStepTime)); %if every loop will be less than 0.01sec
end
j=i+1;
pause(1)
for i=j:3000
    currStepTime= GetSecs;
    if analog_type==1
    DrawFormattedText(w, '+',wW-plusPlace1(1),wH-plusPlace1(2),[200 100 100]);
    else
    DrawFormattedText(w, '+',wW-plusPlace2(1),wH-plusPlace2(2),[200 100 100]);
    end
    Screen('Flip', w);
    sample = Eyelink('NewestFloatSample');
    pd_cal(i) = sample.pa(eyeused);
    gazeX_cal(i) = sample.gx(eyeused);
    gazeY_cal(i) = sample.gy(eyeused);
    gazeX_cal(i)=gazeX_cal(i)-fix(1);
    gazeY_cal(i)=gazeY_cal(i)-fix(2);
    DrawFormattedText(w, 'X',gazeX_cal(i)-20,gazeY_cal(i)-30,[25 140 230]);
    Screen('Flip',w);
    if  KbCheck(mouseNum)
        Gaze(3,1:2)=[gazeX_cal(i),gazeY_cal(i)];
        break
    end
    WaitSecs(TIME_RES-(GetSecs -currStepTime)); %if every loop will be less than 0.01sec
end
Screen('FillRect', w, backgroundcolor);
Screen('Flip',w);
pause(2)

addfix=Gaze-pluses;
addfix=[mean(addfix(:,1)),mean(addfix(:,2))];
fix=fix+addfix;
end
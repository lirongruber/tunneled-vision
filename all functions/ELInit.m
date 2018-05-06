
function [a,b,eyeused]=ELInit(eyetracking,w,edfFile)
% initialize eyeLink!

a=0;
b=0;

    if eyetracking % Initialize eyelink recording
        status1=Eyelink('command','link_sample_data = LEFT,RIGHT,GAZE,AREA,GAZERES,HREF,PUPIL,STATUS,INPUT');%maybe is not needed every loop
        status2=Eyelink('OpenFile',edfFile);
        status3=Eyelink('startrecording' ); %start recording eye position
        eyeused = Eyelink('EyeAvailable');
        if eyeused==2
        else
            eyeused = eyeused+1;% returns 0 (LEFT_EYE), 1 (RIGHT_EYE) or 2 (BINOCULAR) depending on what data is
        end
        %available returns -1 if none available: +1 for matlab array
    else if eyetracking==0
            [a,b]=WindowCenter(w);
            %             SetMouse(a,b,screenNumber);
        end
    end
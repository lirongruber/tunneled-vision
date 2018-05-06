clear
clc
Datapixx('Open'); % Open Datapixx
t0 = Datapixx('getTime'); % Get initial time
Datapixx('RegWrRd')

% We are assuming that the DATAPixx is connected to the highest number screen.
% If it isn't, then assign screenNumber explicitly here.
screenNumber=max(Screen('Screens'));

% We use the imaging pipeline to open a window so that we can get microsecond accurate stimulus onset timetags
PsychImaging('PrepareConfiguration');
PsychImaging('AddTask', 'General', 'UseDataPixx');
[w, wRect] = PsychImaging('OpenWindow', 2, 0);

Screen('FillRect', w, [255 0 0], wRect); % GENERATE STIMULUS

Datapixx('RegWrRdVideoSync'); % UPDATE ON NEXT FRAME
Screen('Flip', w);

t_stim = Datapixx('GetTime') - t0; % GET TIME OF DISPLAY

Datapixx('RegWrRdVideoSync'); % TEST ANOTHER FRAME, TO MAKRE SURE.

Screen('Flip', w);

% !!!IF done here instead of before flip, Datapixx('RegWrRdVideoSync')
% !!!takes 2 frames, RegWrRdVideoSync must be **BEFORE** flip.

t_stim2 = Datapixx('GetTime') - t0;
one_flip_is_one_frame = (t_stim2 - t_stim) * 1000;
fprintf('Time of initial stim: %4.4f s,\n time of 2nd flip: %4.4f s,\n difference between the two %4.2f ms,\n(should be 16.67 at 60 Hz, 8.33 at 120 H', t_stim, t_stim2, one_flip_is_one_frame);



% Close on escape 
KbName('UnifyKeyNames');
escapeKey = KbName('ESCAPE');
while 1
 % Check the state of the keyboard.
    [ keyIsDown, seconds, keyCode ] = KbCheck;
 % If the user is pressing a key, then display its code number and name.
 if keyIsDown
 % Note that we use find(keyCode) because keyCode is an array.
 % See 'help KbCheck'
    fprintf('You pressed key %i which is %s\n', find(keyCode), KbName(keyCode));
 if keyCode(escapeKey)
    Screen('CloseAll')
    break;
 end
 
 % If the user holds down a key, KbCheck will report multiple events.
 % To condense multiple 'keyDown' events into a single event, we wait until all
 % keys have been released.
 end
end
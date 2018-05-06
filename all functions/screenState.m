
function  [screenTime]=screenState(w,wW,wH,imdata,imdatablur,masktex,newfoveaRect,myrect,wideSetup,video)%,t0)%t0 -for vpixx screen
screenTime=0; % not vpixx
%  preparing new screen state - where is the new fovea and what is it filled with.
% [w]=the screen.[ masktex]=transparency mask texture.[foveatex]=data texture. [nonfoveatex]=bleard data texture.
% [newfoveaRect]=the picture size in the center of the screen
% [myRect]=  the new fovea window according to the gaze
%flips screen
%see Psychtoolsbox Demo

dRect = ClipRect(myrect,newfoveaRect);
%sRect=OffsetRect(dRect, -dx, -dy); %not in use
if ~IsEmptyRect(dRect) % if the gaze is indeed somewhere on the picture
    y1=max(1,round(myrect(2))); y1=min(y1,wH);
    y2=max(1,round(myrect(4))); y2=min(y2,wH);
    x3=max(1,round(myrect(1))); x3=min(x3,wW);
    x4=max(1,round(myrect(3))); x4=min(x4,wW);
    
    currimdatablur=imdatablur(y1:y2,x3:x4);
  
    if wideSetup(3)~=0
        [currimdata, newX,newY]= smallPer(wH,wW,imdata, myrect,wideSetup);

         else
        currimdata=imdata(y1:y2,x3:x4);
        
    end
    % add the pyramid periphery option - calculating small imdata on both sides..
    
    % Fovea contains original image data and Periphery contains blurred-version:
    foveaimdata = currimdata;
    peripheryimdata = currimdatablur;
    
    % Build texture for foveated and peripheral region:
   foveatex=Screen('MakeTexture', w, foveaimdata);% JPEG to another
    %foveaRect=Screen('Rect', foveatex); % the picture size
    nonfoveatex=Screen('MakeTexture', w, peripheryimdata);
    
    % Step 1: Draw the alpha-mask into the backbuffer. It
    % defines the aperture for foveation: The center of gaze
    % has zero alpha value. Alpha values increase with distance from
    % center of gaze according to a gaussian function and
    % approach 255 at the border of the aperture...
    Screen('BlendFunction', w, GL_ONE, GL_ONE);
    Screen('DrawTexture', w, masktex, [], myrect);
    % %                 Screen('DrawTexture', w, masktex, [], OffsetRect(myrect, (ms/2), 0), 0, 0);
    
    % Step 2: Draw peripheral image. It is only drawn where
    % the alpha-value in the backbuffer is 255 or high, leaving
    % the foveated area (low or zero alpha values) alone:
    % This is done by weighting each color value of each pixel
    % with the corresponding alpha-value in the backbuffer
    % (GL_DST_ALPHA).
    Screen('BlendFunction', w, GL_DST_ALPHA, GL_ZERO);
    Screen('DrawTexture', w, foveatex, [], myrect);%newfoveaRect);
    
    % Step 3: Draw foveated image, but only where the
    % alpha-value in the backbuffer is zero or low: This is
    % done by weighting each color value with one minus the
    % corresponding alpha-value in the backbuffer
    % (GL_ONE_MINUS_DST_ALPHA).
    Screen('BlendFunction', w, GL_ONE_MINUS_DST_ALPHA, GL_ONE);
    Screen('DrawTexture', w, nonfoveatex, [], myrect);%newfoveaRect);
    %Screen('FillRect', w, [128 128 128], newfoveaRect);
%    screen('DrawingFinished', w);

% %% temp - screen timimg
% Datapixx('RegWrRdVideoSync'); % UPDATE ON NEXT FRAME
% %%
%for video recordings:
if video==1
    Screen('AddFrameToMovie', w, CenterRect([0 0 wW wH], Screen('Rect', 2)), 'backBuffer');
end
%

Screen('Flip', w,0,0,0);
% %% temp - screen timimg
% screenTime = Datapixx('GetTime') - t0; % GET TIME OF DISPLAY
% %% 

else
%     %% temp - screen timimg
%     screenTime = 10; % GET TIME OF DISPLAY
%     %%
end


end




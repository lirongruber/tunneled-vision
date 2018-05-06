
function [ myrect]=changeScreen(imdata,imdatablur,masktex,practice,small_star,motor_task,memory_exp,wideSetup,video,w,wW,wH,screenNumber,nonfoveatex,newfoveaRect,backgroundcolor,ms,oldx,oldy,currx,curry,i,currStepTime,low_con_control)
% this function sets the next 'screen' using 'screenState'
myrect=[];
% We only redraw if gazepos. has changed:
if practice==1 || memory_exp==1 || memory_exp==2
    Screen('BlendFunction', w, GL_ONE, GL_ZERO);
    Screen('DrawTexture', w, nonfoveatex, [], newfoveaRect);
    if small_star==1
        if motor_task==1
            if wideSetup(1)==1
                myrect=[currx-(ms/(1+1/wideSetup(2))) curry-(ms/(1+wideSetup(2))) currx+(ms/(1+1/wideSetup(2)))+1 curry+(ms/(1+wideSetup(2)))+1]; % center dRect on current position
            else
                myrect=[currx-(ms/2) curry-(ms/2) currx+(ms/2)+1 curry+(ms/2)+1]; % center dRect on current position
            end
            %         y1=max(1,round(myrect(2))); y1=min(y1,wH);
            %         y2=max(1,round(myrect(4))); y2=min(y2,wH);
            %         x3=max(1,round(myrect(1))); x3=min(x3,wW);
            %         x4=max(1,round(myrect(3))); x4=min(x4,wW);
            %         smallimdata=imdata(y1:y2,x3:x4);
            %         smallimdata(1,:)=255;  smallimdata(:,1)=255;
            %         s=size(smallimdata);
            %         smallimdata(:,s(2))=255;  smallimdata((s(1)),:)=255;
            %         currimdata=imdata;
            %         currimdata(y1:y2,x3:x4)=smallimdata;
            %         currimdata=Screen('MakeTexture', w, currimdata);
            %         dataRect=Screen('Rect', currimdata); % the mask size....
            %         Screen('DrawTexture', w, currimdata, [], dataRect);
            Screen('TextSize',w,12);
            if low_con_control==0 
            DrawFormattedText(w, '[ ]',currx-15,curry-5,[255 255 255], 10,1,1,0);
            end
        else
            DrawFormattedText(w, '.',currx-20,curry-45,[25 140 230]);
        end
    else
        DrawFormattedText(w, 'X',currx-20,curry-30,[25 140 230]);
    end
    %  screen('DrawingFinished', w);
    Screen('Flip',w);
    
else
    if (currx~=oldx || curry~=oldy) % and maybe something with velocity or length
        % Compute position and size of source- and destination rect and
        % clip it, if necessary...
        if wideSetup(1)==1
            myrect=[currx-(ms/(1+1/wideSetup(2))) curry-(ms/(1+wideSetup(2))) currx+(ms/(1+1/wideSetup(2)))+1 curry+(ms/(1+wideSetup(2)))+1]; % center dRect on current position
        else
            myrect=[currx-(ms/2) curry-(ms/2) currx+(ms/2)+1 curry+(ms/2)+1]; % center dRect on current position
        end
        %  preparing new screen state
        [screenTime]=screenState(w,wW,wH,imdata,imdatablur,masktex,newfoveaRect,myrect,wideSetup,video);%,t0);% t0 -for vpixx screen
        scTime(i)=screenTime;
        csTime(i)=GetSecs -currStepTime;
    else
        Screen('BlendFunction', w, GL_ONE, GL_ZERO);
        Screen('FillRect', w, [backgroundcolor backgroundcolor backgroundcolor 0 ]);
        %screen('DrawingFinished', w);
        %for video recordings:
        if video==1
            Screen('AddFrameToMovie', w, CenterRect([0 0 wW wH], Screen('Rect', screenNumber)), 'backBuffer');
        end
        %
        oldvbl=Screen('Flip', w);
    end
end

end
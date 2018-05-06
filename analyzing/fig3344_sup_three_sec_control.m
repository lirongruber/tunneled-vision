% controling for 3 first seconds in tunneledc trials....
% figure 66 -"sup"
% clear
% close all
figure(3344)
ha3344=tight_subplot(4, 6,[.1 .04],[.1 .1],[.1 .1]);
% what sub data do I want?
shape='all'; % 'all' 'circle' 'parallelog' 'square' 'triangle' 'rectangle'
session='all'; % 'all' '1';
trial='all';% 'all' '1.mat';
coreectORwrong='c'; %'all' 'c' 'w';
cal=0;

%general parameters:
res=0.01;% 0.01 sec
screen_dis=1;% meter
PIXEL2METER=0.000264583;
doPlot=0; %for sacDiffAmos
analogs={'NB','B', 'NS','S'};
kindaBlue=[0 .45 .7];
kindaBlue2=[.35 .7 .9];
kindaMag=[.8 .4 0];
kindaMag2=[.8 .6 .7];
colors={kindaBlue,kindaMag, kindaBlue2 ,kindaMag2};
colors={'k','b', 'k' ,'m'};

figure(3344)
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
for analog_i=1:4
    disp(analog_i)
    driftVel_perType=[];
    driftDur_perType=[];
    saccRate_perType=[];
    
    analog=analogs{1,analog_i};
    nameOfFile=[shape 'Shape' analog 'Analog' session 'Session' trial 'Trial' coreectORwrong 'Answer'];
    nameOfFile(regexp(nameOfFile,'[.]'))=[];
    if strcmp(analog,'B') || strcmp(analog,'NB')
        analogType='B';
    else if strcmp(analog,'S') || strcmp(analog,'NS')
            analogType='S';
        end
    end
    
    sub_i=0;
    for subjects= {'SM','LS','LB','RW','AS'} %,'LB','LS' ,'AS' ,'RW','SM'
        sub_i=sub_i+1;
        disp(sub_i)
        saccRate=[];
        t=0;
        labeled_saccade_vecs={};
        f=fullfile('C:\Users\bnapp\Documents\tunnelledVisionPaper\analyzing\cleanedData\', subjects);
        files = dir(f{1,1});
        for file = files'
            if strcmp(file.name,'.')==0 && strcmp(file.name,'..')==0
                currFile = load(file.name);
                % shape
                if  strcmp(shape,'all')==1 || strcmp(currFile.myimgfiles{1,1}{1,1},shape)
                    % correct\wrong only
                    if  strcmp(coreectORwrong,'all')==1 || ((strcmp(coreectORwrong,'c') && max(currFile.iscorrects{1,1})==1 ) || (strcmp(coreectORwrong,'w') && max(currFile.iscorrects{1,1})==0 ))
                        % analog type
                        if  strcmp(analog,'all')==1 || strcmp(file.name(4),analog(1))
                            if  length(analog)==2
                                if strcmp(analogType,'B')
                                    session=[1,3];
                                else if strcmp(analogType,'S')
                                        session=[2,4];
                                    end
                                end
                            end
                            % session number
                            if  strcmp(session,'all')==1 || strcmp(file.name(5),num2str(session(1))) || strcmp(file.name(5),num2str(session(2)))
                                % trial number
                                if  strcmp(trial,'all')==1 || strcmp(file.name(7:end),trial)
                                    
                                    %here come the main analysis:
                                    fileName=file.name(1:5);
                                    sessionNum=str2num(file.name(7:length(file.name)-4));
                                    picName=shape; %'circle' 'triangle' etc
                                    [imdatas,chan_h_pix,chan_v_pix,chan_h, chan_v,saccade_vec, ~] =sacDiffAmos(cal,fileName,sessionNum,picName,doPlot);
                                    
                                    if ~isempty(find(saccade_vec{1,1}))
                                        
                                        [row ,col]=find(saccade_vec{1,1});
                                        last=col(end);
                                        saccade_vec=saccade_vec{1,1}(:,1:last);
                                        XY_vec_pix=[chan_h_pix;chan_v_pix];
                                        XY_vec_deg=[chan_h;chan_v];
                                        imdata=imdatas{1};

                                            
                                            % 5. saccades - row 4(BIG)
                                            [labeled_saccade_vec,sacc_time_ms,sacc_amp_degrees,sacc_vel_deg2sec,sacc_maxvel_deg2sec]=typeOfSaccade(saccade_vec,XY_vec_pix,XY_vec_deg,imdata,res,analogType);                                        % 6. drifts -  row 5
                                            [labeled_saccade_vec,drift_time_ms,drift_dist_degrees,drift_amp_degrees,drift_vel_deg2sec]=drifts(labeled_saccade_vec,XY_vec_deg,XY_vec_pix,res,imdata,analogType);
                                            
                                            % saving only strait border drifts:
                                            if  size(labeled_saccade_vec,2)>2 && size(labeled_saccade_vec,1)>9
                                                t=t+1;
                                                figure(3344)
                                                axes(ha3344(sub_i+6*floor(analog_i/3)))
                                                plot(drift_time_ms(drift_time_ms~=0),drift_vel_deg2sec(drift_time_ms~=0),'.', 'color',colors{analog_i})
                                                hold all
                                                title(subjects)
                                                axis([0 2000 0 20])
                                                
                                                driftVel_perType=[driftVel_perType drift_vel_deg2sec(drift_time_ms~=0) ];
                                                driftDur_perType=[driftDur_perType drift_time_ms(drift_time_ms~=0) ];
                                                
                                                saccRate(t)=size(labeled_saccade_vec,2)/(size(XY_vec_pix,2))*100;
                                                
                                            end
                                    end
                                end
                            end
                        end
                    end
                end
                
            end
            
        end
            
        axes(ha3344(12+sub_i))
        errorbar(analog_i,mean(saccRate),ste(saccRate),'.', 'color',colors{analog_i})
        hold all
        axis([0 5 0 8])
        
            saccRate_perType=[saccRate_perType saccRate];
            
    end
        axes(ha3344(6+6*floor(analog_i/3)))
        plot(driftDur_perType,driftVel_perType,'.', 'color',colors{analog_i});
        hold all
        Var(analog_i)=var(driftVel_perType(driftDur_perType<500));
        
        var_temp=driftVel_perType(driftDur_perType<500);
        S=size(var_temp,2);
        S=floor(S/5);
        varsT=[var(var_temp(1:S)) var(var_temp(S+1:2*S)) var(var_temp(2*S+1:3*S)) var(var_temp(3*S+1:4*S)) var(var_temp(4*S+1:end))];
        STE(analog_i)=round(ste(varsT),1);

        alldriftDur{analog_i}=driftDur_perType;
        alldriftVel{analog_i}=driftVel_perType;
        
        axes(ha3344(18))
        errorbar(analog_i,mean(saccRate_perType),ste(saccRate_perType),'.', 'color',colors{analog_i})
        hold all
        axis([0 5 0 8])
        text(analog_i,analog_i+3,[num2str(round(mean(saccRate_perType),2)) '+-' num2str(round(ste(saccRate_perType),2))],'FontSize',10);
        ylabel('Sacc rate[/sec]','FontSize', 20)
%         title('ALL')
        allsaccRate{analog_i}=saccRate_perType;
end
    axes(ha3344(6))
    legend(['v(<500)=' num2str(round(Var(1),1)) '+-' num2str(STE(1))],['v(<500)=' num2str(round(Var(2),1))  '+-' num2str(STE(2))])
    axis([0 2000 0 20])
    title('ALL','FontSize', 25)
    xlabel('Duration[ms]','FontSize', 20)
    ylabel('Vel[deg/sec]','FontSize', 20)
    axes(ha3344(12))
    legend(['v(<500)=' num2str(round(Var(3),1))  '+-' num2str(STE(3))],['v(<500)=' num2str(round(Var(4),1))  '+-' num2str(STE(4))])
    axis([0 2000 0 20])
    xlabel('Duration[ms]','FontSize', 20)
    ylabel('Vel[deg/sec]','FontSize', 20)
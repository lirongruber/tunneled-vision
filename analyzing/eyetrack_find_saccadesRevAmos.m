function [saccade_vec, n] = eyetrack_find_saccadesRevAmos( chan_h, chan_v, rate, eyetrack_menu_parameters, amp_min, amp_max)

% Parameters & Initialization
debugFlg =  0; % 1 if to display (for debugging) stages of Saccade detection
if (amp_min == 0.0) || (amp_min == 0.0),
    amp_min = eyetrack_menu_parameters.saccademinamp;
    amp_max = eyetrack_menu_parameters.saccademaxamp;
end
samp_angle_threshold = 30.0; % maximun angle within saccades (in degrees)
intrussion_angle_threshold = 90.0; % mimimum change in direction for saccadic-intrussion.
saccade_min_duration = 2.0;   % in milliseconds
overshoot_max_duration = 30;    % in milliseconds
saccade_vec = zeros(3, fix(length(chan_h)*10/rate));    % max number of saccades = 10/s

minimum_velocity = eyetrack_menu_parameters.minimumvelocity/rate;
average_velocity = eyetrack_menu_parameters.averagevelocity/rate;
peak_velocity = eyetrack_menu_parameters.peakvelocity/rate;
saccade_min_samp = fix( saccade_min_duration*rate/1000);
% overshoot_max_samp = fix( overshoot_max_duration*rate/1000);
overshoot_max_gap = fix( 10*rate/1000);
overshoot_amp_min = 0.5*amp_min; % smaller minimal amplitude for overshoot
intrussion_max_gap = fix( eyetrack_menu_parameters.intrussionrange*rate/1000);

chan_h_flg = 1; % there is data in chan_h
chan_v_flg = 1; % there is data in chan_v
if(min(chan_h) == max(chan_h)), chan_h_flg = 0; end
if(min(chan_v) == max(chan_v)), chan_v_flg = 0; end

% Low pass Filter data: low-pass (120Hz), filter-order = 4
FilterFlg = 1;
highPass_chan_h = double(chan_h);
highPass_chan_v = double(chan_v);
sFiltertype = 'Lowpass';
filter_order = 4; % filter order
filter_cutoff = 120; % low pass < 120Hz
filter_cutoff = 200; % low pass < 120Hz
if(FilterFlg == 1),
    switch sFiltertype;
        case 'Lowpass'
            if filter_cutoff<rate
                [b, a] = butter( filter_order, filter_cutoff/(rate/2),'low' );
                if(chan_h_flg == 1), highPass_chan_h = filtfilt(b, a,double(chan_h)); end
                if(chan_v_flg == 1), highPass_chan_v = filtfilt(b, a,double(chan_v)); end
            end
        case 'Highpass'
            [b, a] = butter(filter_order, filter_cutoff/(rate/2),'high' );
            % case 'Bandpass'
            %     filter_cutoff(1) = str2double(get(handles.lowercutoffedit,'String'));
            %     filter_cutoff(2) = str2double(get(handles.uppercutoffedit,'String'));
            %     [b, a] = butter(filter_order, filter_cutoff./(rate/2));
    end
end



% Tangental Velocity & angel
dif_h = diff( highPass_chan_h);
dif_v = diff( highPass_chan_v);
sample_vec = sqrt(dif_h.^2 + dif_v.^2);
ang_dif_vec = abs(diff(atan2( dif_v, dif_h))) .* 180/pi;

% Saccade detection
i = 1; % index for current sample number [ 1<= i < length(highPass_chan_h-1) ]
n = 0; % last saccade

while i < length(highPass_chan_h) - 2
    if sample_vec(i) < minimum_velocity % below thereshold for minimal velocity
        i = i + 1;
        continue;
    else  % above thereshold for minimal velocity
        j = 0;
        while j < length(highPass_chan_h) - i - 2
            
            % Display (for debugging) stages of Saccade detection
            if(debugFlg == 1 && j == 0), % 1 if to display (for debugging) stages of Saccade detection
                figure(5); clf;
                IndDBGbgn = i - 50; if(IndDBGbgn < 1), IndDBGbgn = 1; end
                IndDBGend = i + 50; if(IndDBGend > length(highPass_chan_h)-1), IndDBGend = length(highPass_chan_h)-1; end
                axDBG(1) = IndDBGbgn/rate;
                axDBG(2) = IndDBGend/rate;
                if(chan_h_flg == 1),
                    if(chan_v_flg == 1), subplot(2,1,1); end
                    plot((IndDBGbgn:IndDBGend)/rate,highPass_chan_h(IndDBGbgn:IndDBGend),'k','LineWidth',1.5);
                    hold on;
                    plot(i/rate,highPass_chan_h(i),'c*','Markersize',10,'LineWidth',2);
                    MinYaxDBG = min(highPass_chan_h(IndDBGbgn:IndDBGend));
                    MaxYaxDBG = max(highPass_chan_h(IndDBGbgn:IndDBGend));
                    axDBG(3) =  MinYaxDBG - 0.1*(MaxYaxDBG - MinYaxDBG);
                    axDBG(4) =  MaxYaxDBG + 0.1*(MaxYaxDBG - MinYaxDBG);
                    axis(axDBG);
                    title(sprintf('Horizontal SC(%i)',i));
                end
                 if(chan_v_flg == 1),
                    if(chan_h_flg == 1), subplot(2,1,2); end
                    plot((IndDBGbgn:IndDBGend)/rate,highPass_chan_v(IndDBGbgn:IndDBGend),'k','LineWidth',1.5);
                    hold on;
                    plot(i/rate,highPass_chan_v(i),'c*','Markersize',10,'LineWidth',2);
                    MinYaxDBG = min(highPass_chan_v(IndDBGbgn:IndDBGend));
                    MaxYaxDBG = max(highPass_chan_v(IndDBGbgn:IndDBGend));
                    axDBG(3) =  MinYaxDBG - 0.1*(MaxYaxDBG - MinYaxDBG);
                    axDBG(4) =  MaxYaxDBG + 0.1*(MaxYaxDBG - MinYaxDBG);
                    axis(axDBG);
                    title(sprintf('Vertical SC(%i)',i));
                 end
                
                figure(6); clf;
                plot((IndDBGbgn:IndDBGend)/rate,ang_dif_vec(IndDBGbgn:IndDBGend),'k','LineWidth',1.5);
                hold on;
                plot(i/rate,ang_dif_vec(i),'c*','Markersize',10,'LineWidth',2);
                MinYaxDBG = min(ang_dif_vec(IndDBGbgn:IndDBGend));
                MaxYaxDBG = max(ang_dif_vec(IndDBGbgn:IndDBGend));
                axDBG(3) =  MinYaxDBG - 0.1*(MaxYaxDBG - MinYaxDBG);
                axDBG(4) =  MaxYaxDBG + 0.1*(MaxYaxDBG - MinYaxDBG);
                axis(axDBG);
                title(sprintf('Angle dif(%i)',i));

            end
            
            ang_dif = ang_dif_vec(i+j);
            j = j + 1;
            if(debugFlg == 1), % 1 if to display (for debugging) stages of Saccade detection
                figure(5)
                try delete(h1); end
                h1 = plot((i+j)/rate,highPass_chan_h(i+j),'r.','Markersize',12,'LineWidth',2);
                figure(6);
                try delete(h2); end
                h2 = plot((i+j)/rate,ang_dif_vec(i+j),'r.','Markersize',12,'LineWidth',2);
            end
            
            if (((ang_dif < samp_angle_threshold) || (ang_dif > (360-samp_angle_threshold))) &&...
                    (sample_vec(i+j) > minimum_velocity))
                continue;
            else
                if(debugFlg == 1), % 1 if to display (for debugging) stages of Saccade detection
                    figure(5);
                    if(chan_h_flg == 1),
                        if(chan_v_flg == 1), subplot(2,1,1); end;
                        try delete(h1); end
                        plot((i+j)/rate,highPass_chan_h(i+j),'m+','Markersize',10,'LineWidth',2);
                    end
                    if(chan_v_flg == 1),
                        if(chan_h_flg == 1), subplot(2,1,2); end;
                        plot((i+j)/rate,highPass_chan_v(i+j),'m+','Markersize',10,'LineWidth',2);
                    end
                    figure(6);
                    try delete(h2); end
                    plot((i+j)/rate,ang_dif_vec(i+j),'m+','Markersize',10,'LineWidth',2);
                end
                
                saccade_amp = sqrt((highPass_chan_h(i+j)-highPass_chan_h(i))^2 + (highPass_chan_v(i+j)-highPass_chan_v(i))^2);
                % if (saccade_amp > amp_min) && (saccade_amp < amp_max)  && (max(sample_vec(i:i+j)) > peak_velocity) && ...
                %         (mean(sample_vec(i:i+j)) > average_velocity) && (j > saccade_min_samp) &&...
                %         (saccade_amp/(max(sample_vec(i:i+j))*rate) > 0.001) && (saccade_amp/(max(sample_vec(i:i+j))*rate) < 10.6)
                SCok = 0; % 1 - if SC
                if (n > 0 && (i - (saccade_vec(1,n) + saccade_vec(2,n)) < overshoot_max_gap)), % smaller minimal amplitude for overshoot
                    if (saccade_amp > overshoot_amp_min) && (saccade_amp < amp_max)  && (max(sample_vec(i:i+j)) > peak_velocity) && ...
                            (j > saccade_min_samp) && (saccade_amp/(max(sample_vec(i:i+j))*rate) > 0.001) && ...
                            (saccade_amp/(max(sample_vec(i:i+j))*rate) < 10.6),
                        SCok = 1; % 1 - if SC
                    end
                else
                    if (saccade_amp > amp_min) && (saccade_amp < amp_max)  && (max(sample_vec(i:i+j)) > peak_velocity) && ...
                            (j > saccade_min_samp) && (saccade_amp/(max(sample_vec(i:i+j))*rate) > 0.001) && ...
                            (saccade_amp/(max(sample_vec(i:i+j))*rate) < 10.6)
                        SCok = 1; % 1 - if SC
                    end
                end
                
                % update for merge overshoot
                if(SCok == 1), % 1 - if SC
                    if n > 0
                        if ((eyetrack_menu_parameters.mergeovershoot || eyetrack_menu_parameters.mergeintrussions)  && ...
                                (i - (saccade_vec(1,n) + saccade_vec(2,n)) < overshoot_max_gap)),
                            saccade_vec(2,n) = i - saccade_vec(1,n) + j;
                            
                            if(debugFlg == 1), % 1 if to display (for debugging) stages of Saccade detection
                                ii = saccade_vec(1,n); jj = saccade_vec(2,n);
                                figure(5);
                                if(chan_h_flg == 1),
                                    if(chan_v_flg == 1), subplot(2,1,1); end;
                                    plot((ii:ii+jj)/rate,highPass_chan_h(ii:ii+jj),'r','LineWidth',2);
                                end
                                if(chan_v_flg == 1),
                                    if(chan_h_flg == 1), subplot(2,1,2); end;
                                    plot((ii:ii+jj)/rate,highPass_chan_v(ii:ii+jj),'r','LineWidth',2);
                                end
                                figure(6);
                                plot((ii:ii+jj)/rate,ang_dif_vec(ii:ii+jj),'r','LineWidth',2);
                                % keyboard;
                            end
                            
                             % Examine saccadic intrussion
                        else
                            saccade_ang_diff = abs((atan2( dif_v(saccade_vec(1,n)), dif_h(saccade_vec(1,n))) - atan2( dif_v(i), dif_h(i)))) * 180/pi;
                            if eyetrack_menu_parameters.mergeintrussions && (i < (saccade_vec(1,n) + intrussion_max_gap)) && (saccade_ang_diff > intrussion_angle_threshold)
                                saccade_vec(2,n) = i - saccade_vec(1,n) + j;
                                if saccade_vec(3,n) < 5
                                    saccade_vec(3,n) = saccade_vec(3,n) + 1;  % Increase SI phase count.
                                end
                                
                                % define saccade
                            else
                                n = n + 1;
                                saccade_vec(:,n) = [i j 1]';
                                
                                if(debugFlg == 1), % 1 if to display (for debugging) stages of Saccade detection
                                    figure(5);
                                    if(chan_h_flg == 1),
                                        if(chan_v_flg == 1), subplot(2,1,1); end;
                                        plot((i:i+j)/rate,highPass_chan_h(i:i+j),'r','LineWidth',2);
                                    end;
                                    if(chan_v_flg == 1),
                                        if(chan_h_flg == 1), subplot(2,1,2); end;
                                        plot((i:i+j)/rate,highPass_chan_v(i:i+j),'r','LineWidth',2);
                                    end;
                                    figure(6);
                                    try delete(h2); end;
                                    plot((i:i+j)/rate,ang_dif_vec(i:i+j),'r','LineWidth',2);
                                    % keyboard;
                                end
                                
                            end
                        end
                    else
                        n = n + 1;
                        saccade_vec(:,n) = [i j 1]';
                        
                        if(debugFlg == 1), % 1 if to display (for debugging) stages of Saccade detection
                            figure(5);
                            if(chan_h_flg == 1),
                                if(chan_v_flg == 1), subplot(2,1,1); end;
                                plot((i:i+j)/rate,highPass_chan_h(i:i+j),'r','LineWidth',2);
                            end;
                            if(chan_v_flg == 1),
                                if(chan_h_flg == 1), subplot(2,1,2); end;
                                plot((i:i+j)/rate,highPass_chan_v(i:i+j),'r','LineWidth',2);
                            end;
                            figure(6);
                            plot((i:i+j)/rate,ang_dif_vec(i:i+j),'r','LineWidth',2);
                            % keyboard;
                        end
                        
                    end
                end
                break;
            end;
        end;
        i = i + j;
        if(debugFlg == 1), keyboard; end
    end
end


end


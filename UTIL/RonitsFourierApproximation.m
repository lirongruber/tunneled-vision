function [fr_x,fr_y,rseqr] = RonitsFourierApproximation(t,x_noisy,y_noisy,n)
%--------------------------------------------------------------------------
% The function approximates the curve with fourier transform for every
% coordinate separately.
% Input:
%   t                 :   The time samples of the points of r_noisy
%   (x_noisy,y_noisy) :   The (x,y) cordinates of the path with noise
%   n                 :   the order of the polynomial. n <=8, optional.
%                         Default = 8;
% Output:
%--------------------------------------------------------------------------
%Decleration of constants

%Decleration of arriass
r_dots  = [];
s       = zeros(1,length(t));

if ~exist('n','var')
    n = 8;
end

%Chake r_noisy. Make shore that evey row represent a dimention.
if (size(x_noisy,1)>size(x_noisy,2))
    x_noisy=x_noisy';
end
if (size(y_noisy,1)>size(y_noisy,2))
    y_noisy     = y_noisy';
end
if (size(t,1)>1),t = t';end

r_approx        = zeros(size(x_noisy,1),2);

%----------------------------------------------------------------------
% Fine aproximation to the path with first 8 coefitions of furier
% transfortm for x and y apart.
%----------------------------------------------------------------------

switch n
    case 8
        % Approxiamt the X cordinat 
        if exist('x_noisy','var') && ~isempty(x_noisy)
            [fr_x,gof_x]    = fit(t',x_noisy','fourier8','StartPoint',[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.9]);       
            best_fr         = fr_x;
            best_gof        = gof_x;
            w               = 0;
            while best_gof.rsquare < 0.9 && w ~= 7
                w           = w+0.5;
                [fr_x,gof_x]=fit(t',x_noisy','fourier8','StartPoint',[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,w]);       
                if gof_x.rsquare > best_gof.rsquare
                    best_fr       = fr_x;
                    best_gof      = gof_x;
                end
            end
            fr_x    = best_fr;
            gof_x   = best_gof;
        else
            fr_x = []; gof_x.rsquare = 0;
        end

        if exist('y_noisy','var') && ~isempty(y_noisy)
            % Approxiamt the Y cordinat 
            [fr_y,gof_y]=fit(t',y_noisy','fourier8','StartPoint',[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.8]);        
            best_fr         = fr_y;
            best_gof        = gof_y;
            w=0;
            while gof_y.rsquare<0.9 && w~=7
                w=w+0.5;
                [fr_y,gof_y]=fit(t',y_noisy','fourier8','StartPoint',[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,w]);        
                if gof_y.rsquare > best_gof.rsquare
                    best_fr       = fr_y;
                    best_gof      = gof_y;
                end
            end
            fr_y    = best_fr;
            gof_y   = best_gof;
        else
            fr_y = []; gof_y.rsquare = 0;
        end
    case 4
        % Approxiamt the X cordinat 
        if exist('x_noisy','var') && ~isempty(x_noisy)
            [fr_x,gof_x]    = fit(t',x_noisy','fourier4','StartPoint',[0,0,0,0,0,0,0,0,0,0.9]);       
            best_fr         = fr_x;
            best_gof        = gof_x;
            w=0;
            while best_gof.rsquare<0.98 && w~=7
                w=w+0.5;
                [fr_x,gof_x]=fit(t',x_noisy','fourier4','StartPoint',[0,0,0,0,0,0,0,0,0,w]);       
                if gof_x.rsquare > best_gof.rsquare
                    best_fr       = fr_x;
                    best_gof      = gof_x;
                end
            end
            fr_x    = best_fr;
            gof_x   = best_gof;
        else
            fr_x = []; gof_x.rsquare = 0;
        end
        
        if exist('y_noisy', 'var') && ~isempty(y_noisy)
            % Approxiamt the Y cordinat 
            [fr_y,gof_y]=fit(t',y_noisy','fourier4','StartPoint',[0,0,0,0,0,0,0,0,0,0.8]);        
            best_fr         = fr_y;
            best_gof        = gof_y;
            w=0;
            while gof_y.rsquare<0.9 && w~=7
                w=w+0.5;
                [fr_y,gof_y]=fit(t',y_noisy','fourier4','StartPoint',[0,0,0,0,0,0,0,0,0,w]);        
                if gof_y.rsquare > best_gof.rsquare
                    best_fr       = fr_y;
                    best_gof      = gof_y;
                end
            end
        fr_y    = best_fr;
        gof_y   = best_gof;
        else
            fr_y = []; gof_y.rsquare = 0;
        end
end
rseqr=[gof_x.rsquare,gof_y.rsquare];

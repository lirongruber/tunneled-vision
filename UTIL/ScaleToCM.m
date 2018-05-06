% Creates a curve at cm's instead of tablet Data
% assuming data was taken when the tablet is on the left of the screen

% For interpertation of the Data, multiply results:
% Each 512*994 pixels in the output data is 1*1 c"m.
% And Y is inversed.
% The center is  [32416 16098]
% X borders are [21588 43244] Y borders are [0 32195].

% These factors may change on another computer or in different setting,
% such as working with a single screen.
function [mCM] = ScaleToCM(m,exp)
if ~exist('exp','var')
    'in loop'
    exp= 'exp3';
end
switch lower(exp)
    case 'exp3'
        Yinv = [1 0 ; 0 -1];
        CENTER = [32416  0 ; 0 16098];
        SCALE = [512 0 ; 0 994]^(-1);
        CENTERM = ones(size(m)) * CENTER;
        mCM = (m-CENTERM)*SCALE*Yinv;
    case {'exp5','exp7'}
       
        % FOR CONVERSION TO CMs
        pixelCenter = [10933 0 ;  0 16098];
        scaleToCM = [0.002 0; 0 0.001];
        centerMatrix = ones(length(m),2) * pixelCenter;
        mCM = ( m - centerMatrix ) * scaleToCM;
        
    otherwise
end
end

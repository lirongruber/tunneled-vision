% GetGainFactor - calculate a single gain factor of a curve
% Input:
% m a smoothed curve
% method - 'meanstupid' - mean(v k^(1/3) ), 
%          'yarons' -  
%          'meaneav' - mean of equi affine velocity over the curve
%          'deladelt' - area/duration
%
% This file calculates a gain factor for a segment of a curve, isn't built
% to handle inflection points!!!
function [gainFactor,mse] = GetGainFactor(m,method)
SAMPLINGRATE = 1/146;

switch lower(method)
    case 'meanstupid'
        v = EUVelocity(m);
        v = v(1:end-1);
        
        k = EUCurvature(m);
        
        gainFactor = mean(v.*k.^(1/3));
        mse = nan;
        
    case 'yarons'
        d = diff(m);
        s = sum(cross(d(1:end-1,:),d(2:end,:)).^2,2).^0.5;
        eas = s.^(1/3);
        dt = 1/146;
        gainFactor = eas./dt;
        
    case 'meaneav'
        eav = EAVelocity(m);
        gainFactor = mean(eav);
        
    case 'deladelt'
        area = CalcAreaC(m);
        T = length(m)* SAMPLINGRATE;
        gainFactor = area^(1/3)/T;
        
    otherwise
        warning('bad method')
        gainFactor = nan;
        mse = nan;
end
end
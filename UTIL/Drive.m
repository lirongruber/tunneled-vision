% function drive
%
% input:
% m - smoothed curve
% method - 'normal',
%
% output:
% drv is the drive, a vector of length length(m)
% cdrv is the constrained drive, a vector of length length(m)
function [drv,drvC] = Drive(m,method,SAMPLINGRATE)
if ~exist('SAMPLINGRATE','var')
    SAMPLINGRATE = 1/146;
end

x = m(:,1);
y = m(:,2);
size(x)

% X
dd1 = deriv(x)./SAMPLINGRATE;
dd2 = deriv(dd1)./SAMPLINGRATE;
dd3 = deriv(dd2)./SAMPLINGRATE;
dd4 = deriv(dd3)./SAMPLINGRATE;
dd5 = deriv(dd4)./SAMPLINGRATE;

cutlen = length(dd5)-10;

d1x = dd1(1:cutlen,:);
d2x = dd2(1:cutlen,:);
d3x = dd3(1:cutlen,:);
d4x = dd4(1:cutlen,:);
d5x = dd5(1:cutlen,:);

% Y
dd1 = deriv(y)./SAMPLINGRATE;
dd2 = deriv(dd1)./SAMPLINGRATE;
dd3 = deriv(dd2)./SAMPLINGRATE;
dd4 = deriv(dd3)./SAMPLINGRATE;
dd5 = deriv(dd4)./SAMPLINGRATE;

d1y = dd1(1:cutlen,:);
d2y = dd2(1:cutlen,:);
d3y = dd3(1:cutlen,:);
d4y = dd4(1:cutlen,:);
d5y = dd5(1:cutlen,:);

[~,~,s] = EULength(m);
s1 = (d1x.^2 + d1y.^2).^(1/2);
s2 = (d2x.^2 + d2y.^2).^(1/2);
s3 = (d3x.^2 + d3y.^2).^(1/2);
s4 = (d4x.^2 + d4y.^2).^(1/2);
s5 = (d5x.^2 + d5y.^2).^(1/2);

[~,k] = EUCurvature(m);
[ks,kss] = EUCurvatureDerivative(m);

k = k(1:cutlen,:);
ks = ks(1:cutlen,:);
kss = kss(1:cutlen,:);

switch method
    %     case 'polynom5'
    %         if length(m)~= 6
    %             warning('with method polynom5 m should be the coefficients vectors')
    %         end
    %
    
    case 'constrained'
        % the constrained jerk includes an expression of the curvatures
        % additional to the standard drive
%         size(k)
%         size(ks)
%         size(kss)
%         size(s1)
%         size(s2)
%         size(s3)
%         size(s4)
%         size(s5)
%         size(s6)
        
        drv = (-5).*(k.^4 - ks.^2 -2.*k.*kss).*s1.^6 ...
            +60.* k.*ks.*s1.^4.*s2 ...
            +15.*k.^2.* s1.^2.*s2.^2 ...
            +30.*k.^2.* s1.^3.*s3 ...
            -s3.^2 + 2.*s2.*s4 -2.*s1.*s5; % drive for the 1D case - 
        % XXX - this is NOT the normal drive in the 2D case, because there
        % is a difference between s.s which is a scalar than q.q the dot
        % product in the 2D case!!! think about it.
       
    case 'normal'
        
        
%         drvC = -s3.^2 + 2.*s2.*s4 -2.*s1.*s5;

        drvC = (-5).*(k.^4 - ks.^2 -2.*k.*kss).*s1.^6 ...
            +60.* k.*ks.*s1.^4.*s2 ...
            +15.*k.^2.* s1.^2.*s2.^2 ...
            +30.*k.^2.* s1.^3.*s3 ...
            -s3.^2 + 2.*s2.*s4 -2.*s1.*s5;


        
        drv = d3x.*d3x - 2 .*d4x.*d2x  +2.*d5x.*d1x + d3y.*d3y - 2 .*d4y.*d2y  +2.*d5y.*d1y;
        
%         % verifying the result is the same!
%         figure
%         hold all
%         plot(drv,'.b') 
%         plot(drvC,'.r')
        
    case 'average' 
        % returning a square matrix calculating the drive in different segments.
        % corrsponding to indices of start and end
        %
        % Using Yaron's suggestion of integration of the drive
        [actions,durations] = JerkAction(m);
        
       
        
        a14 = repmat(d1x,[1,cutlen]).*repmat(d4x,[1,cutlen])+ repmat(d1y,[1,cutlen]).*repmat(d4y,[1,cutlen]);
        a23 = repmat(d2x,[1,cutlen]).*repmat(d3x,[1,cutlen])+ repmat(d2y,[1,cutlen]).*repmat(d3y,[1,cutlen]);
        
        size(a14)
        size(a23)
        
        adiff = 2.* (a14 - a14') -4.* (a23 - a23');
        maction = repmat(actions(1:cutlen),[1,cutlen]);
        aaction = maction - maction';
        
        mduration = repmat(durations(1:cutlen),[1,cutlen]);
        aduration = mduration - mduration';
        
        drv = (5.*aaction +adiff)./aduration;
         
    case 'angular'
        % the angular equation of noether's theorem
    
    otherwise
        warning('bad method')
end

end
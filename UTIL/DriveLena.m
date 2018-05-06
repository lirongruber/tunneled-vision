% function DriveLena -
% Using Lena's numerical high derivations to calculate the drive
%
% input:
% m - smoothed curve
% method - 'normal',
%
% output:
% drv is the drive, a vector of length length(m)
% cdrv is the constrained drive, a vector of length length(m)
function [drv,drvC] = DriveLena(m,SAMPLINGRATE)
if ~exist('SAMPLINGRATE','var')
    SAMPLINGRATE = 1/146;
end

x = m(:,1);
y = m(:,2);
% size(x)





% X
dd1 = div1(length(x),x,SAMPLINGRATE);
dd2 = div1(length(dd1),dd1,SAMPLINGRATE);
dd3 = div1(length(dd2),dd2,SAMPLINGRATE);
dd4 = div1(length(dd3),dd3,SAMPLINGRATE);
dd5 = div1(length(dd4),dd4,SAMPLINGRATE);

cutlen = length(dd5)-5;

d1x = dd1(1:cutlen);
d2x = dd2(1:cutlen);
d3x = dd3(1:cutlen);
d4x = dd4(1:cutlen);
d5x = dd5(1:cutlen);


% Y
dd1 = div1(length(y),y,SAMPLINGRATE);
dd2 = div1(length(dd1),dd1,SAMPLINGRATE);
dd3 = div1(length(dd2),dd2,SAMPLINGRATE);
dd4 = div1(length(dd3),dd3,SAMPLINGRATE);
dd5 = div1(length(dd4),dd4,SAMPLINGRATE);


d1y = dd1(1:cutlen);
d2y = dd2(1:cutlen);
d3y = dd3(1:cutlen);
d4y = dd4(1:cutlen);
d5y = dd5(1:cutlen);

[~,~,s] = EULength(m);
s1 = (d1x.^2 + d1y.^2).^(1/2);
s2 = (d2x.^2 + d2y.^2).^(1/2);
s3 = (d3x.^2 + d3y.^2).^(1/2);
s4 = (d4x.^2 + d4y.^2).^(1/2);
s5 = (d5x.^2 + d5y.^2).^(1/2);

[~,k] = EUCurvature(m);
[ks,kss] = EUCurvatureDerivative(m);

k = k(1:cutlen);
ks = ks(1:cutlen);
kss = kss(1:cutlen);



% Drive using the constrained equation
drvC = (-5).*(k.^4 - ks.^2 -2.*k.*kss).*s1.^6 ...
    +60.* k.*ks.*s1.^4.*s2 ...
    +15.*k.^2.* s1.^2.*s2.^2 ...
    +30.*k.^2.* s1.^3.*s3 ...
    -s3.^2 + 2.*s2.*s4 -2.*s1.*s5;


% Drive using Huh/Felix formulation
drv = d3x.*d3x - 2 .*d4x.*d2x  +2.*d5x.*d1x + d3y.*d3y - 2 .*d4y.*d2y  +2.*d5y.*d1y;


end
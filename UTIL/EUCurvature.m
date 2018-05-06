% Velocity gives scalar curvature in the units given of a curve
function [k,signedk] = EUCurvature(m,SAMPLINGRATE)
% Assuming the tablet's sampling rate which is 1/146 seconds.
if ~exist('SAMPLINGRATE','var')
    dt = 1/146;
else
    dt = SAMPLINGRATE;
end

% % XXX fix the signed curvature!!!
% [len,ds,cumlen] = EULength(cutcurve);
% dds = diff(ds)./dt;
% 



% old code:
xs = m(:,1);
ys = m(:,2);
xsdot = (xs(2:end)-xs(1:end-1))./dt;
xsdotdot = (xsdot(2:end)-xsdot(1:end-1))./dt;
ysdot = (ys(2:end)-ys(1:end-1))./dt;
ysdotdot = (ysdot(2:end)-ysdot(1:end-1))./dt;
xsdot = xsdot(1:end-1);
ysdot = ysdot(1:end-1);
signedk = (xsdot.*ysdotdot-ysdot.*xsdotdot)./((xsdot.^2+ysdot.^2).^(3/2));
k = abs(signedk);
end
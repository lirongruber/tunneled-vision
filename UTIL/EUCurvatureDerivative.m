% Velocity gives scalar Ks - derivative of the curvature in the units given of a curve
function [ks,kss] = EUCurvatureDerivative(m)
% Assuming the tablet's sampling rate which is 1/146 seconds. 
dt = 1/146;
[k,signedk] = EUCurvature(m);

% ks - first derivative of k by s
ds = EUDist(m(1:end-1,:),m(2:end,:));
dk = diff(signedk);%signedk(2:end)-signedk(1:end-1);
lengthks = min(length(ds),length(dk));
ks = dk(1:lengthks)./ds(1:lengthks);

% kss - second derivative of k by s
dks = diff(dk);
lengthkss = min(length(ds),length(dks));
kss = dks(1:lengthkss)./ds(1:lengthkss);

end
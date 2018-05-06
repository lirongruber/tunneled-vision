% Velocity gives scalar Ks - derivative of the Equi Affine curvature in the units given of a curve
function [ks] = EACurvatureDerivative(m)
% Assuming the tablet's sampling rate which is 1/146 seconds. 
dt = 1/146;
k = EACurvature(m);
ds = EUDist(m(1:end-1,:),m(2:end,:));
dk = k(2:end)-k(1:end-1);
lengthks = min(length(ds),length(dk));
ks = dk(1:lengthks)./ds(1:lengthks);


end
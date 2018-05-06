% EAVelocity gives scalar equi affine velocity in the units given of a curve
function [v] = EAVelocity(m)
% Assuming the tablet's sampling rate which is 1/146 seconds. 
dt = 1/146;
[eal,dsigma] = EALength(m);
v = dsigma./dt;
end
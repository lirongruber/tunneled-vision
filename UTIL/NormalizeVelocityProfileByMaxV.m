% Normalizes velocity such that times and speed capture the range [0 1]
%
% Used by code in both Exp7 and Exp5
%
% Transferring v by assigning max v = 1;
function [nt,nv] = NormalizeVelocityProfileByMaxV(v)
dnt = 1/(length(v)-1);

maxv = max(v); 

nt = 0:dnt:1;
nv = v./maxv;

end
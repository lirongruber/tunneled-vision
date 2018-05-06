% Normalizes velocity such that times and speed capture the range [0 1]
%
% Used by code in both Exp7 and Exp5
%
% Making Integral(v)dt = 1 so that the total length is fixed.
%
function [nt,nv] = NormalizeVelocityProfile(v)
dnt = 1/(length(v)-1);

S = sum(dnt.*v);

nt = 0:dnt:1;
nv = v./S;

end
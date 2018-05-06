%
% R* from the Viviani Stucci 1992 paper
% This is an expression for 1/curvature which does not have a singularity 
% at k=0
%
% input:
%  k - curvature (a vector)
%  alpha - some constant, positive
%
%
% output:
%  R* = R/(1+alpha R) = 1/(K + alpha)
%
%
%

function [rstar] = Rstar(k,alpha)
if length(alpha)>1 || alpha<0
    warning('Rstar bad alpha')
end
rstar = 1./(k+alpha);
end
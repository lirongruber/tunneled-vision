% Creates a mixed geometry velocity profile for a given curve.
% The points of the profile are the same points, minus the last one
%
%
function [v,vmatrix] = MixedGeometryVelocity(curve,betas,cs)
if length(betas)~=3 || length(cs)~=3
    warning('input vectors are badly sized')
end

beta0 = betas(1);
beta1 = betas(2);
beta2 = betas(3);

c0 = cs(1);
c1 = cs(2);
c2 = cs(3);

l = length(curve);

euc = [EUCurvature(curve) ; 0 ;0];
eac = [EACurvature(curve); 0 ;0; 0;0];
[len,ds,cumlen] = EULength(curve);
if beta0+beta1+beta2 ~= 1
    warning('sum of betas isnt 1 as should be')
end

% Following Benequin et al. page 5. (7a-7c):


% Affine velocity:
v0 = c0 .* (euc.^(-1/3)).* (abs(eac).^(-1/2));

% Equi Affine velocity:
v1 = c1 .* (euc.^(-1/3));

% Euclidean velocity:
v2 = c2 .* ones(l,1);


% Mixed geometry velocity:
v = (v0 .^ beta0) .* (v1 .^ beta1) .* (v2 .^ beta2);
vmatrix = [v0 v1 v2];
end
% The angle change between the tangent vectors at the begining and end of a curve.
% calculated as changeOfAngle = Integral(|curvature| ds)
% assumes m is a curve and is allready smoothed
function [changeOfAngle] = ChangeOfAngle(m)
curvature = EUCurvature(m);
ds = EUDist(m(2:end,:),m(1:end-1,:));
l = min(length(curvature),length(ds));
changeOfAngle = sum(curvature(1:l).*ds(1:l));
end
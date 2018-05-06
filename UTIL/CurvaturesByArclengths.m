%  A fast interpolation of Curvatures from a known shape
%
% input: 
% allcurvatures - curvatures from the shape (from EUCurvatures(m))
% allarclengths - arclengths from the shape (from EULength(m))
% lengths - the positions where you want to know the curvature
%
% output:
% curvature - in the positions matching lengths
% 
function [curvatures] = CurvaturesByArclengths(allcurvatures,allarclengths,lengths)
curvatures = interp1(allarclengths,allcurvatures,lengths,'spline');


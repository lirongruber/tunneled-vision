% Returns a matrix of the tangent vectors of a given curve m
% m should be smoothed.
function [tangentVectors] = TangentVectors(m,samplingRate)
tangentVectors = diff(m)/samplingRate;
end
% Returns a matrix of the jerk vectors of a given curve m
% m should be smoothed.
% jerkvectors is the jerk in the same coordinates as m
% tnjerkvectors is the same vector, written in the local moving frame t n -
% euclidean tangent and euclidean normal to the curve
% there may be a mistake in the signs!
%
%
function [jerkvectors,tnjerkvectors] = JerkVectors(m,samplingRate)

jerkvectors = diff(diff(diff(m)))/(samplingRate^3);

tvectors = TangentVectors(m,samplingRate);
len = length(jerkvectors);
velocities = tvectors(1:len,1).^2+tvectors(1:len,2).^2;
tjerkvectors = (tvectors(1:len,1).* jerkvectors(:,1) + tvectors(1:len,2).* jerkvectors(:,2))./velocities;
njerkvectors = (tvectors(1:len,1).* jerkvectors(:,2) - tvectors(1:len,2).* jerkvectors(:,1))./velocities;
tnjerkvectors = [tjerkvectors,njerkvectors];
end
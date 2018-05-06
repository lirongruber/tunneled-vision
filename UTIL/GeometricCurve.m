% Transforming a curve m which is time dependent to a normalized curve with
% fixed distance between each 2 consecutive points
%
% input:
% m 
% numberofpoints (default is 100)
function [geometricm] = GeometricCurve(m,numberofpoints)
if ~exist('numberofpoints','var')
    numberofpoints = 100;
end
[totalArcLength,ds] = EULength(m);
cumulativeArcLength = cumsum(ds);
distanceunit = totalArcLength/(numberofpoints-1);
geometricm = zeros(numberofpoints,2);
geometricm(1,:) = m(1,:);
for i = 2:numberofpoints-1
    lengthtopoint = (i-1)*distanceunit;
    j = find(cumulativeArcLength>lengthtopoint,1,'first');
    if j==1
        ratio =(lengthtopoint)/(cumulativeArcLength(j));
    else
        ratio =abs((lengthtopoint-cumulativeArcLength(j-1))/(cumulativeArcLength(j)-cumulativeArcLength(j-1)));
    end
    geometricm(i,:) = (ratio*m(j,:)+(1-ratio)*m(j+1,:)); % linear combination of 2 points with coefficients t, (t-1)
    
end
geometricm(end,:) = m(end,:);
end
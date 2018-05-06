% Generate a straight MJ movement in the plane, between 2 given points
% 
% this is based on Flash and Hogan 1985
% 
% input:
%   startPoint
%   endPoint
%   duration in seconds
%   samplingRate of output in seconds
 
function m  =  MJStraightMovement(startPoint,endPoint,duration,samplingRate)
if ~exist('samplingRate','var')
    samplingRate = 1/146;
end



sampleTimes = samplingRate:samplingRate:duration;
sampleRelativeTimes = sampleTimes./duration;
x = MJPolinom(startPoint(1),endPoint(1),sampleRelativeTimes);
y = MJPolinom(startPoint(2),endPoint(2),sampleRelativeTimes);

m = [x' y'];

% size(m)


    function xs = MJPolinom(x0,x1,ts)
        xs = x0 + (x1 - x0) .* ((10 * ts.^3) - (15 .* ts.^4) + (6 .* ts.^5 ));
    end

end

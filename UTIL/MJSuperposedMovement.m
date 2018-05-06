% Generate a supeposition MJ movement in the plane, target switching which
% ends simultanously (both movements end at t=totalDuration, 
% the first starts at t=0 and the second at t=switchDuration)
% Following Flash and Henis 1991
%
% input:
% startPoint 
% viaPoint 
% endPoint  (the via point is not on the curve we will finally see)
% total movement duration 
% switch time (duration till switch) 
% samplingRate for output
%
%
function m  =  MJSuperposedMovement(startPoint,viaPoint,endPoint,totalDuration,switchDuration,samplingRate)
if ~exist('samplingRate','var')
    samplingRate = 1/146;
end



sampleTimes = samplingRate:samplingRate:totalDuration;
sampleRelativeTimes = sampleTimes./totalDuration;

% first stroke aiming at via:
m1 = MJStraightMovement(startPoint,viaPoint,totalDuration,samplingRate);


% second stroke starts at switchDuration
m2 = MJStraightMovement([0 0],endPoint-viaPoint,totalDuration - switchDuration,samplingRate);



m = m1;
try
    m(end-length(m2)+1:end,:) = m(end-length(m2)+1:end,:) +  m2;
catch
    warning('failed')
    size(m)
    size(m2)
end
    function xs = MJPolinom(x0,x1,ts)
        xs = x0 + (x1 - x0) .* ((10 * ts.^3) - (15 .* ts.^4) + (6 .* ts.^5 ));
    end

end

% Duration of a segment
% Assuming a sampling rate of the tablet - 146 measures per second
function [duration] = DurationOfTabletTrajectory(xy)
SAMPLINGRATE = 1/146;
duration =  length(xy)*SAMPLINGRATE ;

end
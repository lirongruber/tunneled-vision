function [optimaldt,optimaldtderivative, residualNorm, exitflag, output] = ConstrainedMinimumJerk(curve,dt,initialdt)
% Originally named Jerk_Analysis_Freq(...)
%--------------------------------------------------------------------------
% This function finds a velocity profile
% that minimizes the jerk of given trajectory.
%
% Output:
% optimaldt - optimal dt, with total movement duration 1
% optimaldtderivative -
%

% Input:
%   curve     - consists two columns of equally spaced in time trajectory
%             samples.
%   Freq    - Freq of the samples
%
% Written by Felix Polyakov 28.03.2000
% Modified by Ronit Fuchs to fit her data
% Remodified by Matan Karklinsky to be more simple
% NOTE, data should be filtered before analysis
%--------------------------------------------------------------------------


%Decleration of constants
MAX_VEL=200;         %Maximal tangential velocity, monkey cannot move faster.
%                    %[maxVel]=cm/s
HRZ = 1./dt;

if ~exist('initialdt','var')
    initialdt =   dt.*ones(length(curve)-1,1);
end


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Define time constraints from below for moving between two consequitive
% points.
% Given distances between points, we know that monkey
% cannot move faster than MaxVel (maximal tangential velocity)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[~,ds,~] = EULength(curve);
ds = [ds ;0];
minTimes =   ds/MAX_VEL;

%--------------------------------------------------------------------------
% End of time constraints
%--------------------------------------------------------------------------
maxNumbIters = 100000000;
options = optimset('MaxFunEvals', maxNumbIters*10, 'MaxIter', maxNumbIters, ...
    'TolFun', 1e-8 * size(initialdt,1), 'TolX', 1e-7);

format long

[optimaldt, residualNorm, ~, exitflag, output, ~] = ...
    lsqnonlin('Jerk_LST_SQR_Freq',initialdt, minTimes, [], options , HRZ, curve);

% The output is not necessarily of the same duration as inserted.
% Normalization takes place in each optimization step inside, except the
% last:
optimaldt = optimaldt./sum(optimaldt);


optimaldtderivative   =   deriv(optimaldt).*HRZ;









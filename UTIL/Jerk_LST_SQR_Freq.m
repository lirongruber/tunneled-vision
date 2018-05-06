function J_k = Jerk_LST_SQR_Freq(InputDataDeltaT, Freq, mov)				
%--------------------------------------------------------------------------
% This function calculates the Jerk for discrete samples of data.
% Jerk=Int\limits_0^T{\dddot{x}^2+\dddot{y}^2} dt .
%
% Here equivalent is estimated for discrete data.
% Jerk is represented in the form of finite differences as the derivative
% of acceleration.
%
% J_k=Jerk(InputDataPosition,InputDataDeltaT)
%
% Input:
%   InputDataPosition 
%           - object from class movement or two columns of X and Y
%             positions. 
%   DeltaT  - time intervals between points.
% 
% Output:
%   J_k     - non-negative number
%
%
% Output is supposed to be of dimension: centimeters, seconds.
% 
% NOTE: length(InputDeltaT)=length(mov)-1  !!!
%  
% Written by Felix Polyakov 28.03.2000
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
%Receive the data from input
%Positions
%--------------------------------------------------------------------------
if nargin ==1
    Freq = 100;
end
if nargin<=2
    mov=InputDataDeltaT;
end

% size(InputDataDeltaT)
% size(Freq)
% size( mov)

VectX=mov(:,1);   %[VectX]=cm
VectY=mov(:,2);   %[VectY]=cm

% VectX=mov(:,1)/10;   %[VectX]=cm
% VectY=mov(:,2)/10;   %[VectY]=cm

%--------------------------------------------------------------------------
%Time
%--------------------------------------------------------------------------
if nargin<=2 %In this case mov is as input only
    DeltaT=ones(length(VectX)-1,1)*1/Freq; %seconds
elseif nargin==3
    DeltaT=InputDataDeltaT; %Input, should be seconds
else
    display('Error input');
    return
end
%--------------------------------------------------------------------------
%Input is recieved
%--------------------------------------------------------------------------

DeltaT = DeltaT / sum(DeltaT) * ( length( DeltaT )/Freq ); 
%Constraint on constant full time
%This constant is somehow fixed in this program.
%Is normalized to realistic time inside the calling program

DeltaT          = abs(DeltaT);
DtVel           = DeltaT; %Note once more, length(DeltaT)=length(mov)-1 ;
DtAcceleration  = 1/2*(DeltaT(1:1:end-1) + DeltaT(2:1:end));
Dt_jerks        = 1/4*DeltaT(1:1:end-2) + 1/2*DeltaT(2:1:end-1) + 1/4*DeltaT(3:1:end);

%--------------------------------------------------------------------------
%Calculate Velocities
%--------------------------------------------------------------------------
VelX=diff(VectX)./DtVel;
VelY=diff(VectY)./DtVel;
%--------------------------------------------------------------------------
%Velocity calculated
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
%Calculate accelerations
%--------------------------------------------------------------------------
AccX=diff(VelX)./DtAcceleration;
AccY=diff(VelY)./DtAcceleration;
%--------------------------------------------------------------------------
%Accelerations calculated
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
%Calculate jerks, that is derivative of acceleration
%--------------------------------------------------------------------------
jerks_X=diff(AccX)./Dt_jerks;
jerks_Y=diff(AccY)./Dt_jerks;
%--------------------------------------------------------------------------
%jerks calculated
%--------------------------------------------------------------------------
%[m,n]=size(jerks_X)

J_k=1/sqrt(2)*[jerks_X.*sqrt(Dt_jerks); jerks_Y.*sqrt(Dt_jerks)];

return









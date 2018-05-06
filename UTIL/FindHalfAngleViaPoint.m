% Find the via point using the half angle rule
% see Shpigelmacher's M.Sc thesis for a formulation
% 
% This code should only be applied to simple curves we suspect are minjerk
% solutions with 1 via points. 
% Badly behaves if we have a complex shape
%

function [viaPointI] = FindHalfAngleViaPoint(m)
SAMPLINGRATE = 1/146;
tv = TangentVectors(m,SAMPLINGRATE);
n = sum(tv.^2,2);
ntv = [tv(:,1)./n tv(:,2)./n];

thetas = atan(ntv(:,2)./ntv(:,1));
thetasFixed = unwrap(thetas.*2)./2;
% test the range of angles is continuous and that the first point is a
% minimum and the last is a maximum or vice versa


thetaStart = thetasFixed(2);
thetaEnd = thetasFixed(end-1);

thetaMean = (thetaStart+thetaEnd)/2;

% [ thetaStart, thetaEnd , thetaMean]


% figure
% hold all
% plot(thetas,'+r')
% plot(thetasFixed,'ok')
% 
% plot(1,thetaStart,'*b')
% plot(10,thetaMean,'*b')
% plot(length(thetasFixed),thetaEnd,'*b')


[thetaDiff,viaPointI] = min(abs(thetasFixed-thetaMean));


% BAD CODE FOR MANUALLY FIXING THIS IF IT FAILS:
% [thetaDiff1,viaPointI1] = min(abs(thetas-thetaMean+pi));
% [thetaDiff2,viaPointI2] = min(abs(thetas-thetaMean));
% [thetaDiff3,viaPointI3] = min(abs(thetas-thetaMean-pi));
% 
% [~,i] = min([thetaDiff1 thetaDiff2 thetaDiff3]);
% switch i
%     case 1
%         viaPointI = viaPointI1;
%     case 2
%         viaPointI = viaPointI2;
%     case 3
%         viaPointI = viaPointI3;
%     otherwise
%         warning('bad i')
% end
% viaPointI
% thetas
end
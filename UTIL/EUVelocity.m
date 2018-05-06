% Velocity gives scalar velocity in the units given of a curve
function [v] = EUVelocity(m,dt) 

ds = EUDist(m(2:end,:),m(1:end-1,:));
v = ds./dt;

% % Alternative code, unused:
% dt = 1/146;
% xs = m(:,1);
% ys = m(:,2);
% ds = sqrt((xs(2:end)-xs(1:end-1)).^2+(ys(2:end)-ys(1:end-1)).^2);
% v = ds./dt;



end
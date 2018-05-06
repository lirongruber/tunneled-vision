% SDI measure for comparison of 2 velocity profiles
% input:
% t 
% v1
% v2
function [sdi] = SDI(t,v1,v2)

% should have x, y1 and y2 positive or 0, otherwise strange things may
% happen.
ay1 = abs(v1(:));
ay2 = abs(v2(:));
adx = abs([diff(t(:));0]);

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SDI index, from Armin Biess 2007 p.13054
sdi = sum(adx .* (max(ay1,ay2)- min(ay1,ay2)))./sum(adx .* max(ay1,ay2));
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
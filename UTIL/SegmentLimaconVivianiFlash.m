% segmenting a lap of a limacon in viviani and flash 95 method
% cutting at local y minima and maxima
%
% Assuming a single lap which starts at the max y position.
%
% Input - a limacon curve
% Output - indices of cutting on this curve
function is = SegmentLimaconVivianiFlash(xy)
x = xy(:,1);
half = round(length(x)/2);
[~,i1] = min(x(1:half));
[~,ih3] = min(x(half:end));
i3 = half + ih3 - 1;
[~,i12] = max(x(i1:i3));
i2 = i1 + i12 - 1;
is = [1,i1,i2,i3, length(x)];
end

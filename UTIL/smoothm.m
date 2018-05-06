% smoothing a matrix 
% cutoffFrequency=((146)/2)*filterW;
% usually 4-10 hz
function [sm] = smoothm(m,filterL,filterW)
if ~exist('filterL','var')
    filterL = 75;
end
if ~exist('filterW','var')
    filterW = 0.055;
end
xs = m(:,1);
ys = m(:,2);
F = fir1(filterL,filterW);
% plot(F)
sm = zeros(size(m));
sm(:,1) = filtfilt(F,1,xs);
sm(:,2) = filtfilt(F,1,ys);
end


% % check this compared to jindrich's:
% [b,a] = butter(n,w_n);
% % n is the order of the filter (3 or 5 is good enough)
% % w_n is the normalised cutoff frequency of the filter
% % refer to Matlab help for how to get these
% 
% X_filtered = filtfilt(b,a,X_original);
% Y_filtered = filtfilt(b,a,Y_original);

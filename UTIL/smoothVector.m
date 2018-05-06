% smoothing a matrix 
% cutoffFrequency=((146)/2)*filterW;
% usually 4-10 hz
function [sm] = smoothVector(x,filterL,filterW)
if ~exist('filterL','var')
    filterL = 75;
end
if ~exist('filterW','var')
    filterW = 0.055;
end

F = fir1(filterL,filterW);
% plot(F)
sm = filtfilt(F,1,x);

end


% % check this compared to jindrich's:
% [b,a] = butter(n,w_n);
% % n is the order of the filter (3 or 5 is good enough)
% % w_n is the normalised cutoff frequency of the filter
% % refer to Matlab help for how to get these
% 
% X_filtered = filtfilt(b,a,X_original);
% Y_filtered = filtfilt(b,a,Y_original);

% LikelihoodOfFunctionWithNormalNormalDistribution
%
% returns a likelihood grade for the function f, which is given as a vector
% yf = f(xf), given a data set (xdata,ydata), assuming IID normally distributed noise in both
% directions of the given stds xstd and ystd.
%
% input:
% (xgrid,ygrid) are monotone sets defining the range
% yf are the f function values 
% (xdata,ydata) are the coupled data points
% (xstd,ystd) are defining the normal distribution's std 
% method is 'standard', 'cyclic',...?
% (constant for now, may be changed to be of length  )
%
function [likelihood,loglikelihood] = LikelihoodOfFunctionWithNormalDistribution(xgrid,ygrid,yf,xdata,ydata,xstd,ystd,method)
[probabilityMatrix] = ProbabilityMatrixOfXYFromFWithNormalNoise(xgrid,ygrid,yf,xstd,ystd,method);

logProbabilityMatrix = log(probabilityMatrix);

logProbabilityForData = zeros(size(xdata));
  
for j = 1:length(xdata)
    % find the best describing indices in the matrix
    [~,xdatai] = min(abs(xgrid-xdata(j)));
    [~,ydatai] = min(abs(ygrid-ydata(j)));
    
    % put the 
    logProbabilityForData(j) = logProbabilityMatrix(xdatai,ydatai);
  
end
   
loglikelihood = sum(logProbabilityForData);
likelihood = exp(loglikelihood);
end
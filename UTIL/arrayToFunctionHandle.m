% Returns a function handle which is a spline interpolation using xin and
% yin.
% The function Uses 2 arrays to define a function which is the
% interpolation of y for the assigned x values
%
%
%  
%
%
%
function [functionHandle] = arrayToFunctionHandle(xin,yin)
functionHandle  = @(x)(interp1(xin,yin,x,'spline'));
end
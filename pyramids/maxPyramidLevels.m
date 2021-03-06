function [ mLevels ] = maxPyramidLevels( img )
%maxPyramidLevels how many levels of pyramid image can get 

%    in:
%    -------------
%
%           'Img' - a grayscale image (the output of 'my image read' with the grayscale option). Note
%           that 'Img' must be a matrix, not a filename!.



%           'filterLevel' - the Pascal level to use for the Gaussian filter (a positive integer). filterLevel=k
%           corresponds to the convolution of the identity filter, [1], k times by [0.5 ,0.5] (e.g. when
%           k = 3, the filter is [1] * [0.5, 0.5] * [0.5, 0.5] * [0.5, 0.5]). Note that you should use this
%           filter twice - once as row vector and then as column vector (i.e. the transpose). 

%    out: 
%    -------------
%
%           'mLevels' - the maxium number of  pyramid's levels img can get




S = size(img);
mLevels = floor( logab(2,S(1)));
%mLevels = abs(mLevels-4+1);
mLevels = abs(mLevels-4+1); % dont get smaller than 30x30 (actully 32x32)


end


function [ret] = logab(a,b)
% logab calculates loga_b

ret = log(b) / log(a);
end



function  [ pyr ] = GaussianPyramid( Img, nLevels,method, filterSize )
%  GaussianPyramid Implement the construction of Gaussian pyramids -
%           in:
%           Img - a grayscale image (the output of 'my image read' with the grayscale option). Note
%           that Img must be a matrix, not a flename!
%           nLevels - the number of levels in the pyramid, including the original image itself. You
%           should verify that this number is not too large, so that the smallest image in the size of the
%           highest pyramid level will be at least 16  16 pixels. In case that's impossible, build the
%           maximal number of 'legal' levels.
 
%           filterSize - the Pascal level to use for the Gaussian filter (a positive integer). filterLevel=k
%           corresponds to the convolution of the identity filter, [1], k times by [0.5 ,0.5] (e.g. when
%           k = 3, the filter is [1] * [0.5, 0.5] * [0.5, 0.5] * [0.5, 0.5]). Note that you should use this
%           filter twice - once as row vector and then as column vector (i.e. the transpose)
% out:
%           'pyr' - the cell array of images containing the pyramid, where pyrf1g is of the size of the
%           original image (read about 'cell' in Matlab's documentation). The last cell of 'pyr' should
%           contain the ?lter which was used to construct the pyramid.
%           image)
% 
% making sure the x and y axes have odd length (for the filtering)

s=size(Img);
if mod(s(1),2)==0
    Img=[Img ; Img(s(1) ,:)];
end
if mod(s(2),2)==0
    Img=[Img Img(:,s(2) )];
end

filter = createFilterFromLevel(method,filterSize );
nLevels = min(maxPyramidLevels(Img),nLevels);

A{1} = Img;

        for j=2:nLevels
            A{j} = reduceByFour(A{j-1},filter);
            filterSize=max(3,floor(filterSize/2));
            filter = createFilterFromLevel(method,filterSize );
         end

A{nLevels+1} = filter;

pyr = A;

end


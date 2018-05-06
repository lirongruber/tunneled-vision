function [ resizedImg ] = reduceByFour( Img, filter )
%resizeByHalf resized a graysscale imaege by four (each dim by 2)

%    in:
%    -------------
%
%           ’Img’ - a grayscale image (the output of ’my image read’ with the grayscale option). Note
%           that ’Img’ must be a matrix, not a ?lename!.


%    out:
%    -------------
%
%           ’resizedImg’ - a resized img. new image size is a half of the
%           input one


% how do we do it ?
%
% 1. do gaussian filter on x
% 2. do gaussian filter on y
% 3. sample each 2nd pixel on x
% 4. sample each 2nd pixel on y
% 5. return output matrix

%regular:
%     A = Img;
%     %A = GaussianFilter(A,filterLevel,'x');
%     %A = GaussianFilter(A,filterLevel,'y');
%
%
%     A = conv2(double(A),double(filter),'same');
%     A = conv2(A,filter','same');
%
%     B = A(1:2:end,1:2:end);
%     %B = B(1:2:end,1:2:end);
%     %B = A(1:2:end,1:2:end);
%
%
%   %  resizedImg = round(B.*2^(filterLevel*2));
%   resizedImg = B;

%NEW:
A=Img;
A=conv2(double(A),double(filter),'same');
A = conv2(A,filter','same');
B = A(1:2:end,1:2:end);
resizedImg = B;

%using imresize:
A=Img;
B = imresize(A, 0.5);
resizedImg = B;
end
function [ expendedImg ] = expendByFour( Img, filter )
%expendByFour expend a graysscale imaege by four(each dim by 2)

%    in:
%    -------------
%
%           'Img' - a grayscale image (the output of 'my image read' with the grayscale option). Note
%           that 'Img' must be a matrix, not a filename!.


%    out: 
%    -------------
%
%           'resizedImg' - a resized img. new image size is a half of the
%           input one


% so... how do we do it ?
% 1. add zero in each 2nd place 
% 2. do gaussian filter on x
% 3. do gaussian filter on y
% 4. return output matrix


    
    A = zeros(size(Img)*2);
    A(1:2:end,1:2:end) = Img(:,:);
    
    % GaussianFilter
    A = conv2(A, filter ,'same');
    A = conv2(A, filter' ,'same');
    
    % normalize
    expendedImg = A*4; 

    %using imresize:
    B = imresize(Img, 2);
    expendedImg = B;

end
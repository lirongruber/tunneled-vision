function [ expendedImg ] = expendByP( Img, filter,p )
%expendByP expend a graysscale imaege by p

%    in:
%    -------------
%
%           'Img' - a grayscale image (the output of 'my image read' with the grayscale option). Note
%           that 'Img' must be a matrix, not a filename!.

%          'filter' - the output of createFilterFromLevel
%          'p' - how many times smaller to make the picture for the correct
%                  amount of pixels


%    out: 
%    -------------
%
%           'resizedImg' - a rePixeld img. new image size is the same


% % % % % so... how do we do it ?
% % % % % 1. add zero in each 2nd place 
% % % % % 2. do gaussian filter on x
% % % % % 3. do gaussian filter on y
% % % % % 4. return output matrix


    
    A = zeros(size(Img)*p);
    for i=1:p
    A(i:p:end,i:p:end) = Img(:,:);
    for j=1:p-1
    A(j+1:p:end,i:p:end) = Img(:,:);
    A(i:p:end,j+1:p:end) = Img(:,:);
    end
    end
    
%     % GaussianFilter
      A = conv2(A, filter ,'same');
     A = conv2(A, filter' ,'same');
%     
     % normalize
    %expendedImg = A;
  expendedImg = A*4; 



end
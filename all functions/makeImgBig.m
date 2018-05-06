
function finalimg=makeImgBig(smallimg,A)
% This function take a grayscale small image and increase every pixel to
% n*n matrix
% input :       smallimg - grayscaled image
%                         A - scaling factor

tempimg=[];
finalimg=[];
[r,c]=size(smallimg);
for i=1:r*c
temp=repmat(smallimg(i),A);
if mod(i,r)==1
finalimg=[finalimg  tempimg];
tempimg=[];
 tempimg=[tempimg ; temp];
else
 tempimg=[tempimg ; temp];
end
end
finalimg=[finalimg  tempimg];
end
clear
clc
%% smaller size using fft2-resize-ifft2
shoe=imread('C:\Users\lirongruber\Documents\weizmann\MASTER_PROJECT\pictures\objects\shoe.jpg');
img=shoe;
img=rgb2gray(img);
img=im2double(img);
figure(1)
imshow(img)
fftShiftImg= fftshift(fft2(img));
s=size(fftShiftImg);
s=s+1;
 cutfftImg=fftShiftImg((s(1)/4):(s(1)*3/4-1), (s(2)/4):(s(2)*3/4-1)).*0.25;
finalimg=ifft2(ifftshift(cutfftImg));
figure(2)
imshow(finalimg)

%% smaller size using pyramids
nLevels=2; % pyramid levels - smallest pic is 16X16!!
filterLevel=3;
 [ pyr ] = GaussianPyramid( img, nLevels, filterLevel );

% %zoom(1,0.5)
% J = imresize(img, 0.5);
% figure(2)
% imshow(J)
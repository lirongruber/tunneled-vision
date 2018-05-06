
function  [cropedImage]=CropPic(fullImage, maxW,maxH);

%crop image if it is larger then screen size

[iy, ix, ~]=size(fullImage);

% if ix>maxW || iy>maxH
%     disp('Image size exceeds screen size');
%     disp('Image will be cropped');
% end

if ix>maxW
    cl=round((ix-maxW)/2);
    cr=(ix-maxW)-cl;
else
    cl=0;
    cr=0;
end
if iy>maxH
    ct=round((iy-maxH)/2);
    cb=(iy-maxH)-ct;
else
    ct=0;
    cb=0;
end
cropedImage=fullImage(1+ct:iy-cb, 1+cl:ix-cr,:);

end
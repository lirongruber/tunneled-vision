
function  [imdata,imdatablur,newfoveaRect,masktex,nonfoveatex]=imagePro(backgroundcolor,myimgfile,w,wH,wW,windowRect,ms,maskPara,wideSetup,exp_type,memory_exp,analog_type,oldPic,practice,low_con_control)
% this function loads and process the picture

% Load image file:
fprintf('Using image ''%s''\n', myimgfile);
imdata=imread(myimgfile);

if practice==1 || memory_exp==1
    imdatablur=imread(myimgfile);
    imdatablur=rgb2gray(imdatablur);
else
    imdatablur=ones(wH,wW)*backgroundcolor;
    imdatablur=im2uint8(imdatablur);
end
%%%%%%%%%%%%%%%%%imdatablur=imread(myblurimgfile);
%crop image if it is larger then screen size:
imdata=rgb2gray(imdata);
imdata=CropPic(imdata, wW,wH);
imdatablur=CropPic(imdatablur, wW,wH);
% pixeling the screen to worse resolution:
[imdata]=resoFit(imdata,myimgfile,analog_type,low_con_control);
[imdatablur]=resoFit(imdatablur,myimgfile,analog_type,low_con_control);
imdata=CropPic(imdata, wW,wH);
imdatablur=CropPic(imdatablur, wW,wH);
% Fovea contains original image data and Periphery contains blurred-version:
if exp_type==2
    imdata=oldPic;
    foveaimdata=imdata;
else
    foveaimdata = imdata;
end
peripheryimdata = imdatablur;
% Build texture for foveated and peripheral region:
foveatex=Screen('MakeTexture', w, foveaimdata);% JPEG to another
foveaRect=Screen('Rect', foveatex); % the picture size
[newfoveaRect, ~, ~]=CenterRect(foveaRect, windowRect); %  Center the first rect in the second
%  create a Luminance+Alpha matrix for use as transparency mask:
[maskdata]=masking(ms,maskPara,wideSetup);
% Build a single transparency mask texture:
masktex=Screen('MakeTexture', w, maskdata);
% maskRect=Screen('Rect', masktex); % the mask size....

nonfoveatex=Screen('MakeTexture', w, peripheryimdata);

end

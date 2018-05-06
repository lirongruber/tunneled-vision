
function [maskdata]=masking(ms,maskPara,wideSetup)

%  We create a Luminance+Alpha matrix for use as transparency mask:
%this function create a transparency mask with a given mask-parameter and a
%fovea window size (ms)

if wideSetup(1)==1
    transLayer=2;
    if wideSetup(3)==0
        % Layer 1 (Luminance) is filled with 'backgroundcolor'.
        [x,y]=meshgrid(-round(ms/(1+1/wideSetup(2))):round(ms/(1+1/wideSetup(2))), -round(ms/(1+wideSetup(2))):round(ms/(1+wideSetup(2))));
        maskdata=zeros(2*round(ms/(1+1/wideSetup(2)))+1, 2*round(ms/(1+wideSetup(2)))+1, transLayer) ;
        % Layer 2 (Transparency aka Alpha) is filled with gaussian transparency
        % mask.
        lenx=max(size(maskdata(:,1,1)));
        leny=max(size(maskdata(1,:,1)));
        
        xsd=(ms/(1+1/wideSetup(2)))/maskPara;
        ysd=(ms/(1+wideSetup(2)))/maskPara;
        maskdata(:,:,transLayer)=round(exp(-((y/ysd).^2))*255)';% original -((x/xsd).^2)
        maskdata(:,round(leny/3):round(leny*2/3),transLayer)=255; % the middle "finger" is the fovea!
        % add the pyramid periphery option
        % might be - all fovea like and different only in 'screenState
    else
        maskdata(:,:,transLayer)=255;% original -((x/xsd).^2)
    end
else
    % Layer 1 (Luminance) is filled with 'backgroundcolor'.
    transLayer=2;
    [x,y]=meshgrid(-(ms/2):(ms/2), -(ms/2):(ms/2));
    maskdata=zeros(2*(ms/2)+1, 2*(ms/2)+1, transLayer) ;
    % Layer 2 (Transparency aka Alpha) is filled with gaussian transparency
    % mask.
    xsd=(ms/2)/maskPara;
    ysd=(ms/2)/maskPara;
    maskdata(:,:,transLayer)=round(exp(-((x/xsd).^2)-((y/ysd).^2))*255);% original
    
end

end
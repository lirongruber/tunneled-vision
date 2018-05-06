 %% calculation of the filterSize:how many pixels to include in the filter... 
 
 %parameters:

 %need to verify from literature:
 fingerFov=0.005; %m (5mm)
 eyeDegFov=1.2; % degrees

 %verified:
 pinHeight=0.001;% m (1mm) - max height responding to graylevel=0 (black) ;
 A=pi*0.0005^2; % the area of the pin surface (radius=0.5mm)
 screenDist=1; %m (distance of the screen)
 pixInM=0.000264583333333334 ;% 1 pixel (X) = 0.000264583333333334 m

   %from  "3-D finite-element models of human and monkey fingertips to investigate the mechanics of tactile sense."
 forceOnFinger=(5.29+2.74+3.34+2.65+4.55)/5; % units:[grams] for 1mm indentation [N]
 forceOnFinger=forceOnFinger*0.00980665002864;% units: [N]
  EM=0.197*1000000;%  pascal, [N/m^2] (elastic moduli)

  % from "Determination of Mechanical Properties of the Human Fingerpad In Vivo Using a Tactile Stimulator"
%  forceOnFinger=0.06;%from 0.06 for 'steady state'  to 1.3 for peak (!!)
 
 %fingers:
 stressOnFinger=forceOnFinger/A;
 tanAlfa=stressOnFinger/EM; % the angle of the deformation
 lengthOfEffect=pinHeight/tanAlfa;% [m]  how "far" is the finger  effected
%  lengthOfEffect=0.006; % %from:  "Surface deflection of primate fingertip under line load."
 
%eyes:
 eyeFov=2*tand(eyeDegFov)/screenDist;%[m]
 eyePixFov=floor(eyeFov/pixInM);%number of pixels
 
 effectOutOfFov=lengthOfEffect/fingerFov; % percent of fovea affected by 1 pin
 filterSize=floor(eyePixFov*effectOutOfFov) % how many pixels to include in the filter
 

 %% calculation of the object size per analog type
 
 %need to verify from literature:
 fingerFovDen=300; % receptors per cm2
 eyeFovDen=147000; % receptors per mm2
 

 %verified:
 finger_fov_area=(0.5)^2; % the area of the finger foveola cm2
 eye_fov_area=pi*(0.35/2)^2; % the area of the eye foveola mm2
 pixInM=0.000264583333333334 ;% 1 pixel (X) = 0.000264583333333334 m
 
 %original finger setup:
 finger_pin_in_fov=4*8;
 finger_window_size=4*8; %in pins
 finger_object_size=25*25; %mean size of objects in pins
 
 %%foveola analog:
 eye_pin_in_fov=158*158;
 eye_window_size1=eye_pin_in_fov*(finger_window_size/finger_pin_in_fov);
 ms1=round(sqrt(eye_window_size1))
 
 eye_object_size1=(finger_object_size/finger_window_size)*eye_window_size1; %mean size of objects in pixels
 bigObjS1=round(sqrt(eye_object_size1))
 
 %%receptors analog:
 finger_fov_rec=fingerFovDen*finger_fov_area;
 eye_fov_rec=eyeFovDen*eye_fov_area;
 eye_window_size2=eye_pin_in_fov*(finger_fov_rec/eye_fov_rec);
 ms2=round(sqrt(eye_window_size2))
 
 eye_object_size2=(finger_object_size/finger_window_size)*eye_window_size2;
 bigObjS2=round(sqrt(eye_object_size2))

  
  
  
  
 


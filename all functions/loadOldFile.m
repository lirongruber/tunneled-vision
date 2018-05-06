function  [dataLen,gazesX,gazesY,myimgfile,oldPic]=loadOldFile(oldFileName,session_num);
% add

line='\_+';
load([oldFileName '_'  num2str(session_num)]);
%myimgfile=regexp(myimgfile, line, 'split');
myimgfile=myimgfile;%{1,1};
dataLen=find(gazeX,1,'last');
gazesX=gazeX(1:dataLen);
gazesY=gazeY(1:dataLen);
oldPic=imdata;

end
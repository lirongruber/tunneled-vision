% getting data from figures
% open('.fig');
% open('TRI.fig');
% open('SQU.fig');
% open('REC.fig');
% open('PAR.fig');
% open('CIR.fig');
 iptsetpref('ImshowBorder','loose');
 iptsetpref('ImshowInitialMagnification','fit');

nameoffile={'CIR.fig','TRI.fig' , 'SQU.fig', 'REC.fig', 'PAR.fig' };
for k=1:length(nameoffile)
    curnameoffile=nameoffile{k};
    open(curnameoffile);
    h = gcf;
    axesObjs = get(h, 'Children');  %axes handles
    dataObjs = get(axesObjs, 'Children'); %handles to low-level graphics objects in axes
    pic=dataObjs(3,1).CData;
    close
    finalPicsTouch{k}=pic;
    figure(k)
    imshow(pic,[])
    colormap(jet);
%     h = gcf;
%     TRIANGLE=getframe(h);
% RGB = insertShape( TRIANGLE.cdata, 'Polygon', [13 9 17 17 9 17], 'LineWidth', 1, 'Color','black');
% imshow(RGB,'Border','tight');
title([ 'Touch - ',curnameoffile(1:3)])
end

% open('allSubjects_triangle_correctNorm.fig');
% open('allSubjects_square_correct_Norm2max.fig');
% open('allSubjects_rectangle_correct_Norm2max.fig');
% open('allSubjects_parallogram_correct_Norm2max.fig');
% open('allSubjects_circle_correct_Norm2max.fig');

nameoffile={'allSubjects_circle_correct_Norm2max.fig','allSubjects_triangle_correct_Norm2max.fig' , 'allSubjects_square_correct_Norm2max.fig', 'allSubjects_rectangle_correct_Norm2max.fig', 'allSubjects_parallogram_correct_Norm2max.fig'};
for k=1:length(nameoffile)
    curnameoffile=nameoffile{k};
    open(curnameoffile);
h = gcf;
axesObjs = get(h, 'Children');  %axes handles
dataObjs = get(axesObjs, 'Children'); %handles to low-level graphics objects in axes
pic=dataObjs{2,1}.CData;
close
finalPicsSenSub{k}=pic;
figure(5+k)
imshow(pic)
colormap(jet);
title([ 'SenSub - ', curnameoffile(13:15)])
end

tilefigs
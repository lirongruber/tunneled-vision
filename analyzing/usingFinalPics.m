% after creating finalPics:
CM=2; % 1 FOR REGULAR ,2 FOR YAELS
y = stermap();

mainExp=1; % main=big vison. 1=vision, 0= sensub or touch
if mainExp==0
    sensub=1; %1 for sensub, 0 for touch
end
if mainExp==1
    bigShapes=1; %0=small shapes , 1=big+control(for control also control=1)
    control=0; % for all controll exps
end

wW=1920;
wH=1080;
if mainExp==1;
    for i=1:length(finalPics)
        final=zeros(size(finalPics{1,1}{1,1}));
        for j=1:length(finalPics{1,i})
            final=final+finalPics{1,i}{1,j};
        end
        m=max(max(final));
        final=final./m;
        VRs{i}=final;
    end
else
    VRs= finalPics;
end

% if mainExp==0
%     iptsetpref('ImshowBorder','loose');
%     iptsetpref('ImshowInitialMagnification','fit');
% else
%     iptsetpref('ImshowBorder','tight');
%     iptsetpref('ImshowInitialMagnification',100);
% end


if mainExp==0
    imshow(VRs{1,1},[])
else
    imshow(VRs{1,1})
end
if CM==1
colormap(gca,jet);
else
colormap(gca,y);
end
if  mainExp==0
    if sensub==1
                rectangle('Curvature', [1 1],'Position', [165 140 140 140],'LineWidth',5);
    else
                rectangle('Curvature', [1 1],'Position', [10 10 5 5],'LineWidth',5);
    end
else
    if bigShapes==0
        rectangle('Curvature', [1 1],'Position', [910 520 60 60],'LineWidth',5);
        zoom ON
        zoomcenter(941,545,13.5)
        zoom OFF
    else
        if control==1
           rectangle('Curvature', [1 1],'Position', [67 33 120 120],'LineWidth',5);
        end
    end
end
title('CIRCLE', 'FontSize', 25)


figure();
if mainExp==0
    imshow(VRs{1,2},[])
else
    imshow(VRs{1,2})
end
if CM==1
colormap(gca,jet);
else
colormap(gca,y);
end
if  mainExp==0
    if sensub==1
                line([228 , 268 ; 268 , 188 ; 188 , 228],[155 ,260 ; 260 ,260 ; 260 , 155 ], 'color', 'k','LineWidth',5)
    else
                line([964 , 907 ; 907 , 935 ; 935 , 964],[541 ,541 ; 541 482 ; 482 , 541 ], 'color', 'k','LineWidth',5)
    end
else
    if bigShapes==0
        line([964 , 907 ; 907 , 935 ; 935 , 964],[541 ,541 ; 541 482 ; 482 , 541 ], 'color', 'k','LineWidth',5)
        zoom ON
        zoomcenter(935,510,13.5)
        zoom OFF
    else
        if control==1
       line([126 , 179 ; 179 , 73 ; 73 , 126],[26 ,148 ; 148 148 ; 148 , 26 ], 'color', 'k','LineWidth',5)
        end
    end
end
title('TRIANGLE', 'FontSize', 25)

figure();
if mainExp==0
    imshow(VRs{1,3},[])
else
    imshow(VRs{1,3})
end
if CM==1
colormap(gca,jet);
else
colormap(gca,y);
end
if  mainExp==0
    if sensub==1
                rectangle('Position', [910 536 60 60],'LineWidth',5);
    else
                rectangle('Position', [910 536 60 60],'LineWidth',5);
    end
else
    if bigShapes==0
        rectangle('Position', [910 536 60 60],'LineWidth',5);
        zoom ON
        zoomcenter(940,567,13)
        zoom OFF
    else
        if control==1
            rectangle('Position', [39 33 120 120],'LineWidth',5);
        end
    end
end
title('SQUARE', 'FontSize', 25)

figure();
if mainExp==0
    imshow(VRs{1,4},[])
else
    imshow(VRs{1,4})
end
if CM==1
colormap(gca,jet);
else
colormap(gca,y);
end
if  mainExp==0
    if sensub==1
                rectangle('Position', [910 536 40 70],'LineWidth',5);
    else
                rectangle('Position', [910 536 40 70],'LineWidth',5);
    end
else
    if bigShapes==0
        rectangle('Position', [910 536 40 70],'LineWidth',5);
        zoom ON
        zoomcenter(930,570,13)
        zoom OFF
    else
        if control==1
            rectangle('Position', [38 23 100 130],'LineWidth',5);
        end
    end
end
title('RECTANGLE', 'FontSize', 25)

figure();
if mainExp==0
    imshow(VRs{1,5},[])
else
    imshow(VRs{1,5})
end
if CM==1
colormap(gca,jet);
else
colormap(gca,y);
end
if  mainExp==0
    if sensub==1
                line([908 , 940 ; 940 , 970 ; 970 , 940 ; 940 , 908],[550 ,550 ; 550 487 ; 487 , 487 ; 487 , 550 ], 'color', 'k','LineWidth',5)
    else
                line([908 , 940 ; 940 , 970 ; 970 , 940 ; 940 , 908],[550 ,550 ; 550 487 ; 487 , 487 ; 487 , 550 ], 'color', 'k','LineWidth',5)
    end
else
    if bigShapes==0
        line([908 , 940 ; 940 , 970 ; 970 , 940 ; 940 , 908],[550 ,550 ; 550 487 ; 487 , 487 ; 487 , 550 ], 'color', 'k','LineWidth',5)
        zoom ON
        zoomcenter(939,519,13)
        zoom OFF
    else
        if control==1
        line([180 , 250 ; 250 , 210 ; 210 , 140 ; 140 , 180],[30 ,30 ; 30 150 ; 150 , 150 ; 150 , 30 ], 'color', 'k','LineWidth',5)
        end
    end
end
title('PARALLELOGRAM', 'FontSize', 25)

tilefigs;

%%saving all figures withh their titles as names
figHandles = get(0,'Children'); % gets the handles to all open figure

for f = figHandles'
    axesHandle = get(f,'Children'); % get the axes for each figure
    titleHandle = get(axesHandle(1),'Title'); % gets the title for the first (or only) axes)
    text = get(titleHandle,'String'); % gets the text in the title
    saveas(f, text, 'jpg') % save the figure with the title as the file name
end
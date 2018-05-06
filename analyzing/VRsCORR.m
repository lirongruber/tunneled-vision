CM=2; % 1 FOR REGULAR ,2 FOR YAELS
y = stermap();
mainExp=1; % main-big vision. 1=vision, 0= sensub or touch
N=0;
for curr={finalPicsBIG finalPicsCONTROL finalPicsSenSub}
    finalPics=curr{1,1};
    N=N+1;
    if N==3 mainExp=0; end
    if mainExp==1;
        for i=1:length(finalPics)
            final=zeros(size(finalPics{1,1}{1,1}));
            for j=1:length(finalPics{1,i})
                final=final+finalPics{1,i}{1,j};
            end
            m=max(max(final));
            final=final./m;
            %             if N==3 final=final(1:400,1:400); end
            VRs{i}=final;
        end
    else
        VRs= finalPics;
    end
    ALL{N}=VRs;
end

% CONTROL ALL{1,2}
for i=1:5
    scaledALL{1,2}{1,i}=imresize(ALL{1,2}{1,i},1);
    if i==1
        s=[50 230];
        new=zeros(180,320);
        new(:,160-round((s(2)-s(1))/2):160-round((s(2)-s(1))/2)+round(s(2)-s(1)))=scaledALL{1,2}{1,i}(:,s(1):s(2));
        scaledALL{1,2}{1,i}=  new;
    end
    if i==2
        s=[30 210];
        new=zeros(180,320);
        new(:,160-round((s(2)-s(1))/2):160-round((s(2)-s(1))/2)+round(s(2)-s(1)))=scaledALL{1,2}{1,i}(:,s(1):s(2));
        scaledALL{1,2}{1,i}=  new;
    end
    if i==3
        s=[1 200];
        new=zeros(180,320);
        new(:,160-round((s(2)-s(1))/2):160-round((s(2)-s(1))/2)+round(s(2)-s(1)))=scaledALL{1,2}{1,i}(:,s(1):s(2));
        scaledALL{1,2}{1,i}=  new;
    end
    if i==4
        s=[1 180];
        new=zeros(180,320);
        new(:,160-round((s(2)-s(1))/2):160-round((s(2)-s(1))/2)+round(s(2)-s(1)))=scaledALL{1,2}{1,i}(:,s(1):s(2));
        scaledALL{1,2}{1,i}=  new;
    end
    if i==5
        s=[95 290];
        new=zeros(180,320);
        new(:,160-round((s(2)-s(1))/2):160-round((s(2)-s(1))/2)+round(s(2)-s(1)))=scaledALL{1,2}{1,i}(:,s(1):s(2));
        scaledALL{1,2}{1,i}=  new;
    end
    
end
% SenSub ALL{1,3}
for i=1:5
    scaledALL{1,3}{1,i}=imresize(ALL{1,3}{1,i},1);%2/3);
    if i==1
        s=[213 226];%[213 216];
        %         new=zeros(180,320);
        new=scaledALL{1,3}{1,i}(s(1)-90:s(1)+89,s(2)-160:s(2)+159);
        new(:,1:60)=0;
        new(:,260:end)=0;
        scaledALL{1,3}{1,i}=  new;
    end
    if i==2
        s=[223 224]; %[223 209];
        %         new=zeros(180,320);
        new=scaledALL{1,3}{1,i}(s(1)-90:s(1)+89,s(2)-160:s(2)+159);
        new(:,1:60)=0;
        new(:,260:end)=0;
        scaledALL{1,3}{1,i}=  new;
    end
    if i==3
        s=[208 220];%[208 210];
        %         new=zeros(180,320);
        new=scaledALL{1,3}{1,i}(s(1)-90:s(1)+89,s(2)-160:s(2)+159);
        new(:,1:60)=0;
        new(:,260:end)=0;
        scaledALL{1,3}{1,i}=  new;
    end
    if i==4
        s=[215 205];%[235 200];
        %         new=zeros(180,320);
        new=scaledALL{1,3}{1,i}(s(1)-90:s(1)+89,s(2)-160:s(2)+159);
        new(:,1:60)=0;
        new(:,260:end)=0;
        scaledALL{1,3}{1,i}=  new;
    end
    if i==5
        s=[213 239];%[223 224];
        %         new=zeros(180,320);
        new=scaledALL{1,3}{1,i}(s(1)-90:s(1)+89,s(2)-160:s(2)+159);
        new(:,1:60)=0;
        new(:,260:end)=0;
        scaledALL{1,3}{1,i}=  new;
    end
    %     new=scaledALL{1,3}{1,i};
    %     s=size(new);
    %     new=[new zeros(s(1),320-s(2))];
    %     if i==4
    %         new=new(64:64+179,:);
    %     else
    %         new=new(50:50+179,:);
    %     end
    %     scaledALL{1,3}{1,i}=new;
end
% BIG ALL{1,1}
for i=1:5
    scaledALL{1,1}{1,i}=imresize(ALL{1,1}{1,i},1/6);%1/6);
    if i==1
        s=[30 240];
        new=zeros(180,320);
        new(5:end,160-round((s(2)-s(1))/2):160-round((s(2)-s(1))/2)+round(s(2)-s(1)))=scaledALL{1,1}{1,i}(1:176,s(1):s(2));
        scaledALL{1,1}{1,i}=  new;
    end
    if i==2
        s=[80 240];
        new=zeros(180,320);
        new(:,160-round((s(2)-s(1))/2):160-round((s(2)-s(1))/2)+round(s(2)-s(1)))=scaledALL{1,1}{1,i}(:,s(1):s(2));
        scaledALL{1,1}{1,i}=  new;
    end
    if i==3
        s=[1 300]; % 80 260
        new=zeros(180,320);
        new(5:end,160-round((s(2)-s(1))/2):160-round((s(2)-s(1))/2)+round(s(2)-s(1)))=scaledALL{1,1}{1,i}(1:176,s(1):s(2));
        scaledALL{1,1}{1,i}=  new;
    end
    if i==4
        s=[80 230];
        new=zeros(180,320);
        new(10:end,160-round((s(2)-s(1))/2):160-round((s(2)-s(1))/2)+round(s(2)-s(1)))=scaledALL{1,1}{1,i}(1:171,s(1):s(2));
        scaledALL{1,1}{1,i}=  new;
    end
    if i==5
        s=[20 319];% 55 245
        new=zeros(180,320);
        new(5:end,160-round((s(2)-s(1))/2):160-round((s(2)-s(1))/2)+round(s(2)-s(1)))=scaledALL{1,1}{1,i}(1:176,s(1):s(2));
        scaledALL{1,1}{1,i}=  new;
    end
end

% where are the 10% most visited places un the image:
TOP=0.1;
for j=1:3
for i=1:5
    cmax=max(max(scaledALL{1,j}{1,i}));
    cmin=min(min(scaledALL{1,j}{1,i}));
%    new=zeros(180,320);
%    new=new+scaledALL{1,j}{1,i}(scaledALL{1,j}{1,i} >(max-min)*TOP);
   [r , c]=find(scaledALL{1,j}{1,i} >(cmax-cmin)*(1-TOP));
   pl=find(scaledALL{1,j}{1,i} >(cmax-cmin)*(1-TOP));
   avPlace{i,j}= [mean(r) mean(c)];
end
end
for i=1:5
Distance12(i)= EUDist(avPlace{i,1},avPlace{i,2});
Distance23(i)= EUDist(avPlace{i,2},avPlace{i,3});
Distance13(i)= EUDist(avPlace{i,1},avPlace{i,3});
end
Distances=[Distance12' Distance23' Distance13'];
meanDis=mean(Distances);
p1 = anova1(Distances);

% plots
for j=1:3
    if j==1
        type='TUNNEL VISION';
    else if j==2
            type='NATURAL VISION';
        else if j==3
                type='SENSUB TOUCH';
            end
        end
    end
    for i=1:5
        if i==1
            shape='CIRCLE';
        else if i==2
                shape='TRIANGLE';
            else if i==3
                    shape='SQUARE';
                else if i==4
                        shape='RECTANGLE';
                    else if i==5
                            shape='PARALLELOGRAM';
                        end
                    end
                end
            end
        end
        figure
        imshow(scaledALL{1,j}{1,i})
        if CM==1
            colormap(jet);
        else
            colormap(y);
        end
        if i==1
            %             rectangle('Curvature', [1 1],'Position', [67 33 120 120]);
            rectangle('Curvature', [1 1],'Position', [100 30 120 120]);
        else if i==2
                %                 line([126 , 179 ; 179 , 73 ; 73 , 126],[26 ,148 ; 148 148 ; 148 , 26 ], 'color', 'k')
                line([160 , 213 ; 213 , 107 ; 107 , 160],[29 ,151 ; 151 151 ; 151 , 29 ], 'color', 'k')
            else if i==3
                    %                     rectangle('Position', [39 33 120 120]);
                    rectangle('Position', [100 30 120 120]);
                else if i==4
                        %                         rectangle('Position', [38 23 100 130]);
                        rectangle('Position', [110 25 100 130]);
                    else if i==5
                            %                             line([180 , 250 ; 250 , 210 ; 210 , 140 ; 140 , 180],[30 ,30 ; 30 150 ; 150 , 150 ; 150 , 30 ], 'color', 'k')
                            line([145 , 215 ; 215 , 175 ; 175 , 105 ; 105 , 145],[30 ,30 ; 30 150 ; 150 , 150 ; 150 , 30 ], 'color', 'k');
                        end
                    end
                end
            end
        end
        title([ type '  ' shape], 'FontSize', 25)
    end
end
tilefigs;

% % NOT TO GOOD AT ALL :
%correlation:
% for i=1:5
% C(i,1)=corr2(scaledALL{1,1}{1,i},scaledALL{1,2}{1,i});
% C(i,2)=corr2(scaledALL{1,2}{1,i},scaledALL{1,3}{1,i});
% C(i,3)=corr2(scaledALL{1,3}{1,i},scaledALL{1,1}{1,i});
% end
% 
% for i=1:5
%     for j=1:5
% CA12(i,j)=corr2(scaledALL{1,1}{1,i},scaledALL{1,2}{1,j});
% CA23(i,j)=corr2(scaledALL{1,2}{1,i},scaledALL{1,3}{1,j});
% CA13(i,j)=corr2(scaledALL{1,3}{1,i},scaledALL{1,1}{1,j});
%     end
% end

% % ALSO NOT TO GOOD AT ALL :
 % HISTOGRAMS:
% for j=1:3
%     if j==1
%         type='TUNNEL VISION';
%     else if j==2
%             type='NATURAL VISION';
%         else if j==3
%                 type='SENSUB TOUCH';
%             end
%         end
%     end
%     figure (j)
%     for i=1:5
%         if i==1
%             shape='CIRCLE';
%         else if i==2
%                 shape='TRIANGLE';
%             else if i==3
%                     shape='SQUARE';
%                 else if i==4
%                         shape='RECTANGLE';
%                     else if i==5
%                             shape='PARALLELOGRAM';
%                         end
%                     end
%                 end
%             end
%         end
%         subplot(1,5,i)
%         hold on
%         a=hist(reshape(scaledALL{1,j}{1,i},1,[]));
%         hist(reshape(scaledALL{1,j}{1,i},1,[]))
%         m=max(a);
%         m=round(m,2);
%         axis([0 1 0 50000])
%         av=mean(a);
%         av=round(av,2);
%         s=std(a);
%         s=round(s);
%         plot(0.75,av, '*m')
%         plot(0.75*[1,1],[av,av+s], 'm')
%         title( num2str(s) )
%         xlabel(shape)
%     end
%     legend('Hist', 'Average','STD')
%     suptitle([type ' : HISTs max values and STDs'])
% end
% tilefigs;


% figure
% imshow(scaledALL{1,1}{1,1})
% figure
% imshow(scaledALL{1,1}{1,2})
% figure
% imshow(scaledALL{1,1}{1,3})
% figure
% imshow(scaledALL{1,1}{1,4})
% figure
% imshow(scaledALL{1,1}{1,5})
%
% figure
% imshow(scaledALL{1,2}{1,1})
% figure
% imshow(scaledALL{1,2}{1,2})
% figure
% imshow(scaledALL{1,2}{1,3})
% figure
% imshow(scaledALL{1,2}{1,4})
% figure
% imshow(scaledALL{1,2}{1,5})
%
% figure
% imshow(ALL{1,3}{1,1})
% figure
% imshow(ALL{1,3}{1,2})
% figure
% imshow(ALL{1,3}{1,3})
% figure
% imshow(ALL{1,3}{1,4})
% figure
% imshow(ALL{1,3}{1,5})
function []=bootS(c,g,h,cn,gn,hn)

% relVec1= randi(1000,[1,5000]);
% relVec2= randi(1000,[1,5000]);
relVec1= log(g); % c+cn , log(g)+log(gn) , log(h)+log(hn)
relVec2= log(gn);
batchSize=5000;
diffBetweenMeans=[];
for j=1:1000
    for i=1:batchSize*2
        a(i)=randi(batchSize*2,[1,1]);
    end
    tempVec= [relVec1 relVec2];
    tempVec1=tempVec(a(1:batchSize));
    tempVec2=tempVec(a(batchSize+1:end));
    diffBetweenMeans(j)=mean(tempVec1)-mean(tempVec2);
end
figure()
hist(diffBetweenMeans,100)
hold on
plot(mean(relVec1)-mean(relVec2),max(hist(diffBetweenMeans,100)),'*r','markerSize',10)
end
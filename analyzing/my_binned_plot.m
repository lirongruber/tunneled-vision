function [X,Y,y_low,y_high] = my_binned_plot(x,y,bins,is_mean)

num_bins=length(bins)-1;

    X=[];
    Y=[];
    STD=[];
for i=1:num_bins
    tempX=x(x>bins(i) & x<bins(i+1));
    tempY=y(x>bins(i) & x<bins(i+1));
    if is_mean==1
    tempMeanX=mean(tempX);
        tempMeanY=mean(tempY);
        tempSTD=std(tempY);
    else
      tempMeanX=median(tempX);
        tempMeanY=median(tempY); 
        tempSTD=quantile(tempY,[.25 .75])';
    end
    X=[X tempMeanX];
    Y=[Y tempMeanY];
    STD=[STD tempSTD];
end

 if is_mean==1
     y_low=Y-STD;
     y_high=Y+STD;
 else
        y_low=STD(1,:);
     y_high=STD(2,:);  
 end
 
end


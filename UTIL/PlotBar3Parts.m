% Plots a cumulative bar of 3 quantities
% given in a n by 3 matrix of matching values
% vals are plotted and also std bars
%
% input :
% vals - values (means)
% stds - matching std values to be used in error bars
%


function [] = PlotBar3Parts(vals,stds)
if size(vals,2)~=3
    warning('bad size of vals')
end

v1 = vals(:,1);
v2 = vals(:,2);
v3 = vals(:,3);

s1 = stds(:,1);
s2 = stds(:,2);
s3 = stds(:,3);

len = length(v1);

hold all
bar(1:len,v1+v2+v3,'g');
alpha(0.1)
bar(1:len,v1+v2,'b');
alpha(0.1)
bar(1:len,v1,'r');
alpha(0.2)

errorbar(1:len,v1+v2+v3,s3,'g')
errorbar(1:len,v1+v2,s2,'b')
errorbar(1:len,v1,s1,'r')


end
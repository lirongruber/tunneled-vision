% NearPoint input :
% curve m ,
% a point p
% and a maxD - minimal distance
% output:
% index i and values mi of one of the nearest points on m to p
% a 0 1 matrix of size [length(m),1], dbt, stating where the distance to p is
% below the threshold.

function [dbt,i,mi]=NearPoint(m,p,maxD)
ds = EUDist(m,p);
[Y,I] = min(ds);
i = I(1);
mi = m(i,:);
dbt = zeros(length(m),1);
dbt(ds<maxD) =1;
end

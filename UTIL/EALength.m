function [len,dsig,cumlen] = EALength(m)
ds = EUDist(m(2:end,:),m(1:end-1,:));
k = EUCurvature(m);
l = min(length(ds),length(k));
dsig = ds(1:l).*(abs(k(1:l)).^(1/3));
dsig(isnan(dsig))=0;
len = sum(abs(dsig));
cumlen = cumsum(abs(dsig));


% gives the arc length, d arc length ,cumulative arc length 
% with an arbitrary beta
% ro 
function [len,dro,cumlen] = BetaRuleLength(m,beta)
ds = EUDist(m(2:end,:),m(1:end-1,:));
k = EUCurvature(m);
l = min(length(ds),length(k));
dro = ds(1:l).*(abs(k(1:l)).^(-beta));
dro(isnan(dro))=0;
len = sum(abs(dro));
cumlen = cumsum(abs(dro));



function [pooled_std]=pooledStd(x1,x2)
% @ITZIK
pooled_std=sqrt(((numel(x1)-1)*nanvar(x1)+(numel(x2)-1)*nanvar(x2))/(numel(x1)+numel(x2)-2));


end
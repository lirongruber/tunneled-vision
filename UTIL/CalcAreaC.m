% function [ A ] = CalcAreaC( X )
% 
% X_ = [ X ; X(1,:) ] ;
% A =  ( sum( X_(1:end-1,1).*X_(2:end,2) - X_(1:end-1,2).*X_(2:end,1) ) ) / 2 ;
% A = abs( A ) ;
% return ;
%--------------------------------------------------------------------------

% I added the last summand xny1-x1yn. seems not to matter much.
function [ A ] = CalcAreaC( X )

X_ = [ X ; X(1,:) ] ;
A =  ( sum( X_(1:end-1,1).*X_(2:end,2) - X_(1:end-1,2).*X_(2:end,1) ) ) / 2 ;
Aextra = (X_(end,1)*X_(1,2) - X_(1,1) * X_(end,2))/2;
A = abs( A);% + Aextra) ;
return ;
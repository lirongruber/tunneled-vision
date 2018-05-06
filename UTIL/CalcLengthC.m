function [ len ] = CalcLengthC( C )
% including length of segment from last point to first point
C(end+1,:)=C(1,:) ;
s = sqrt( sum( (C(2:end,:)-C(1:end-1,:)).^2, 2 ) ) ;
len = sum( s ) ; 
return ;
%--------------------------------------------------------------------------
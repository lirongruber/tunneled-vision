% DerivativeBy: The n-th derivative of dy by dx
% input:
% n
% y
% x
% output has the same length as input
function [ders] = DerivativeBy(y,x,n)
if length(y)~=length(x)
    warning('DerivativeBy - x and y are of different sizes!')
end
ders = zeros(length(y),n);
dx = x(2:end)-x(1:end-1);
currentdy = y;
for i=1:n
    tempdy = (currentdy(2:end)-currentdy(1:end-1))./dx(1:length(currentdy)-1);
    ders(1:length(tempdy),i)= tempdy;
    currentdy=tempdy;
end
end
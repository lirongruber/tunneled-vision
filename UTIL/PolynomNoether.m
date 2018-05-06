% PolynomNoether
% 
% Calculates for a 5th degree polynomialc
function [val] = PolynomNoether(coeffs,type)
if ~all(size(coeffs)== [2,6])
    warning('coeffs should be a 2 by 6 matrix of coefficients of 5th degree polynomial')
    return
end

cx = coeffs(:,1);
cy = coeffs(:,2);

switch type
    case 'drive'
        % 12 (3 a3^2 - 8 a2 a4 + 20 a1 a5)
        
        val = 12*(3*(cx(3)*cx(3)+cy(3)*cy(3)) ...
            - 8*(cx(2)*cx(4)+cy(2)*cy(4))...
            + 20*(cx(1)*cx(5)+cy(1)*cy(5)));
        
    case 'angular'
        % 12 (-10 a[5] b[0]+2 a[4] b[1]-a[3] b[2]+a[2] b[3]-2 a[1] b[4]+10 a[0] b[5])
        val = 12* (-10*cx(1)*cy(6) + 2*cx(2)*cy(5)...
            - cx(3)*cy(4) +cx(4)*cy(3)...
            -2* cx(5)*cy(2)+10* cx(6)*cy(1));
        
    otherwise
        warning('bad type - should be either drive or angular')
end




end
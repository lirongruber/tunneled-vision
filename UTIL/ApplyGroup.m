% Generalizing group actions on a 
function [outm] = ApplyGroup(m,groupname,parameter)
switch lower(groupname)
    case {'rotations','s1'} % rotates in theta counter clockwise
        theta = parameter; 
        matrix = [cos(theta) sin(theta) ; -sin(theta) cos(theta)];
        outm = m*matrix;
    case 'negatex'
        matrix = [-1 0 ; 0 1];
        outm = m*matrix;
    case 'negatey'
        matrix = [-1 0 ; 0 1];
        outm = m*matrix;
    case 'd4'
        if sum (size(parameter)== [1 2])~=2 
            warning('parameter should be a 1 buy 2 matrix of integers')
            return
        end
        
        a = [1,0;0,-1];
        b = [0,1;-1,0];
        p = (a^parameter(1))*(b^(parameter(2)));
        % Generating a new curve
        outm =  (p*m')';
        
   
    case 'dilate'
        if sum (size(parameter)== [1 2])~=2 
            warning('parameter should be a 1 buy 2 matrix of reals')
            return
        end
        p = [parameter(1) 0 ; 0 parameter(2)];
        % Generating a new curve
        outm =  (p*m')';
        
    case 'z3'
        t = 2*pi/3;
        p = [cos(t) -sin(t) ; sin(t) cos(t)]^parameter;
        % Generating a new curve
        outm =  (p*m')';
        
    otherwise
        warning('unknown group!');
end
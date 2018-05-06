function [curvature, torsion] = CurvatureAndTorsion(mov,fs)

% Curvature and Torsion
% previously called curvetorsion
%
% [curvature, torsion] = threeD; % Perform the test
% [curvature, torsion] = threeD(mov); % Calculate curvature and torsion
%
% Calculate the curvature and the torsion of the trajectory.
%
% Curvature is calculated based on the radius of the curcumscribed circle
% for every triple of points.
% The torsion is calculated based on the definition  
% k_2 = \lim_{\Delta s \rightarrow 0} \frac{\Delta\theta}{\Delta s},
% where \Delta\theta is the angle between the osculating planes and 
% \Delta s is the distance between the neighbouring points.
% The calculation of torsion might be improved by using the method which is
% not solely based on the definition.

% Written by Felix Polyakov, 14.03.2004 .

% X, Y, Z are columns
if size(mov,2) == 2
    mov = [mov, zeros(size(mov,1),1)];
end
        
            
        
if ~exist('mov') | isempty(mov)
    % Perform the test
    perform_the_test = 1;
    T = [0:1:999]' / 1000 * (2 * pi);
    alpha = 2;
    mov = [alpha*cosh(T) alpha*sinh(T) alpha*T];
    whos mov
    %
    % The curvature should be 1 ./ (2 * alpha * (cosh(T)).^2); the torsion
    % should be 1 / (2 * alpha * (cosh(T)).^2) .
    curvature_test = 1 ./ (2 * alpha * (cosh(T)).^2);
    torsion_test = 1 ./ (2 * alpha * (cosh(T)).^2);
else
    perform_the_test = 0;
end

if ~exist('fs')
    fs = 1;
end

X = mov(:,1);
Y = mov(:,2);
Z = mov(:,3);

l1 = sqrt( (diff(X)).^2 + (diff(Y)).^2 + (diff(Z)).^2 ); % speed

% Curvature section
d = sqrt( (X(3:1:end) - X(1:1:end-2)).^2 + (Y(3:1:end) - Y(1:1:end-2)).^2 + ...
   (Z(3:1:end) - Z(1:1:end-2)).^2);

a = l1(1:1:end-1);
b = l1(2:1:end);

p = 1/2*(a + b + d);

S = sqrt(p.*(p-a).*(p-b).*(p-d));

curvature = 4*S./(a.*b.*d);

curvature = [0; curvature; 0];
curvature(find(imag(curvature) > 0 & (abs(curvature) < 1e-5))) = 1e-10; % If S is not real somewhere but very small, make it real and small
curvature(find(curvature == 0)) = 1e-10; %Avoid division by zero when calculating radius of curvature.
curvature(find(isnan(curvature))) = 1e8;

% Torsion section
normals_to_osculating_planes = cross( diff(mov(1:1:end-1,:)), diff(mov(2:1:end,:)) );
torsion = acos( (sum(normals_to_osculating_planes(1:1:end-1,:) .* normals_to_osculating_planes(2:1:end,:),2)) ./ ...
    sqrt(sum(normals_to_osculating_planes(1:1:end-1,:).^2,2) .* sum(normals_to_osculating_planes(2:1:end,:).^2,2)) ) ./ ...
    l1(2:1:end-1);
%torsion = [0; 0; interp1(T(2,1) + cumsum(diff(T(2:1:end-1,1))), torsion, T(3:1:end-2,1)); 0; 0];

if ~isempty(find(imag(curvature)>0))
    %keyboard;
end

if perform_the_test
    figure
    subplot(2,1,1)
    plot(T(2:1:end-1,1), curvature_test(2:1:end-1,1), '.g');
    hold on
    plot(T(2:1:end-1,1), curvature(2:1:end-1,1), 'b', 'LineWidth', 1.2);
    grid on
    legend('Curvature', 'Approximation')
    xlabel('Time')
    title('Curvature and its approximation')
    
    subplot(2,1,2)
    plot(T(3:1:end-2,1), torsion_test(3:1:end-2,1), '.g')
    hold on
    plot(T(3:1:end-2,1), torsion(3:1:end-2,1), 'b', 'LineWidth', 1.2)
    grid on
    legend('Torsion', 'Approximation')
    xlabel('Time')
    title('Torsion and its approximation')
end
return
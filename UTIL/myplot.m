% Plots a single curve of size n x 2
% options are same as plot color and marker type
function [] = myplot(M,options)
switch nargin
    case 0
        warning('not enough arguments for myplot');
    case 1
        plot(M(:,1) ,M(:,2),'.');
    case 2
        plot(M(:,1) ,M(:,2),options);
    otherwise
        warning('too many input arguments')
        
end
axis equal;
end
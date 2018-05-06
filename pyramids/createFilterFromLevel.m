function filter = createFilterFromLevel(method,filterSize )
%createFilterFromLevel create filter by demand. note this create only 1 dim
%filter.
%    in:
%    -------------
%             'method'             - 'reg'= the original filter (conv [0.5,0.5]) happens "filterLevel"
%                                                             times
%                                              'gao'= Gaossian filtering (sigma calculating according to size)
%                                              'tri'= Triangle filtering  
%
%           'size' - the filter level - int (how many pixels are involved)

%    out:
%    -------------
%
%           'filter' - [1xn] filter

%parameters:
filterLevel=filterSize -1;%for keeping the length of the filter the same as other methods
sigma = max(1,filterSize /2/3); % is a function of size  - about 1/3 of the Gaussian "total" width.


switch method
    case 'reg'
        % reguler:
        F = [0.5, 0.5];
        for k = 1:filterLevel-1
            F =  conv([0.5 , 0.5],F); %length filterLevel+1
        end
        
        %Gaussian:
    case 'gao'
        x = linspace(-filterSize  / 2, filterSize  / 2, max(ceil(filterSize )));
        gaussFilter = exp(-x .^ 2 / (2 * sigma ^ 2));
        gaussFilter = gaussFilter / sum (gaussFilter); % normalize
        F=gaussFilter;
        
        % Triangle:
    case 'tri'
        x = linspace(-filterSize  / 2, filterSize  / 2, max(ceil(filterSize )));
        x1=x(1:floor(filterSize /2));
        x2=x(floor(filterSize /2)+1:end);
        y1=1/(filterSize /2)*(x1+filterSize /2);
        y2=-1/(filterSize /2)*(x2-filterSize /2);
        triangleFilter=[y1 y2];
         triangleFilter = triangleFilter / sum (triangleFilter); % normalize
        F=triangleFilter;        
        
    otherwise
        error('no such method')
end
filter = F;
end
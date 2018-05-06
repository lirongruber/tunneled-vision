% InBinsByFirst
% 
% Placing 2 coupled variables in the same bins taken from the first
% variable.

function [avgFirst,avgSecond] = InBinsByFirst(firstVariable,secondVariable,binLimits,method)
if nargin<4
    method = 'median';
end
numberOfBins = length(binLimits)-1;

avgFirst = NaN(numberOfBins,1);
avgSecond = NaN(numberOfBins,1);

len = length(firstVariable); 
binNumbers = zeros(len+1,1);
for j = 1:len
    binNumber = find(binLimits<=firstVariable(j),1,'last');
    if isempty(binNumber)
        binNumbers(j) = 1;
    else        
        binNumbers(j) = binNumber;
    end
end

for k = 1: numberOfBins
    if sum(binNumbers==k)>0
        switch lower(method)
            case 'mean'
                avgFirst(k)  = mean(firstVariable (binNumbers==k));
                avgSecond(k) = mean(secondVariable(binNumbers==k));
            case 'median'
                avgFirst(k)  = median(firstVariable (binNumbers==k));
                avgSecond(k) = median(secondVariable(binNumbers==k));
            case 'meannonzero'
                fv = firstVariable (binNumbers==k);
                sv = secondVariable(binNumbers==k);
                avgFirst(k)  = mean(fv(fv~=0));
                avgSecond(k) = mean(sv(sv~=0));
            case 'mediannonzero'
                fv = firstVariable (binNumbers==k);
                sv = secondVariable(binNumbers==k);
                avgFirst(k)  = median(fv(fv~=0));
                avgSecond(k) = median(sv(sv~=0));
            otherwise
                warning('bad method for In bins by first')
        end
    else
        warning(strcat('bin # ',num2str(k),' is empty'));
    end
end

% likelihood ratio test for distributions
% input:
% dataCount  is a vector of sample numbers in the bins
% model1dist     is a vector of distribution for model 1
% model2dist     is a vector of distribution for model 2
% The first model is the null hypothesis, which is the restricted model
%
%   If the first model is a cell array, we consider the first model as a
%   set of models placed within this 1 dimensional cell array.
%   Else this is a simple model.
%
% The second model is the alternative hypothesis, the one we try to prove.
function [loglikeratio,loglikes,h,p] = LikelihoodRatioTest(dataCount,model1dist,model2dist)
eps = 0.0000001;

% Removing bins with 0 dataCount
relevantIs = find(dataCount>0);
    
% alternative log likelihood
loglikelihood2 = sum(dataCount(relevantIs).*log(model2dist(relevantIs)));
    
if iscell(model1dist) % a set of null models one of which should apply!
    numberOfNullModels = length(model1dist);
 
    loglikes1 = [];
    
    for j = 1:numberOfNullModels
        model1distCurrent = model1dist{j};
        
        if (length(dataCount) ~= length(model1distCurrent)) || (length(dataCount) ~= length(model2dist))
            warning('lengths missmatch')
        end
        if (abs(sum(model1distCurrent)-1)>eps) || (abs(sum(model2dist)-1)>eps)
            warning('model distribution not normalized to sum 1')
        end
        
        
        loglikelihood1Current = sum(dataCount(relevantIs).*log(model1distCurrent(relevantIs)));
 
        loglikes1 = [loglikes1 loglikelihood1Current];
        
    end
    loglikes = [loglikelihood2 loglikes1];
    
    
    
    
     
    
    
    maxloglikelihood = max(loglikes);
    maxloglikelihood1 = max(loglikes1);
    
    loglikeratio = nan; %XXX not calculated currently, can be in the for loop if need rises.
    [h,p] = lratiotest(maxloglikelihood,maxloglikelihood1,1);
    
    
    
    
else % a single null model
    
    if (length(dataCount) ~= length(model1dist)) || (length(dataCount) ~= length(model2dist))
        warning('lengths missmatch')
    end
    if (abs(sum(model1dist)-1)>eps) || (abs(sum(model2dist)-1)>eps)
        warning('model distribution not normalized to sum 1')
    end
       
    loglikelihood1 = sum(dataCount(relevantIs).*log(model1dist(relevantIs)));
     
    
    loglikes = [loglikelihood1,loglikelihood2];
    maxloglikelihood = max(loglikes);
    
    loglikeratio = sum(dataCount(relevantIs).*log(model1dist(relevantIs)./model2dist(relevantIs)));
    [h,p] = lratiotest(maxloglikelihood,loglikelihood1,1);
    % if h
    %     loglikes
    % end
end
end
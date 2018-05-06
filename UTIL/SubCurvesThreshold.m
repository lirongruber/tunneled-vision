% Extractor of subcurves, segmented by 
%
% input:
% method can be 'curvature' = 'eucurvature', 'eacurvature'
% threshold is a scalar used for cutting.
%
% output:
%   a segs vector of segments numbers for each index on the curve
%
%
%
function [segs,isstart,isend] = SubCurvesThreshold(m,threshold,method)
if strcmp(lower(method),'eucurvature')
    method = 'curvature';
end

switch lower(method)
    case 'curvature'
        p = EUCurvature(m);
        bw =zeros(size(p));
        bw(p>=threshold) = 1;
    case 'eacurvature'
        p = EACurvature(m);
        bw =zeros(size(p));
        bw(p>=threshold) = 1;
    case 'abscurvature'
        p = abs(EUCurvature(m));
        bw =zeros(size(p));
        bw(p<=threshold) = 1;
    case 'abseacurvature'
        p = abs(EACurvature(m));
        bw =zeros(size(p));
        bw(p<=threshold) = 1;
    otherwise
        warning('Unknown method SubCurvesThreshold!')
end
[segs,dbtsegs] = Near2Segments(1-bw);
isend = find((p(1:end-1)== 0) .* (p(2:end) == 1));
isstart = find((p(1:end-1)== 1) .* (p(2:end) == 0));
end

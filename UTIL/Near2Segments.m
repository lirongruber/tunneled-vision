% segmentation based on a 0 1 matrix of a given matrix
% input:
% dbt is a 0 1 matrix saying where the segments are cut
% output:
% segs is a sementation vector of m, in values 1..n integers
% dbtsegs is a segmentation vector of dbt, in values 1..n or 1..n-1
% integers.
%
%
function [segs,dbtsegs] = Near2Segments(dbt)
if ~isvector(dbt)
    warning('dbt is not a vector')
    return;
end
dbtNegative = 1-dbt;
dbtsegs = bwlabeln(dbt);
segs = bwlabeln(dbtNegative);

end
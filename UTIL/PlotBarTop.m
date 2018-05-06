%
% Plots a bar figure, only the line of the top, without any sides.
%
% input:
%   binedges
%   binvals - values - length must be shorter by 1
%   color - must be a valid matlab color letter (in 'rgbkmcy')
%

function [] =  PlotBarTop(binedges,binvals,color)
binedges = binedges(:)';
binvals = binvals(:)';

if length(binedges) ~= length(binvals)+1;
    warning('length missmatch')
end

% Doubling for plotting:
edges = [binedges ;binedges];
edges = edges(:);

vals = [binvals ; binvals];
vals = [vals(1); vals(:) ; vals(end) ];



mid = (binedges(1:end-1) + binedges(2:end))./2;

lc = ['-' color];
dc = ['o' color];
hold all

plot(edges,vals,lc);
% plot(mid,binvals,dc);


size(vals)

end
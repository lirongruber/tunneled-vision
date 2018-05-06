% Takes a curve m and segments it by a list of points ps
%
% input:
% m is a curve
% ps is a list of points [p1;...;pn]
% maxD is the radius in which we check points
% method can be: 'nearest','average','maxcurvature','mincurvature','zerocurvature',
%
% output:
% ts are passing times in points nearest to ps
% segs is a list of integer indices of parts leading between the different
% points
% newps is the list of ps for which times ts match, in order, including repetitions
function [segs,ts,js,orderedpoints,is] = SegmentCurve(m,parameterStruct)
method = parameterStruct.method;
points = parameterStruct.points;
maxD = parameterStruct.maxDistance;
% curvatureThreshold = parameterStruct.curvatureThreshold;
% curveDirection = parameterStruct.curveDirection;
samplingRate = parameterStruct.samplingRate;

% CONSTS
LARGECONST = 100;

% checking points are distant enough
[lengthpoints,shouldBe2] = size(points);
if shouldBe2 ~= 2
    warning('points is not an n*2 matrix as it should be')
end
for j = 1:lengthpoints
    dists = EUDist(points,points(j,:));
    dists(j) = LARGECONST;
    minGap = min(dists);
    if minGap < 2.1*maxD
        points
        warning('points are too close to each other - either lower maxDistance or choose different points!');
        return;
    end
end

nearpoints = zeros(length(m),lengthpoints);

% default sampling rate
if isnan(samplingRate)
    samplingRate = 1/146;
end

% dividing the entire curve into near-point and middle sections.
for j=1:lengthpoints
    p = points(j,:);
    [dbt,i,mi]=NearPoint(m,p,maxD);
    nearpoints(:,j)=dbt;
end
nearanypoint = sum(nearpoints,2);
[segs1,dbtsegs1] = Near2Segments(nearanypoint);
n = max(dbtsegs1);
is = zeros(n,1);
js = zeros(n,1);
ts = zeros(n,1);
orderedpoints = zeros(n,2);
[kofm ,signedk] = EUCurvature(m);

% segmentations using the near points methods
for r =1:n
    nearp = dbtsegs1==r;
    currentis = find(nearp);
    firsti = currentis(1);
    lasti = currentis(end);
    nearestpj = find(nearpoints(firsti,:)==1);
    js(r) = nearestpj;

    p = points(nearestpj,:);
    switch lower(method)
        case {'nearpointsnearest'}
            ds = EUDist(m,p);
            ds(nearp~=1)=LARGECONST;
            ds(ds==0)=LARGECONST;
            [y,i] = min(ds);
            is(r) = i;
        case {'nearpointsaverage'}
            is(r) = round((firsti+lasti)./2);
        case{'nearpointsmaxcurvature'} % assumes m is allready smooth enough to have continuous curvature
            knearp = kofm;
            knearp(nearp~=1) = -LARGECONST;
            [y,i] = max(knearp);
            is(r)=i;
        case{'nearpointsmincurvature'} % assumes m is allready smooth enough to have continuous curvature
            knearp = kofm;
            knearp(nearp~=1) = LARGECONST;
            [y,i] = min(knearp);
            is(r)=i;
        
              
        otherwise
            disp('Unknown method.')
    end
    orderedpoints(r,:) = p;
    ts(r) = is(r)*samplingRate;
end

nearpfinal = zeros(length(m),1);
nearpfinal(is) = 1;
[segs,dbtsegs] = Near2Segments(nearpfinal);

end
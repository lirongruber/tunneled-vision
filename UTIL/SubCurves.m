% Cut subcurves of constant parameter size, starting at places startis.
% Assumes a smoothed matrix.
%
%
%
%
function [sc] = SubCurves(m,startis,len,paramname)
l = length(startis);
sc = cell(l,1);
switch lower(paramname)
    case 'time'
        if startis(end)+len > length(m)
            warning('last curve is out of range ');
        else
            for j = 1:l
                ilen = len;
                sc{j,1} = m(startis(j):startis(j)+ilen-1,:);
            end
        end
        
    case 'ealength'
        %         [eal,dsigma] = EALength(m);
        
        for j = 1:l
            [eal,dsigmacut] = EALength(m(startis(j):end,:));
            eals = cumsum(abs(dsigmacut));
            ilen = find(eals>len,1,'first');
            inds = startis(j):startis(j) + ilen-1;
            sc{j,1} = m(inds,:);
            %             [eal,dsig] = EALength(sc{j,1});
            %             cumsum(abs(dsig))
        end
        
    case 'eulength'
        [eal,dscut] = EULength(m(startis(j):end,:));
        euls = cumsum(abs(dscut));
        ilen = find(euls>len,1,'first');
        inds = startis(j):startis(j) + ilen-1;
        sc{j,1} = m(inds,:);
        
    otherwise
        warning('undefined or unfamiliar paramname');
end

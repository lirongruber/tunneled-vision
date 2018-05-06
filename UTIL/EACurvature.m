function [eac  ] = EACurvature(rr)
% n [EAC iEAC fEAC] = EACurvature(rr,varargin)
% rr = [xx,yy,zz], rows corresponding to samples
% find the equi-affine curvature using the method of Calabi et al. 1998.
% Written by Yaron Meirovitch

% EAC - equi-affine curvature

%     path=rr;
%     g={};
%     finalEAC=zeros(length(rr),1);
%     if nargout == 3
%         finaliEAC=zeros(length(rr),1);
%         finalfEAC=zeros(length(rr),1);
%     end
%
%     if size(rr,2) == 3
%         rotangles=0;
%     else
%         rotangles=rand(1,2)*2*pi;
%     end
%

% Calculates the signed area of the parallelogram whos sides are rr(i,:)-rr(j,:),rr(i,:)-rr(k,:)
    function ijk = ijkArea(i,j,k)
        % if 2D
        if size(rr,2) == 2
            ijk = det([rr(i,:) 1 ;rr(j,:) 1 ;rr(k,:) 1]);
        elseif size(rr,2) == 3
            Vijk = cross(rr(i,:)-rr(j,:),rr(i,:)-rr(k,:)); % needs to be double verified
            ijk = prod(sign(Vijk(Vijk~=0)))*norm(Vijk);
        end
    end

% Calculates the signed area of the parallelogram whos sides are
% rr(i,:)-rr(j,:),rr(k,:)-rr(l,:)
    function ijkl = ijklArea(i,j,k,l)
        ijkl = ijkArea(i,j,l)-ijkArea(i,j,k);  % to be verified (see Calabi)
    end

% Calculates the T invarient around the point i >= 3 - See Calabi 1998
    function T = invTi(i)
        T = (1/4)*...
            ijkArea(i-2,i-1,i)*...
            ijkArea(i-2,i-1,i+1)*...
            ijkArea(i-2,i-1,i+2)*...
            ijkArea(i-2,i,i+1)*...
            ijkArea(i-2,i,i+2)*...
            ijkArea(i-2,i+1,i+2)*...
            ijkArea(i-1,i,i+1)*...
            ijkArea(i-1,i,i+2)*...
            ijkArea(i-1,i+1,i+2)*...
            ijkArea(i,i+1,i+2);
    end

% Calculates the S invariant around the point i >= 3 - See Calabi 1998
    function [S pts] = invSi(i)
        pts = rr(i-2:i+2,:);
        S = (1/4)* ( (ijkArea(i-2,i-1,i+1) * ijkArea(i-2,i,i+2) * ijklArea(i-1,i,i+1,i+2))^2 +...
            (ijkArea(i-2,i-1,i) * ijkArea(i-2,i+1,i+2) * ijklArea(i-1,i+1,i,i+2))^2-...
            2*ijkArea(i-2,i-1,i)*ijkArea(i-2,i+1,i+2)*ijkArea(i-2,i-1,i+1)*ijkArea(i-2,i,i+2)*...
            (ijkArea(i-1,i,i+1)*ijkArea(i,i+1,i+2)+ijkArea(i-1,i,i+2)*ijkArea(i-1,i+1,i+2)) );
    end



EAC = NaN; % equi-affine curvature - to be numerically approximated



EAC = zeros(length(rr),1);
SIn = zeros(1,length(rr));
TIn = zeros(1,length(rr));
for k=3:length(rr)-2
    EAC(k) = invSi(k)/((invTi(k)^2)^(1/3));
    SIn(k) = invSi(k);
    TIn(k) = invTi(k);
end

if nargout == 0
    warning('no output was shown')
%     figure;
%     myplot(rr);  title('curve')
%     hold all;
%     if size(rr,2) == 3
%         plot3(rr(:,1),rr(:,2),rr(:,3),'.'); title('curve')
%     elseif size(rr,2) == 2
%         myplot(rr);  title('curve')
%     end
%     axis('equal');
%     
%     figure; plot(EAC(5:end-2),'.'); title('EAC');
%     figure; plot(SIn(5:end-2),'.'); title('S Inv');
%     figure; plot(TIn(5:end-2),'.'); title('T Inv');
%     figure; plot(pi*TIn./((abs(SIn.^3)).^.5)); title('Area');
end

eac = -EAC(3:end-2);



end


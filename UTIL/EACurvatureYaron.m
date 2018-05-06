function [finalEAC finaliEAC finalfEAC] = EACurvature(rr,varargin)
% YARON's COMPLICATED VERSION
% n [EAC iEAC fEAC] = EACurvature(rr,varargin)
% rr = [xx,yy,zz], rows corresponding to samples 
% find the equi-affine curvature using the method of Calabi et al. 1998. 
% Written by Yaron Meirovitch
%
% varagin - properties: 
% 'filter' - should be followed by 'salt' to indicate the use of salt
% pepper salt filter
% EAC - equi-affine curvature
% fEAC - pepper-salt filtered EAC
% iEAC - fEAC with the dirt values interpolated.
    path=rr;
    g={};
    finalEAC=zeros(length(rr),1);
    if nargout == 3
        finaliEAC=zeros(length(rr),1);
        finalfEAC=zeros(length(rr),1);
    end
        
    if size(rr,2) == 3
        rotangles=0;
    else
        rotangles=rand(1,2)*2*pi;
    end
    
    
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
    

    for angle=rotangles % we will rotate the shape and average the final curvature using all rotated shapes
        
    EAC = NaN; % equi-affine curvature - to be numerically approximated 
    scale=rand*100;
    if size(rr,2) == 3
        rot = eye(3);
    else    
        rot = diag([scale,1/scale])*[cos(angle) sin(angle); -sin(angle) cos(angle)];
        %rot=randn(2,2); rot=rot/sqrt(abs(det(rot)));
        %rot=rand(2,2);
    end
    rr = (rot*path')';
    xx = rr(:,1);
    yy = rr(:,2);
    if size(rr,2) == 3
        zz = rr(:,3);
    end
     
  
    EAC = zeros(length(rr),1);
    SIn = zeros(1,length(rr));
    TIn = zeros(1,length(rr));
    for k=3:length(rr)-2
        EAC(k) = invSi(k)/((invTi(k)^2)^(1/3));
        SIn(k) = invSi(k);
        TIn(k) = invTi(k);
    end
    
%     u = 6;                %% Useful debugging code - using rotations 
%     [su pts1] = invSi(u);
%     oldrr = rr; 
%     figure; plot(rr(:,1),rr(:,2)); hold on; plot(rr(6:10,1),rr(6:10,2),'or');  title('curve'); axis('equal');
%     al = -2*pi/20; rr = ([cos(al) sin(al); -sin(al) cos(al)]*rr')';
%     plot(rr(6:10,1),rr(6:10,2),'xk');
%     [oldrr(7:11,1) rr(6:10,1)];
%     [sun pts2] = invSi(u-1);
      
      if nargout == 0
        figure;
        plot(xx,yy,'.');  title('curve')
        hold all;
        if size(rr,2) == 3
            plot3(xx,yy,zz,'.'); title('curve')
        elseif size(rr,2) == 2
            plot(xx,yy,'.');  title('curve')
        end
        axis('equal');
        
        figure; plot(EAC(5:end-2),'.'); title('EAC');
        figure; plot(SIn(5:end-2),'.'); title('S Inv');
        figure; plot(TIn(5:end-2),'.'); title('T Inv');
        figure; plot(pi*TIn./((abs(SIn.^3)).^.5)); title('Area');
      end
    EAC = -EAC(3:end-2);
    EAC = [EAC(1); EAC(1); EAC; EAC(end); EAC(end)]; 


pro_vars = varargin;
while length(pro_vars) >= 2,
    prop = pro_vars{1};
    val = pro_vars{2};
    switch prop
        case 'filter' % should use filter to clean the data
            fEAC = EAC;
            dirts=zeros(1,length(EAC));
            if strcmp(val,'salt') % use pepper salt filter 
                
                for dirt_number=1:2 % allow for either one dirt datum or two of them to appear in between correct data points 
                    for k=1:length(EAC)-dirt_number-1
                        if std([EAC(k),EAC(k+dirt_number+1)]) <  std(EAC(k:k+dirt_number+1))/10
                             dirts(k:k+dirt_number+1)=1;
                             fEAC(k:k+dirt_number+1) = mean([EAC(k),EAC(k+dirt_number+1)]);
                        end
                    end
                    
                end
                Idirt = find(dirts);
                Iclean = find(~dirts);
                cleanedDirt = interp1(Iclean,EAC(Iclean),Idirt); 
                iEAC = EAC;
                iEAC(Idirt)=cleanedDirt;
                Inan = (find(isnan(iEAC)));
                iEAC(Inan)=EAC(Inan);
            end
    end
    pro_vars = pro_vars(3:end);
  
    
end
    
    finalEAC=finalEAC+EAC/length(rotangles);
    if nargout == 3
        finaliEAC=finaliEAC+iEAC/length(rotangles);
        finalfEAC=finalfEAC+fEAC/length(rotangles);
    end
%     g{end+1}=iEAC;
    end

end

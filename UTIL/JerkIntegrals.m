% Calculates jerks for a given curve, integrals over the entire curve.
% the total integral x'''^2+y'''^2
% the tangent integral (x' x'''+y' y''')^2/(x'^2+y'^2)
% the normal integral (-y' x'''+x' y''')^2/(x'^2+y'^2)
function [jerkIntegral,tangentJerkIntegral,normalJerkIntegral,cumJerkIntegral] = JerkIntegrals(m,samplingRate)
tangentVectors = TangentVectors(m,samplingRate);
jerkVectors = JerkVectors(m,samplingRate);

len = min(length(jerkVectors),length(tangentVectors));

jerk = sqrt(jerkVectors(1:len,1).^2 + jerkVectors(1:len,2).^2);
velocity = sqrt(tangentVectors(1:len,1).^2 + tangentVectors(1:len,2).^2);
tangentJerk = (jerkVectors(1:len,1) .* tangentVectors(1:len,1) + jerkVectors(1:len,2) .* tangentVectors(1:len,2)).^2 ./ velocity;
normalJerk =  (jerkVectors(1:len,2) .* tangentVectors(1:len,1) - jerkVectors(1:len,1) .* tangentVectors(1:len,2)).^2 ./ velocity;

% Fixing the cases where velocity is 0, they add 0 jerk to each coordinate:
tangentJerk(velocity==0)=0;
normalJerk(velocity==0)=0;

jerkIntegral = sum(jerk.*samplingRate);
cumJerkIntegral = cumsum(jerk.*samplingRate);
tangentJerkIntegral = sum(tangentJerk.*samplingRate);
normalJerkIntegral = sum(normalJerk.*samplingRate);
end
function mrotated = ApplyZ3(m,i)
baseTheta = 2*pi/3;
mrotated = ApplyGroup(m,'rotations',baseTheta*i);
end

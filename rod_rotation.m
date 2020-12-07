function m = rod_rotation(v, th)
% This function returns a 3x3 rotation matrix that specifies the rotation
% of a point around a given axis v by an angle th
% m is the resulting rotation matrix
% th must be in radians
k = [0 -v(3) v(2); v(3) 0 -v(1); -v(2) v(1) 0]; % skew symmetric matrix
m = eye(3) + sin(th)*k + (1-cos(th))*(k*k);
end
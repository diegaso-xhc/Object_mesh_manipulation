function xr = rotPoints(x, th, ax)
% This function takes a set of points and rotates them with respect to one
% of the three cartesian axes

% x are the original points in the format of n x 3
% th is the angle of rotation in degrees
% ax is the axis of rotation (1 for x, 2 for y and 3 for z)
x = x'; % We set the points to the format of 3 x n
th = th*pi/180; % We set the angle in radians
if ax == 1
    R = [1 0 0; 0 cos(th) -sin(th); 0 sin(th) cos(th)];
elseif ax == 2
    R = [cos(th) 0 sin(th); 0 1 0; -sin(th) 0 cos(th)];
else 
    R = [cos(th) -sin(th) 0; sin(th) cos(th) 0; 0 0 1];
end
xr = R*x;
xr = xr'; % The points are returned in the same format as the input n x 3
end
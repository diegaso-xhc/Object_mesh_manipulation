function k = get_point(X, p)
% This function finds the index of the closest point to the coordinates
% given by the vector inp
[k dist] = dsearchn(X, p);
end
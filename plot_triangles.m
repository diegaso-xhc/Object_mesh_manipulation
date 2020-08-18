function plot_triangles(TR, t)
% This function plots the triangles we are interested in
trisurf(TR.ConnectivityList(t,:), TR.Points(:, 1), TR.Points(:, 2), TR.Points(:, 3));
end
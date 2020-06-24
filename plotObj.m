function plotObj(obj)
%%%% This is a function that allows you to plot a triangular mesh, provided
%%%% that you already have the detailed information from the .obj file of
%%%% an object's mesh. Please refer to the function readObj for more
%%%% information.

f = obj.f.v; % This is the information from the order of connection of the vertices of the triangles of our mesh
% f = zeros(length(f_init), 3);
% f(:, 1) = f_init(:, 3);
% f(:, 2) = f_init(:, 1);
% f(:, 3) = f_init(:, 2);

v = obj.v; % This is the information from the vertices of the triangles of our mesh
lf = length(f);

figure;
for i = 1: lf
    v1 = [v(f(i, 1), 1), v(f(i, 1), 2), v(f(i, 1), 3)];
    v2 = [v(f(i, 2), 1), v(f(i, 2), 2), v(f(i, 2), 3)];
    v3 = [v(f(i, 3), 1), v(f(i, 3), 2), v(f(i, 3), 3)];
    plot3([v1(1) v2(1)], [v1(2) v2(2)], [v1(3) v2(3)])
    if i == 1
        hold on
    end
    plot3([v1(1) v3(1)], [v1(2) v3(2)], [v1(3) v3(3)])
    plot3([v2(1) v3(1)], [v2(2) v3(2)], [v2(3) v3(3)])
end
min_axes = min([min(v(:, 1)), min(v(:, 2)), min(v(:, 3))]);
max_axes = max([max(v(:, 1)), max(v(:, 2)), max(v(:, 3))]);

xlim([min_axes max_axes])
ylim([min_axes max_axes])
zlim([min_axes max_axes])
pbaspect([1 1 1])
end
function plotContactRegionsFingers_v2(y, col_vec)
ncs = size(y, 2);
for j = 1: ncs
    y{j}.plotPoints(1, col_vec);
    y{j}.plotNormals(1);
    hold on
end
end

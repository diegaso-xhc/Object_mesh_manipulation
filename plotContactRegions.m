function plotContactRegions(obj, y)
nob = length(y);
nfgs = length(y{1});
for i = 1: nob
    for j = 1: nfgs
        ncs = length(y{i}{j});
        for k = 1: ncs
            plot3(obj.Points(y{i}{j}{k}, 1), obj.Points(y{i}{j}{k}, 2), obj.Points(y{i}{j}{k}, 3), '*', 'Color', [rand,rand,rand]);
%             plot3(obj.Points(y{i}{j}{k}, 1), obj.Points(y{i}{j}{k}, 2), obj.Points(y{i}{j}{k}, 3), '*c');
            hold on
        end
    end
end
end
function plotContactRegions(y)
nob = length(y);
nfgs = length(y{1});
for i = 1: nob
    for j = 1: nfgs
        ncs = length(y{i}{j});
        for k = 1: ncs
            y{i}{j}{k}.plotPoints(1);
            y{i}{j}{k}.plotNormals(1);            
            hold on
        end
    end
end
end
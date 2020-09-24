function showContacts(obj, fings, th, type_op) 
% This function receives triangulations or cells of triangulations. Then it
% plots or returns the contact regions on the object, depending on the
% fingers and their positions with respect to the object and a given
% threshold. 
%
% obj is the triangulation of the object
% fings is a cell of triangulations that are in contact with the object
% th is a threshold of the distance from the surface of the object to the
%   fingers and it can be customized to improve accuracy on the contact
%   region
n1 = length(obj);
shp_obj = {};
for i = 1: n1
   shp_obj{i} =  alphaShape(obj{i}.Points); % We define an alpha shape for each triangulation of the objects
end
n2 = length(fings);
shp_fings = {};
for i = 1: n2
   shp_fings{i} = alphaShape(fings{i}.Points); % We define an alpha shape for each triangulation of the fingers
end
in_d = cell(n1, n2, 2); % This is a cell which will contain the information on the nearest points and the distances from the object, given a threshold
p = cell(n1, n2);
for i = 1: n1    
    figure(i);
    subplot(1, 2, 1)
    h(i) = trimesh(obj{i});
    h(i).EdgeColor = [0, 0, 0];
    hold on
    for j = 1: n2     
        if strcmp(type_op, 'near')
            [in_d{i, j, 1}, in_d{i, j, 2}] = nearestNeighbor(shp_obj{i}, fings{j}.Points);
            in_d{i, j, 1} = in_d{i, j, 1}(find(in_d{i, j, 2} < th));
            in_d{i, j, 2} = in_d{i, j, 2}(find(in_d{i, j, 2} < th));
            p{i, j} = obj{i}.Points(in_d{i, j, 1}, :);
            indices = in_d{i, j, 1};
        elseif strcmp(type_op, 'in')
            [in_d{i, j, 1}, in_d{i, j, 2}] = inShape(shp_fings{j}, obj{i}.Points);
            indices = find(in_d{i, j, 1} == 1);            
            in_d{i, j, 1} = in_d{i, j, 1}(indices);
            in_d{i, j, 2} = in_d{i, j, 2}(indices);
            p{i, j} = obj{i}.Points(indices, :);
        end
        
        v = vertexAttachments(obj{i}, indices); %returns the IDs of the triangles or tetrahedra attached to the vertices specified in ID. The vertex IDs in ID are the row numbers of the corresponding vertices in the property TR.Points.
        lv = length(v);
        vec = v{1, :};        
        for t = 2: lv
            vec = [vec, v{t, :}]; 
        end
        vec = unique(vec); 
        
        
        subplot(1, 2, 1)
        pl(j) = trisurf(obj{1}.ConnectivityList(vec,:), obj{1}.Points(:, 1), obj{1}.Points(:, 2), obj{1}.Points(:, 3));
        pl(j).FaceColor = [0.4, 0.2, 0.9];        
        plot3(p{i,j}(:, 1),p{i,j}(:, 2),p{i,j}(:, 3), '*r');
        axis('equal')
        
        
        subplot(1, 2, 2)       
        k(j) = trimesh(fings{j});
        k(j).EdgeColor = [0, 0, 0];  
        k(j).EdgeAlpha = 0.2;
        k(j).FaceAlpha = 0.1;                        
        hold on
        plot3(p{i,j}(:, 1),p{i,j}(:, 2),p{i,j}(:, 3), '*r');
    end
    subplot(1, 2, 1)
    hold off
    
    subplot(1, 2, 2)
    g(i) = trimesh(obj{i});
    g(i).EdgeColor = [0.22, 0.54, 0.84];    
    g(i).EdgeAlpha = 1;    
    axis('equal')
    hold off
end
end
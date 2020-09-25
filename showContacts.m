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
n1 = length(obj); % Number of objects
shp_obj = {}; % A cell which will contain all of the alpha shapes
for i = 1: n1
    shp_obj{i} =  alphaShape(obj{i}.Points); % We define an alpha shape for each triangulation of the objects
end
n2 = length(fings); % Number of fingers
shp_fings = {}; % A cell containing the alpha shapes of the fingers
for i = 1: n2
    shp_fings{i} = alphaShape(fings{i}.Points); % We define an alpha shape for each triangulation of the fingers
end
in_d = cell(n1, n2, 2); % This is a cell which will contain the information on the nearest points and the distances from the object, given a threshold
p = cell(n1, n2); % A cell containing the contact points between the each object and the fingers
for i = 1: n1
    figure(i); % These plots can be arranged accordingly. Initially there will be two plots (one with the objects and contact surfaces and the second one
    % with the same info plus the fingers)
    subplot(1, 2, 1)
    h(i) = trimesh(obj{i});
    h(i).EdgeColor = [0, 0, 0];
    hold on
    for j = 1: n2
        if strcmp(type_op, 'near')
            neigh = 2;
            for t = 1: neigh
                [in_d{i, j, 1}, in_d{i, j, 2}] = knnsearch(obj{i}.Points, fings{j}.Points, 'K', neigh); % We calculate the nearest neighbors on the object to the fingers
                % the following if statement allows us to add all of the
                % k-nearest neighbors to a single vector for further
                % processing
                if t == 1
                    tmp_1 = in_d{i, j, 1}(:, 1);
                    tmp_2 = in_d{i, j, 2}(:, 1);
                else
                    tmp_1 = [tmp_1; in_d{i, j, 1}(:, t)];
                    tmp_2 = [tmp_2; in_d{i, j, 2}(:, t)];
                end
                in_d{i, j, 1} = tmp_1;
                in_d{i, j, 2} = tmp_2;              
                in_d{i, j, 1} = in_d{i, j, 1}(find(in_d{i, j, 2} < th)); % Given a certain threshold, we remove the points which are too far away
                in_d{i, j, 2} = in_d{i, j, 2}(find(in_d{i, j, 2} < th)); % Given a certain threshold, we remove the points which are too far away
                [in_d{i, j, 1}, tempa, tempc] = unique(in_d{i, j, 1}); % Gathering he unique vector and further using the indices from it
                in_d{i, j, 2} = in_d{i, j, 2}(tempa, :);
                p{i, j} = obj{i}.Points(in_d{i, j, 1}, :); % We add the contact points to the aforementioned cell p
                indices = in_d{i, j, 1}; % This is important to later find the triangles connected to a given point
            end                                
                
%             [in_d{i, j, 1}, in_d{i, j, 2}] = knnsearch(obj{i}.Points, fings{j}.Points, 'K', 2); % We calculate the nearest neighbors on the object to the fingers            
%             in_d{i, j, 1} = [in_d{i, j, 1}(:, 1); in_d{i, j, 1}(:, 2)];            
%             in_d{i, j, 2} = [in_d{i, j, 2}(:, 1); in_d{i, j, 2}(:, 2)];
%             in_d{i, j, 1} = in_d{i, j, 1}(find(in_d{i, j, 2} < th)); % Given a certain threshold, we remove the points which are too far away
%             in_d{i, j, 2} = in_d{i, j, 2}(find(in_d{i, j, 2} < th)); % Given a certain threshold, we remove the points which are too far away            
%             [in_d{i, j, 1}, tempa, tempc] = unique(in_d{i, j, 1});           
%             in_d{i, j, 2} = in_d{i, j, 2}(tempa, :);            
%             p{i, j} = obj{i}.Points(in_d{i, j, 1}, :); % We add the contact points to the aforementioned cell p
%             indices = in_d{i, j, 1}; % This is important to later find the triangles connected to a given point 

%             
%             [in_d{i, j, 1}, in_d{i, j, 2}] = nearestNeighbor(shp_obj{i}, fings{j}.Points); % We calculate the nearest neighbors on the object to the fingers
%             in_d{i, j, 1} = in_d{i, j, 1}(find(in_d{i, j, 2} < th)); % Given a certain threshold, we remove the points which are too far away
%             in_d{i, j, 2} = in_d{i, j, 2}(find(in_d{i, j, 2} < th)); % Given a certain threshold, we remove the points which are too far away
%             p{i, j} = obj{i}.Points(in_d{i, j, 1}, :); % We add the contact points to the aforementioned cell p
%             indices = in_d{i, j, 1}; % This is important to later find the triangles connected to a given point

        elseif strcmp(type_op, 'in')
            [in_d{i, j, 1}, in_d{i, j, 2}] = inShape(shp_fings{j}, obj{i}.Points); % We check if there are points on the object which are inside the fingers
            indices = find(in_d{i, j, 1} == 1); % We get the indices of the points which are inside
            in_d{i, j, 1} = in_d{i, j, 1}(indices); % We filter the points depending on these points
            in_d{i, j, 2} = in_d{i, j, 2}(indices); % We filter the points depending on these points
            p{i, j} = obj{i}.Points(indices, :); % We add the contact points to the aforementioned cell p
        end
        
        %%%%%%%%%% Get triangles related to the points of interest%%%%%%%%%
        v = vertexAttachments(obj{i}, indices); % returns the IDs of the triangles or tetrahedra attached to the vertices specified in indices.
        % The vertex IDs in indices are the row numbers of the corresponding vertices in obj.Points.
        % The following code lines allow us to get a unique set of
        % triangles depending on the given set of points of interest
        lv = length(v);
        vec = {};
        if lv~= 0
            vec{j} = v{1, :};
            for t = 2: lv
                vec{j} = [vec{j}, v{t, :}];
            end
            vec{j} = unique(vec{j});  
            subplot(1, 2, 1)
            % The following lines plot the triangles of interest
            pl(j) = trisurf(obj{1}.ConnectivityList(vec{j},:), obj{1}.Points(:, 1), obj{1}.Points(:, 2), obj{1}.Points(:, 3));
            pl(j).FaceColor = [0.25, 0.2, 0.9];
            plot3(p{i,j}(:, 1),p{i,j}(:, 2),p{i,j}(:, 3), '*r');
            axis('equal')
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
        
        
        subplot(1, 2, 2)
        % The following lines plot the fingers
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
    % The following lines plot the objects
    g(i) = trimesh(obj{i});
    g(i).EdgeColor = [0.32, 0.64, 0.74];
    g(i).EdgeAlpha = 1;
    axis('equal')
    hold off
end
end
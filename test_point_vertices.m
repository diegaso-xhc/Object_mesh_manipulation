clear all
close all
clc

%% Load the mesh file and plot it 
% addpath('C:\Users\ge97vos\Desktop\Diego\Research\Experiment\Objects')
obj = readObj('Videotape.obj');
vector_switch = [3 1; 1 2; 2 3]; % 3 goes to 1, 1 goes to 2 and so weiter
temp = obj.v;
for i = 1: 3 % Only three dimensions to plot    
    obj.v(:, vector_switch(i, 2)) = temp(:, vector_switch(i, 1));    
end
TR = triangulation(obj.f.v, obj.v); % Make a triangulation of the aforementioned object parameters
h = trimesh(TR);
h.EdgeColor = [0, 0, 0];
% plotObj(obj) % Function to plot a mesh (own and natürlich nicht so optimal)
xlabel('X')
ylabel('Y')
zlabel('Z')
hold on
grid on

%% Test contact surfaces based on a point
x = 100;
y = 80;
z = 70;
plot3(x, y, z, '*')
% TR = triangulation(obj.f.v, obj.v); % Make a triangulation of the aforementioned object parameters
ID = nearestNeighbor(TR, x, y, z); % Find the closest vertex on this triangulation from a given point
C = TR.Points(ID, :); % Coordinates of the closest point
[row, col] = find(obj.f.v == ID); % Finding the triangles which are connected to the closest point
plot3M = @(XYZ,varargin) plot3(XYZ(:,1),XYZ(:,2),XYZ(:,3),varargin{:}); % Declaring a function for plotting

f = [1 2 3];
for i = 1: length(row)
   for j = 1: 3 % For a triangular mesh
        v(j, :) = obj.v(obj.f.v(row(i), j), :); % Retrieve the information from the connectivity list and take the coordinates of these points to store them in v
   end   
   FV.faces = f; % A temporal connectivity list
   FV.vertices = v; % Adding the vertices extracted before
   points = [x,y,z]; % Formatting the query point for the next function
   [distances(i, 1), surface_points(i, :)] = point2trimesh(FV, 'QueryPoints', points); % Gathering the distance to the triangular surfaces connected to the closest vertex
end
distances=abs(distances); % Only interested in absolute values
[val, id_min] = min(distances); % We get the closest triangle

for i = 1: 3 % Triangular mesh
   vertices(i, :) = obj.v(obj.f.v(row(id_min), i), :); % Retrieve the coordinates from the aforementioned surface
end
% trisurf(FV.faces,FV.vertices(:, 1),FV.vertices(:, 2),FV.vertices(:, 3))
h2 = trisurf([1 2 3], vertices(:, 1), vertices(:, 2), vertices(:, 3)); % Plot and paint the triangular surface
h2.FaceColor = [0.2, 0.3, 0.9];
plot3M(points,'*r') % Plot the initial point
plot3M(surface_points(id_min, :),'*k') % Plot the projection point
xlim([0 220])
ylim([0 220])
zlim([0 220])
pbaspect([1 1 1])


%% Find a path from triangle 1 to triangl 2
nt = length(TR.ConnectivityList);
for i = 1: nt % In this for loop, we calculate the centroids of all the triangles on the mesh
   centroids(i, :) = (1/3)*(TR.Points(TR.ConnectivityList(i , 1), :) + ...
       TR.Points(TR.ConnectivityList(i , 2), :) + ...
       TR.Points(TR.ConnectivityList(i , 3), :));   
end
str = 'side';
% plot3M(centroids,'*c') % Plot the centroids
% t = [10 70];
% out_trn = follow_path(TR, t(1), t(2), centroids, str);
% for i = 1: length(out_trn)
%    plot_triangles(TR, [out_trn(i)]); 
% end
% h3 = trisurf(TR.ConnectivityList(out_trn,:), TR.Points(:, 1), TR.Points(:, 2), TR.Points(:, 3));
% h3 = trisurf(TR.ConnectivityList(out_trn,:), TR.Points(:, 1), TR.Points(:, 2), TR.Points(:, 3));
% h3.FaceColor = [0.3, 0.7, 0.9];
% plot3M(centroids(t,:),'*c') % Plot the centroids

% plot_triangles(TR, [140])
% plot_triangles(TR, [141])
% plot_triangles(TR, [142])
% plot_triangles(TR, [237])
% plot_triangles(TR, [1500])

%% Find the area between a set of points on the mesh
t = [410 115 1120 830];
% t = [1 20 50 450];
plot3M(centroids(t,:),'*c') % Plot the centroids

% % out_trn = find_area(TR, t, centroids, str);
% % h4 = trisurf(TR.ConnectivityList(out_trn,:), TR.Points(:, 1), TR.Points(:, 2), TR.Points(:, 3));
% % h4.FaceColor = [0.1, 0.2, 0.9];

out_trn = select_area(TR, t, centroids, str);
h5 = trisurf(TR.ConnectivityList(out_trn,:), TR.Points(:, 1), TR.Points(:, 2), TR.Points(:, 3));
h5.FaceColor = [0.03, 0.6, 0.2];


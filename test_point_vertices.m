clear all
close all
clc

%% Load the mesh file and plot it 
addpath('C:\Users\ge97vos\Desktop\Diego\Research\Experiment\Objects')
obj = readObj('Videotape.obj');
vector_switch = [3 1; 1 2; 2 3]; % 3 goes to 1, 1 goes to 2 and so weiter
temp = obj.v;
for i = 1: 3 % Only three dimensions to plot    
    obj.v(:, vector_switch(i, 2)) = temp(:, vector_switch(i, 1));    
end
plotObj(obj)
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
TR = triangulation(obj.f.v, obj.v);
ID = nearestNeighbor(TR, x, y, z);
C = TR.Points(ID, :);
[row, col] = find(obj.f.v == ID);
plot3M = @(XYZ,varargin) plot3(XYZ(:,1),XYZ(:,2),XYZ(:,3),varargin{:});

f = [1 2 3];
for i = 1: length(row)
   for j = 1: 3 % For a triangular mesh
        v(j, :) = obj.v(obj.f.v(row(i), j), :);
   end   
   f
   v
   FV.faces = f;
   FV.vertices = v;
   points = [x,y,z];
   [distances(i, 1), surface_points(i, :)] = point2trimesh(FV, 'QueryPoints', points);
end
distances=abs(distances);
[val, id_min] = min(distances);
for i = 1: 3 % Triangular mesh
   vertices(i, :) = obj.v(obj.f.v(row(id_min), i), :);
end
% trisurf(FV.faces,FV.vertices(:, 1),FV.vertices(:, 2),FV.vertices(:, 3))
trisurf([1 2 3], vertices(:, 1), vertices(:, 2), vertices(:, 3))
plot3M(points,'*r')
plot3M(surface_points(id_min, :),'*k')
xlim([0 300])
ylim([0 300])
zlim([0 100])
pbaspect([1 1 1])






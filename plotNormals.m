function plotNormals(obj)
% This function allows us to plot the normals on the points of a
% triangulation, hence a mesh.
VNorm = 3*vertexNormal(obj);
h = trimesh(obj);
h.EdgeColor = [0, 0, 0];
hold on
quiver3(obj.Points(:,1),obj.Points(:,2),obj.Points(:,3), ...
    VNorm(:,1),VNorm(:,2),VNorm(:,3),0,'Color','r');
axis('equal')
hold off
end
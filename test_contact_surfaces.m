clear all
close all
clc

% load('objects_db.mat'); % Import meshes from file to the workspace
% finger = svVar{8, 1};
% temp_p = finger.Points;
% temp_p(:, 2) = temp_p(:, 2) - 8;
% finger = triangulation(finger.ConnectivityList, temp_p);
% %% In this section we choose the object we want to test
% object = svVar{9, 1};

%% Here we plot the two objects
% h = trimesh(finger);
% h.EdgeColor = [0, 0, 0];
% hold on
% h = trimesh(object);
% h.EdgeColor = [0, 0, 0];
% xlabel('X')
% ylabel('Y')
% zlabel('Z')
% grid on
% axis('equal')

%% Check if one of the objects is inside the other one
% shp = alphaShape(object.Points);
% in = inShape(shp, finger.Points);
% in_obj = find(in == 1);
% p = finger.Points(in_obj, :);
% figure;
% 
% h = trimesh(finger);
% h.EdgeColor = [0, 0, 0];
% hold on
% plot3(p(:, 1),p(:, 2),p(:, 3), '*r');
% axis('equal')
% 
% 
% shp = alphaShape(finger.Points);
% in = inShape(shp, object.Points);
% in_obj = find(in == 1);
% p = object.Points(in_obj, :);
% 
% figure;
% h = trimesh(object);
% h.EdgeColor = [0, 0, 0];
% hold on
% plot3(p(:, 1),p(:, 2),p(:, 3), '*r');
% axis('equal')
% figure;
% sh = alphaShape(p, inf);
% plot(sh)

% shp = alphaShape(object.Points); 
% [in, d] = nearestNeighbor(shp, finger.Points);
% threshold = 3; % This is the distance in mm
% in = in(find(d < threshold));
% % in_obj = find(in == 1);
% in_obj = in;
% p = object.Points(in_obj, :);
% figure;
% 
% h = trimesh(object);
% h.EdgeColor = [0, 0, 0];
% hold on
% plot3(p(:, 1),p(:, 2),p(:, 3), '*r');
% axis('equal')

%% Testing the contact surface plotting function
load('objects_db.mat'); % Import meshes from file to the workspace
finger = svVar{8, 1};

temp_p = finger.Points;
temp_p = rotPoints(temp_p, 90, 1);
temp_p = rotPoints(temp_p, -10, 3);
temp_p(:, 1) = temp_p(:, 1) + 20;
temp_p(:, 2) = temp_p(:, 2) + 43;
fings{1} = triangulation(finger.ConnectivityList, temp_p);

temp_p = finger.Points;
temp_p(:, 2) = temp_p(:, 2) + 66;
fings{2} = triangulation(finger.ConnectivityList, temp_p);

temp_p = finger.Points;
temp_p(:, 2) = temp_p(:, 2) - 20;
temp_p(:, 3) = temp_p(:, 3) + 42;
fings{3} = triangulation(finger.ConnectivityList, temp_p);

temp_p = finger.Points;
temp_p = rotPoints(temp_p, -90, 2);
temp_p(:, 1) = temp_p(:, 1) + 100;
temp_p(:, 2) = temp_p(:, 2) + 40;
temp_p(:, 3) = temp_p(:, 3) + 82;
fings{4} = triangulation(finger.ConnectivityList, temp_p);


% temp_p = finger.Points;
% temp_p(:, 2) = temp_p(:, 2) - 10;
% temp_p(:, 1) = temp_p(:, 1) + 0;
% fings{1} = triangulation(finger.ConnectivityList, temp_p);

object = cell(1, 1);
object{1} = svVar{9, 1};
th = 1.0;

showContacts(object, fings, th, 'near') 

%% In this section we choose the object we want to test

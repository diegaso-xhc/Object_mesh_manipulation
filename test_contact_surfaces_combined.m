clear all
close all
clc

%% Testing the contact surface plotting function
load('objects_db.mat'); % Import meshes from file to the workspace

%% Setting finger positions

finger = svVar{8, 1};

temp_p = finger.Points;
temp_p = rotPoints(temp_p, 90, 1);
temp_p = rotPoints(temp_p, -10, 3);
temp_p(:, 1) = temp_p(:, 1) + 20;
temp_p(:, 2) = temp_p(:, 2) + 43;
fings{1} = triangulation(finger.ConnectivityList, temp_p);

temp_p = finger.Points;
temp_p(:, 2) = temp_p(:, 2) + 60;
fings{2} = triangulation(finger.ConnectivityList, temp_p);

temp_p = finger.Points;
temp_p(:, 2) = temp_p(:, 2) - 20;
temp_p(:, 3) = temp_p(:, 3) + 42;
fings{3} = triangulation(finger.ConnectivityList, temp_p);

temp_p = finger.Points;
temp_p = rotPoints(temp_p, -90, 2);
temp_p(:, 1) = temp_p(:, 1) + 133;
temp_p(:, 2) = temp_p(:, 2) + 20;
temp_p(:, 3) = temp_p(:, 3) + 125;
fings{4} = triangulation(finger.ConnectivityList, temp_p);

temp_p = finger.Points;
temp_p = rotPoints(temp_p, 180, 1);
temp_p = rotPoints(temp_p, 90, 3);
temp_p(:, 1) = temp_p(:, 1) + 70;
temp_p(:, 2) = temp_p(:, 2) + 30;
temp_p(:, 3) = temp_p(:, 3) + 105;
fings{5} = triangulation(finger.ConnectivityList, temp_p);

%% Setting the object

object = cell(1, 1);
object{1} = svVar{11, 1};
temp_p = object{1}.Points;
% temp_p(:, 1) = temp_p(:, 1) - 120;
object{1} = triangulation(object{1}.ConnectivityList, temp_p);
th = 2.0;

%% Getting contact surfaces


[yf y] = getContactSurfacesFingers(object, fings, th, 'both');





%% In this section we choose the object we want to test
plotManipulationFinger(object, y, fings, yf)
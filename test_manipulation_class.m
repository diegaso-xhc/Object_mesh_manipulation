clear all
close all
clc

%% Testing the contact surface plotting function
load('objects_db_noT.mat'); % Import meshes from file to the workspace
load('T750.mat');
load('T750index.mat');

finger_points = svVar_noT{8, 2};
finger_conn = svVar_noT{8, 1};
p = [106.972, 15.5711, 53.7523];
k = get_point(finger_points, p);
temp_p = rotPoints(finger_points, 180, 3);
Tsi = [T750(1:3,1:3), (data{1}(1,:) - temp_p(k,:))'];
Tsi = [Tsi; [0 0 0 1]];
Tif = [rod_rotation([0 1 0], data{2}(3,1)*pi/180) [0 0 0]';0 0 0 1];
Tia = [rod_rotation([0 0 1], data{2}(4,1)*pi/180) [0 0 0]';0 0 0 1];
T = Tsi*Tif*Tia;
temp_p = movePoints(temp_p, T);


% temp_p = rotPoints(temp_p, ax);
% temp_p = rotPoints(temp_p, 90, 3);
% temp_p(:, 1) = temp_p(:, 1) + 20;
% temp_p(:, 2) = temp_p(:, 2) + 43;
subplot(1,2,1)
trimesh(triangulation(finger_conn, finger_points))
xlabel('X')
ylabel('Y')
subplot(1,2,2)
trimesh(triangulation(finger_conn, temp_p))
xlabel('X')
ylabel('Y')


fings{1} = triangulation(finger_conn, temp_p);





temp_p = finger_points;
temp_p = rotPoints(temp_p, 90, 1);
temp_p = rotPoints(temp_p, -10, 3);
temp_p(:, 1) = temp_p(:, 1) + 20;
temp_p(:, 2) = temp_p(:, 2) + 43;
fings{1} = triangulation(finger_conn, temp_p);

temp_p = finger_points;
temp_p(:, 2) = temp_p(:, 2) + 60;
fings{2} = triangulation(finger_conn, temp_p);
% fings{1} = triangulation(finger.ConnectivityList, temp_p);

temp_p = finger_points;
temp_p(:, 2) = temp_p(:, 2) - 20;
temp_p(:, 3) = temp_p(:, 3) + 42;
fings{3} = triangulation(finger_conn, temp_p);
% fings{1} = triangulation(finger.ConnectivityList, temp_p);

temp_p = finger_points;
temp_p = rotPoints(temp_p, -90, 2);
temp_p(:, 1) = temp_p(:, 1) + 105;
temp_p(:, 2) = temp_p(:, 2) + 25;
temp_p(:, 3) = temp_p(:, 3) + 100;
fings{4} = triangulation(finger_conn, temp_p);
% fings{1} = triangulation(finger.ConnectivityList, temp_p);

temp_p = finger_points;
temp_p = rotPoints(temp_p, 180, 1);
temp_p = rotPoints(temp_p, 90, 3);
temp_p(:, 1) = temp_p(:, 1) + 70;
temp_p(:, 2) = temp_p(:, 2) + 30;
temp_p(:, 3) = temp_p(:, 3) + 105;
fings{5} = triangulation(finger_conn, temp_p);
% fings{1} = triangulation(finger.ConnectivityList, temp_p);

obj_points = svVar_noT{9, 2};
obj_conn = svVar_noT{9, 1};
temp_p = obj_points;
object{1} = triangulation(obj_conn, temp_p);

th = 2.0;

man1 = Manipulation(object, fings, th, 'both');
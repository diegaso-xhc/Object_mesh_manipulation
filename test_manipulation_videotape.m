clear all
close all
clc

%% Testing the contact surface plotting function

% vector_switch = [3 1; 1 2; 2 3]; % 3 goes to 1, 1 goes to 2 and so weiter

% name = ["Videotape.obj", "Finger750.obj"];
% n = length(name);
% mesh = cell(n, 2); % Create a cell that will contain the information of the triangulations of all objects
% for i = 1: n
%     filename = name(i);
%     obj = readObj(filename);
%     temp = obj.v;
%     for j = 1: 3 % Only three dimensions to plot
%         obj.v(:, vector_switch(j, 2)) = temp(:, vector_switch(j, 1)); % Switch the axes of the vectors resulting from solidworks
%     end
%     mesh{i, 1} = obj.f.v; % Connectivity list information
%     mesh{i, 2} = obj.v; % Points
%     mesh{i, 3} = filename; % File name
%     mesh{i, 4} = i; % This is the identification number on the list    
% end
% save('videotape_touch.mat','mesh')
load('videotape_touch.mat');
load('T2000.mat');
load('T2000index.mat');

finger_points = mesh{2, 2};
finger_conn = mesh{2, 1};
p = [107.683, 15.5711, 53.7523];
k = get_point(finger_points, p);
temp_p = rotPoints(finger_points, 180, 3);
Tins = [eye(3), (- temp_p(k,:))'; [0 0 0 1]];
temp_p = movePoints(temp_p, Tins);

% T = [eye(3), (data{1}(1,:) - temp_p(k,:))'; [0 0 0 1]];
Tsi = [T2000(1:3,1:3), (data{1}(1,:) - temp_p(k,:))'];
Tsi = [Tsi; [0 0 0 1]];
Tif = [rod_rotation([0 1 0], data{2}(1,2)*pi/180) [0 0 0]';0 0 0 1];
Tia = [rod_rotation([0 0 1], data{2}(1,3)*pi/180) [0 0 0]';0 0 0 1];
T = Tsi*Tif*Tia;
temp_p = movePoints(temp_p, T);

figure(1);
subplot(1,2,1)
trimesh(triangulation(finger_conn, finger_points))
xlabel('X')
ylabel('Y')
subplot(1,2,2)
h = trimesh(triangulation(finger_conn, temp_p))
h.EdgeColor = [0.1 0.5 0.1];
h.FaceAlpha = 0.1;
h.EdgeAlpha = 0.1;
xlabel('X')
ylabel('Y')

figure(1);hold on
n1=1;plot3(data{1}(n1,1),data{1}(n1,2),data{1}(n1,3),'*b')
n1=2;plot3(data{1}(n1,1),data{1}(n1,2),data{1}(n1,3),'*b')
n1=3;plot3(data{1}(n1,1),data{1}(n1,2),data{1}(n1,3),'*b')
n1=4;plot3(data{1}(n1,1),data{1}(n1,2),data{1}(n1,3),'*b')

fings{1} = triangulation(finger_conn, temp_p);

load('Tob750axes.mat');
pob = [204, 1.7647, 28.2353];
k = get_point(mesh{1,2}, pob);
Tso = [eye(3), (data{1}(2,:) - mesh{1,2}(k,:))'; [0 0 0 1]];
temp_o = movePoints(mesh{1,2}, Tso);

figure(2);
subplot(1,2,1)
trimesh(triangulation(mesh{1,1}, mesh{1,2}))
xlabel('X')
ylabel('Y')
subplot(1,2,2)
g = trimesh(triangulation(mesh{1,1}, temp_o))
g.EdgeColor = [0.1 0.5 0.1];
g.FaceAlpha = 0.1;
g.EdgeAlpha = 0.1;
xlabel('X')
ylabel('Y')

figure(2);hold on
n1=1;plot3(data{1}(n1,1),data{1}(n1,2),data{1}(n1,3),'*b')
n1=2;plot3(data{1}(n1,1),data{1}(n1,2),data{1}(n1,3),'*b')
n1=3;plot3(data{1}(n1,1),data{1}(n1,2),data{1}(n1,3),'*b')
n1=4;plot3(data{1}(n1,1),data{1}(n1,2),data{1}(n1,3),'*b')
n1=5;plot3(data{1}(n1,1),data{1}(n1,2),data{1}(n1,3),'*b')

object{1} = triangulation(mesh{1,1}, temp_o);

th = 2.0;
man1 = Manipulation(object, fings, th, 'both');
figure; man1.plot_manipulation
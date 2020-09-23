clear all
close all
clc

objects = dir('*.obj'); % Read .obj files on the current directory
n = length(objects); % Number of .obj files found on the folder
vector_switch = [3 1; 1 2; 2 3]; % 3 goes to 1, 1 goes to 2 and so weiter
save('objects_db.mat', 'objects')
svVar = cell(n, 2); % Create a cell that will contain the information of the triangulations of all objects
for i = 1: n
    filename = objects(i).name; % Read the object file
    obj = readObj(filename);
    temp = obj.v;
    for j = 1: 3 % Only three dimensions to plot
        obj.v(:, vector_switch(j, 2)) = temp(:, vector_switch(j, 1));
    end
    svVar{i, 1} = triangulation(obj.f.v, obj.v); % Make a triangulation of the aforementioned object parameters
    svVar{i, 2} = filename;
end
save('objects_db.mat', 'svVar')


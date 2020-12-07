clear all
close all
clc

objects = dir('*.obj'); % Read .obj files on the current directory
n = length(objects); % Number of .obj files found on the folder
vector_switch = [3 1; 1 2; 2 3]; % 3 goes to 1, 1 goes to 2 and so weiter
svVar_noT = cell(n, 2); % Create a cell that will contain the information of the triangulations of all objects
for i = 1: n
    filename = objects(i).name; % Read the object file
    obj = readObj(filename);
    temp = obj.v;
    for j = 1: 3 % Only three dimensions to plot
        obj.v(:, vector_switch(j, 2)) = temp(:, vector_switch(j, 1)); % Switch the axes of the vectors resulting from solidworks
    end
    svVar_noT{i, 1} = obj.f.v; % Connectivity list information
    svVar_noT{i, 2} = obj.v; % Points
    svVar_noT{i, 3} = filename; % File name
    svVar_noT{i, 4} = i; % This is the identification number on the list
    i
end
save('objects_db_noT.mat', 'svVar_noT')
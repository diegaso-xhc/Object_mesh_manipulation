clear all
close all
clc

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
grid on
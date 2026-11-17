clc; //clearing the console
clf; //clearing and reseting the figures
clear all; //clearing variable values

x = [0: %pi/16 : 2*%pi]; //defining range from 0 to 2pi
y1 = sin(x); //defining sine function
y2 = cos(x); //defining cosine function

subplot(1,2,1); //defining the subplot of 1X2, index 1
plot(x,y1); //plotting the sine graph
xgrid; //showing the grids in the graph
xlabel('x'); //labelling x axis
ylabel('sin(x)'); //labelling y axis

subplot(1,2,2); //defining the subplot of 1X2, index 2
plot(x,y2); //plotting the cosine graph
xgrid; //showing the grids in the graph
xlabel('x'); //labelling x axis
ylabel('cos(x)'); //labelling y axis

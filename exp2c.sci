clc; //clearing the console
clf; //clearing and reseting the figures
clear all; //clearing variable values

x = [-5: .1: 5]; //defining points from -5 to 5 with step of .1(for smoothness)
y = %e^x; //defining exponential function

plot(x,y); //plotting the graph
xgrid; //showing the grids in the graph
xlabel('x'); //labelling x axis
ylabel('e^x'); //labelling y axis

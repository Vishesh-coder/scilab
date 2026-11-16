clc; //clearing the console
clf; //clearing and reseting the figures
clear all; //clearing variable values

x = [0: 1: 50]; //defining point from 1 to 50 with step of 1
y = x.^2; //defining quadratic function

plot(x,y); //plotting the graph
xgrid; //showing the grids in the graph
xlabel('x'); //labelling x axis
ylabel('x^2'); //labelling y axis

clc; //clearing the console
clf; //clearing and reseting the figures
clear all; //clearing variable values

f = 5000; //defining frequency as 5kHz
vpp = 5; //defining peak to peak voltage as 5v
amp = vpp/2; //defining amplitude as 1/2 of vpp
T = 1/f; //defining time period

dt = T/100; 
t = 0: dt: (4 * T); //defining time for 4 cycles with T/100 steps
y = amp * (2 * (t/T - floor(1/2 + t/T))); //defining ramp function

plot(t, y); //plotting the graph
xgrid(); //showing the grids in the graph
xlabel('Time (s)'); //labelling x axis 
ylabel('Amplitude (V)'); //labelling y axis
title('Periodic Ramp Function'); //giving title

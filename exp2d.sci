clc; //clearing the console
clf; //clearing and reseting the figures
clear all; //clearing variable values

r1 = input("Enter number of rows for Matrix 1: "); //Matrix 1 row input
c1 = input("Enter number of columns for Matrix 1: "); //Matrix 1 column input
A = []; //intializing empty Matrix 1

//taking input of elements of Matrix 1
for i = 1:r1
    for j = 1:c1
        A(i,j) = input("Enter element: ")
    end
end

//displaying Matrix 1
disp("Matrix 1");
disp(A);

r2 = input("Enter number of rows for Matrix 2: "); //Matrix 2 row input
c2 = input("Enter number of columns for Matrix 2: "); //Matrix 2 column input
B = []; //intializing empty Matrix 2

//taking input of elements of Matrix 2
for l = 1:r2
    for m = 1:c2
        B(l,m) = input("Enter element: ")
    end
end

//displaying Matrix 2
disp("Matrix 2");
disp(B);

//display summation
if i == l & j == m then
    disp("Summation of Matrix 1 and 2")
    disp(A + B);
else 
    disp("Summation not possible")
end

clc; clear all;


raw = imread('MTFReference.jpg');
[value, orientation] = userInterface(raw);
disp(value);
disp(orientation);
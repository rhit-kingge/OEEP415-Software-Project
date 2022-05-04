clc; clear variables; close all;

%test code

isValid = true;
P = 8; c = 6;
if c <= 2 || P - c <= 2
    isValid = false;
end
disp(isValid)
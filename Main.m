clc; clear all;


raw = imread('reference image.jpg');
interface = UserInterfaceC(raw)
disp('working');
roi = interface.ROI;
disp('Current ROI:')
disp(roi);
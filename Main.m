clc; clear all;


raw = imread('reference image.jpg');
interface = UserInterfaceC(raw)
disp('working');
disp(interface.ROI);
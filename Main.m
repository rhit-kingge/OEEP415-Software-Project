clc; clear all;


raw = imread('MTFReference.jpg');
interface = UserInterfaceC(raw)
disp(interface.ROI)
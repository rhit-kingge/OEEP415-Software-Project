clc
clear all

%read image and convert to grey
raw=imread('MTFReference.jpg');
img=rgb2gray(raw);

%Creates Gui
fig = uifigure('Name','My figure');
pnl = uipanel(fig);
%Creates button on Gui
btn = uibutton(pnl,'state','Text','Select an Edge');

%Creates image spot and then loads image onto Gui
ima = uiimage(pnl);
ima.ImageSource = 'reference image.jpg';
%try img instead of reference image on line 16 to avoid hard coding

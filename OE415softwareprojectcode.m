clc
clear variables
close all

%read image and convert to grey
raw=imread("reference image.jpg");
img=rgb2gray(raw);

%Creates Gui
fig = uifigure('Name','Select the region of interest');
fig.Position = [1 1 1200 800];
pnl = uipanel(fig, 'Position', [1 1 1200 800]);
%Creates button on Gui
%btn = uibutton(pnl,'state','Text','Select an Edge');

%Creates image spot and then loads image onto Gui
ima = uiimage(pnl, 'Position', [1 1 1200 800]);
ima.ImageSource = 'reference image.jpg';
%try img instead of reference image on line 16 to avoid hard coding

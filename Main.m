clc 
clear variables 
close all

%% Read in image, crop ROI, and convert to gray scale
raw = imread('reference image.jpg');
interface = UserInterfaceC(raw);
roi = interface.ROI;
croppedImage = im2gray(raw(roi(2) + (0:roi(4)), roi(1) + (0:roi(3))));
imshow(croppedImage);

%% Check if selected ROI contains an edge
if checkIfEdge(croppedImage, interface.EdgeOrientation)
    disp('The selected region of interest does contain an edge')
else
    errorWindow.fh = figure('units','pixels',...
                'position',[300 400 340 200],...
                'menubar','none',...
                'name','Error',...
                'NumberTitle','off',...
                'resize','off');
    errorWindow.tx = uicontrol('style','text',...
                 'unit','pix',...
                 'position',[20 20 300 150],...
                 'fontsize',16,...
                 'string','The region you selected contains no edge. Please restart the program and select a new edge.');
    errorWindow.pb = uicontrol('style','push',...
                 'unit','pix',...
                 'position',[20 20 260 30],...
                 'string','Close');
    set(errorWindow.pb,'callback',{@pb_call,errorWindow})  % Set the callback for pushbutton.   
end

%% First estimation of edge location


[centroids, isValid] = findCentroid(croppedImage, interface.EdgeOrientation);
disp("isValid and Centroids")
disp(centroids);disp("isValid");disp(isValid);
if isValid == true

else
    errorWindow.fh = figure('units','pixels',...
        'position',[300 400 340 200],...
        'menubar','none',...
        'name','Error',...
        'NumberTitle','off',...
        'resize','off');
    errorWindow.tx = uicontrol('style','text',...
        'unit','pix',...
        'position',[20 20 300 150],...
        'fontsize',16,...
        'string','The edge is too close to the rim of ROI. Please restart the program and select a new ROI.');
    errorWindow.pb = uicontrol('style','push',...
        'unit','pix',...
        'position',[20 20 260 30],...
        'string','Close');
    set(errorWindow.pb,'callback',{@pb_call,errorWindow})  % Set the callback for pushbutton.
end




image(croppedImage, 'XData', [1 size(centroids, 2)], 'YData', [min(centroids) max(centroids)]);
hold on
% xArray = 1:size(croppedImage, 1);
plot(1:size(croppedImage, 1), centroids);



%% Functions (must be put at the end)
function [] = pb_call(varargin)
        % Callback for the pushbutton.
        errorWindow = varargin{3};  
        close all;
end





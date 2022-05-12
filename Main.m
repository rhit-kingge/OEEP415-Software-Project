clc; clear variables; close all;

%% Read in image, crop ROI, and convert to gray scale
raw = imread('reference image.jpg');
interface = UserInterfaceC(raw);
roi = interface.ROI;
orientation = interface.EdgeOrientation;
croppedImage = im2gray(raw(roi(2) + (0:roi(4)), roi(1) + (0:roi(3))));

%% Check if selected ROI contains an edge
if checkIfEdge(croppedImage, orientation)
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
    uiwait(errorWindow.fh);
    return
end

%% First estimation of edge location
[centroids, isValid] = findCentroid(croppedImage, orientation);
if isValid == true
    imagesc(croppedImage);
    colormap('gray');
    hold on;
    if strcmp(orientation, 'Vertical')
        xArray = 1:size(croppedImage, 1);
        plot(centroids, xArray, 'LineWidth', 1.5, 'Color', 'r');
    else
        yArray = 1:size(croppedImage, 2);
        plot(yArray, centroids, 'LineWidth', 1.5, 'Color', 'r');
    end
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
        'string','The edge is too close to the boundary of the ROI. Please restart the program and select a new ROI.');
    errorWindow.pb = uicontrol('style','push',...
        'unit','pix',...
        'position',[20 20 260 30],...
        'string','Close');
    set(errorWindow.pb,'callback',{@pb_call,errorWindow})  % Set the callback for pushbutton.
    uiwait(errorWindow.fh);
    return
end


%% Determination of the slant gradient

[sz,a] = size(centroids);
gradient = polyfit((1:sz),centroids(1:sz,1),1);
slope = gradient(1);
angle = atand(abs(slope));
m = sz/2;
shift = ((m-(1:sz))*slope);
if strcmp(interface.EdgeOrientation,'Vertical')
    fprintf('The angle of the edge is %f degrees clockwise from vertical.\n',angle);
else
    fprintf('The angle of the edge is %f degrees clockwise from horizontal.\n',angle);
end

newCentroids = secondFindCentroid(croppedImage, shift, orientation);
if strcmp(orientation, 'Vertical')
    xArray = 1:size(croppedImage, 1);
    plot(newCentroids, xArray, 'LineWidth', 1.5, 'Color', 'b');
else
    yArray = 1:size(croppedImage, 2);
    plot(yArray, newCentroids, 'LineWidth', 1.5, 'Color', 'b');
end


%ESF Calculation: For now, I am hard-coding it in as a vertical edge, but
%only because I plan to go over everything later and add a check for edge
%orientation at the beginning of the code that way it isn't checking
%repetitively. -Aerin
R = size(croppedImage, 1); P = size(croppedImage, 2); J = 4*P;
ESF = zeros(J,1); 
for j=1:J
    numerator = 0;
    denominator = 0;
    for r = 1:R
        for p = 1:P
            if abs(p + shift(r) - j/4) < 0.125
                alpha = 1;
            else
                alpha = 0;
            end
            numerator = numerator + croppedImage(r, p)*alpha;
            denominator = denominator + alpha;
        end
    end
    ESF(j,1) = numerator/denominator;
end





%% Functions (must be put at the end)
function [] = pb_call(varargin)
        % Callback for the pushbutton.
        errorWindow = varargin{3};  
        close all;
end




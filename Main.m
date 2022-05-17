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
if strcmp(orientation,'Vertical')
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
title('Selected ROI and 2 Edge Estimations')
legend({'Fisrt Estimation','Final Estiamtion'},'Location','southwest')


%% ESF Calculation: 

ESF = calculateESF(croppedImage, shift, orientation);

figure;
plot(ESF);
title('ESF')

%% LSF

LSF = calculateLSF(croppedImage, ESF, orientation);

figure;
plot(LSF);
title('LSF')

%% MTF

MTF = calculateMTF(LSF);
xVec = findResolution(MTF, croppedImage, orientation);

figure;
plot(xVec, MTF);
title('MTF');
xlabel('Resolution (lp/mm)');
ylabel('MTF Value');
disp("The resolution is:");

%throws error window if visibility is less than 20 %

imin = min(ESF);
imax = max(ESF);
v = (imax-imin)/(imax+imin);
if v < 0.2
    MTFerrorWindow.fh = figure('units','pixels',...
                'position',[300 400 340 200],...
                'menubar','none',...
                'name','Error',...
                'NumberTitle','off',...
                'resize','off');
    MTFerrorWindow.tx = uicontrol('style','text',...
                 'unit','pix',...
                 'position',[20 20 300 150],...
                 'fontsize',16,...
                 'string','Visibility is less than 20 %. Please restart the program and select a new edge.');
    MTFerrorWindow.pb = uicontrol('style','push',...
                 'unit','pix',...
                 'position',[20 20 260 30],...
                 'string','Close');
    set(MTFerrorWindow.pb,'callback',{@pb_call,MTFerrorWindow})  % Set the callback for pushbutton.
    uiwait(MTFerrorWindow.fh);
end


%% Function for button on error window (must be put at the end)
function [] = pb_call(varargin)
        % Callback for the pushbutton.
        errorWindow = varargin{3};  
        close all;
end




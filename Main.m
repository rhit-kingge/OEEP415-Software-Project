clc; clear varialble; close all;

%% Read in image, crop ROI, and convert to gray scale
raw = imread('reference image.jpg');
interface = UserInterfaceC(raw);
roi = interface.ROI;
disp('Current ROI Position:');
disp(roi);

croppedImage = im2gray(raw(roi(2) + (0:roi(4)), roi(1) + (0:roi(3))));
imshow(croppedImage);

%% Check if selected ROI contains an edge
if checkIfEdge(croppedImage)
    disp('The selected region of interest does contain an edge')
else
    disp('The selected region does not contain an edge, try again?')
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

%% Apply Hamming window

windowSize = size(croppedImage);
weightedImage = zeros(windowSize);

if strcmp(interface.EdgeOrientation, 'Vertical')
    hammingWindowVector = hamming(windowSize(2),'symmetric');
    for col = 1: windowSize(2)
        weightedImage(:, col) = croppedImage(:, col) .* hammingWindowVector(col);
    end
else   % Horizontal
    hammingWindowVector = hamming(windowSize(1),'symmetric');
    for row = 1: windowSize(1)
        weightedImage(row, :) = croppedImage(row, :) .* hammingWindowVector(row);
    end
end


%% Functions (must be put at the end)
function [] = pb_call(varargin)
        % Callback for the pushbutton.
        errorWindow = varargin{3};  
        close all;
end





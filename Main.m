clc; clear varialble; close all;


raw = imread('reference image.jpg');
interface = UserInterfaceC(raw);
roi = interface.ROI;
disp('Current ROI Position:');
disp(roi);


croppedImage = im2gray(raw(roi(2) + (0:roi(4)), roi(1) + (0:roi(3))));
imshow(croppedImage);


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

function [] = pb_call(varargin)
        % Callback for the pushbutton.
        errorWindow = varargin{3};  
        close all;
end


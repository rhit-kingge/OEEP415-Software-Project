clc; clear all;


raw = imread('reference image.jpg');
interface = UserInterfaceC(raw);
roi = interface.ROI;
disp('Current ROI Position:');
disp(roi);


croppedImage = raw(roi(2) + (0:roi(4)), roi(1) + (0:roi(3)));
imshow(croppedImage);


if checkIfEdge(croppedImage)
    disp('The selected region of interest does contain an edge')
else
    disp('The selected region does not contain an edge, try again?')
    %Whatever error function we make can be called here
end


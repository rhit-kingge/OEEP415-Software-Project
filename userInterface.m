function [roiMatrix,edgeOrientation] = userInterface(image)
%The input variable should just be the raw image, the output should be the
%ROI of the image and whether the edge is horizontal or vertical.

a = true;
edgeOrientation = 'non-specified'
%img = rgb2gray(image);

%Creates Gui
fig = uifigure('Name','Original Image');

%Creates button on Gui
btn1 = uibutton(fig, 'state');
btn1X = 75; btn1Y = 50; btnWidth = 100; btnHeight = 22;
btn1.Position = [btn1X btn1Y btnWidth btnHeight];
btn1.Text = 'Horizontal Edge';

btn2 = uibutton(fig, 'state');
btn1X = 275;
btn2.Position = [btn1X btn1Y btnWidth btnHeight];
btn2.Text = 'Verical Edge';


btn3X = 175; btn3Y = 20;
btn3Position = [btn3X btn3Y btnWidth btnHeight];
btn3 = uibutton(fig, 'push', 'Position', btn3Position, 'ButtonPushedFcn', @(btn3, event) submitData);
btn3.Text = 'Submit';



%Creates image spot and then loads image onto Gui
%im = uiimage(fig);
%im.ImageSource = image;
%try img instead of reference image on line 16 to avoid hard coding

    function submitData
        disp('Submit Button Pressed')
        a = false;
    end



roiMatrix = 5;
end


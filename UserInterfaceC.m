classdef UserInterfaceC
    
    
    properties
        EdgeOrientation
        image
        ROI
        moveOn = 0;
    end
    
    methods
        function obj = UserInterfaceC(image)
             

            
            fig = uifigure('Name','Select Edge Orientation');
            fig.Position = [1 1 500 100];

            %Creates button on Gui
            btn1X = 75; btn1Y = 50; btnWidth = 100; btnHeight = 22;
            btn1Position = [btn1X btn1Y btnWidth btnHeight];
            btn1 = uibutton(fig, 'push', 'Position', btn1Position, 'ButtonPushedFcn', @(btn1, event) horizontalEdge);
            btn1.Text = 'Horizontal Edge';

            btn1X = 275;
            btn2Position = [btn1X btn1Y btnWidth btnHeight];
            btn2 = uibutton(fig, 'push', 'Position', btn2Position, 'ButtonPushedFcn', @(btn2, event) verticalEdge);
            btn2.Text = 'Verical Edge';

            uiwait(fig);


            function horizontalEdge
               
               disp('Horizontal Button Pressed')
               EdgeOrientation = 'Horizontal';
               imshow('reference image.jpg')
               disp(EdgeOrientation)
               close(fig);
               close all;
            end

            function verticalEdge
               
               disp('Vertical Button Pressed')
               EdgeOrientation = 'Vertical'
               imshow('reference image.jpg')
               ROI = drawrectangle();

               disp('The ROI Position should be:')
               disp(ROI.Position);
               disp(EdgeOrientation)
               close(fig);
               close all;
           end

%             btn3X = 175; btn3Y = 20;
%             btn3Position = [btn3X btn3Y btnWidth btnHeight];
%             btn3 = uibutton(fig, 'push', 'Position', btn3Position, 'ButtonPushedFcn', @(btn3, event) submitData);
%             btn3.Text = 'Submit';

%             im = uiimage(fig, 'Position', [1 100 1200 600]);
%             im.ImageSource = image;

%             function submitData
%                 disp('Submit Button Pressed')
%                 a = false;
%                 
%             end



        end
        
    end
end


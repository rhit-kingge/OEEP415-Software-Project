classdef UserInterfaceC
    
    
    properties
        EdgeOrientation
        image
        ROI
    end
    
    methods
        function obj = UserInterfaceC(image)
            
            fig = uifigure('Name','Original Image');
            fig.Position = [1 1 1200 700];

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

            im = uiimage(fig, 'Position', [1 100 1200 600]);
            im.ImageSource = image;



        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end


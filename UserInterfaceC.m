classdef UserInterfaceC
    
    
    properties
        EdgeOrientation
        image
        ROI
    end
    
    methods
        function obj = UserInterfaceC(inim)
            
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
            btn2.Text = 'Vertical Edge';

            uiwait(fig);


            function horizontalEdge
               disp('Horizontal Button Pressed');
               obj.EdgeOrientation = 'Horizontal';
               imshow(inim);
               obj.ROI = round(drawrectangle().Position);
               close(fig);
               close(figure(1));
            end

            function verticalEdge
               disp('Vertical Button Pressed')
               obj.EdgeOrientation = 'Vertical';
               imshow(inim)
               obj.ROI = round(drawrectangle().Position);
               close(fig);
               close(figure(1));
           end

        end
        
    end
end


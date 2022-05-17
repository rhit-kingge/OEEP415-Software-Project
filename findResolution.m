function [x] = findResolution(MTF, croppedImage, orientation)

if orientation == "horizontal"
    croppedImage = croppedImage';
end
% MTF indices / total pixel number = [cycles(lp)/pixel]
% [cycles(lp)/pixel] * 1 pixel / 3.9*10^-3 mm = [lp/mm]
x = (1:size(MTF, 2))./size(croppedImage, 2)/(3.9E-3);

end


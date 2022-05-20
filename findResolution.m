function [x] = findResolution(MTF, croppedImage, orientation)

if strcmp(orientation, 'Horizontal')
    croppedImage = croppedImage';
end
% MTF indices / total pixel number = [cycles(lp)/pixel]
% [cycles(lp)/pixel] * 1 pixel / 3.9*10^-3 mm = [lp/mm]
x = (1:size(MTF, 2))./size(croppedImage, 2)/(3.9E-3);

end

%Edit for 5.2*10^-3 mm * magnification when using images that were taken
%using cameras in class instead of the 3.9*10^-3 mm.
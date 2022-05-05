function [exists] = checkIfEdge(img, orientation)
%CHECKIFEDGE Summary of this function goes here
%   Detailed explanation goes here
im = imbinarize(img);
%imshow(im)

counter = 0;
if strcmp(orientation, 'Vertical')
    for row = 1:size(im, 1)
        if abs(im(row,1) - im(row, size(im, 2))) > 0
            counter = counter + 1;
        end
    end
    if counter > 0.8*size(im, 1)
        exists = true;
        disp('checkEdge says there is an edge')
    else
        exists = false;
        disp('checkEdge says there is NOT an edge')
    end

else
    for column = 1:size(im,2)
        if abs(im(1, column) - im(size(im,1), column)) > 0
            counter = counter + 1;
        end
    end
    if counter > 0.8*size(im,2)
        exists = true;
    else
        exists = false;
    end
end
end


function [exists] = checkIfEdge(img)
%CHECKIFEDGE Summary of this function goes here
%   Detailed explanation goes here
im = imbinarize(img);
imshow(im)

counter = 0;
disp(size(im, 1));
for row = 1:size(im, 1)
    disp(im(row,1) - im(row, size(im, 2)));
    if im(row,1) - im(row, size(im, 2)) > 0
        counter = counter + 1;
    end
end

if counter > 0.8*size(im, 1)
    exists = true;
    disp('checkEdge says there is an edge')
    return
else
    exists = false;
    disp('checkEdge says there is NOT an edge')
end

end


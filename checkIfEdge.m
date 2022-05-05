function [exists] = checkIfEdge(img, orientation)
%CHECKIFEDGE Summary of this function goes here
%   Detailed explanation goes here
im = imbinarize(img);

%Establishing a counter for determining if there is an edge facing one way
%or the other, otherwise random differences would add up as if an edge
%existed when there was none.
rightcounter = 0;
leftcounter = 0;

%Flipping the matrix if the edge is horizontal, that way we don't need
%duplicated code.
if strcmp(orientation, 'Horizontal')
    im = im';
end


%Checking for differences in intensity, if one side is consistently bright
%where the other is dark.
for row = 1:size(im, 1)
    if im(row,1) - im(row, size(im, 2)) > 0
        rightcounter = rightcounter + 1;
    elseif im(row,1) - im(row, size(im,2)) < 0
        leftcounter = leftcounter + 1;
    end
end

%This tests if a certain portion of the image has contrast left to right,
%currently 90%.
if abs(rightcounter) > 0.9*size(im, 1) || abs(leftcounter) > 0.9*size(im, 1)
    exists = true;
    disp('checkEdge says there is an edge')
else
    exists = false;
    disp('checkEdge says there is NOT an edge')
end

end


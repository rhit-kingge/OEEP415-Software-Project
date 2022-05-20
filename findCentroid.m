function [centroids, isValid] = findCentroid(croppedImage, orientation)


isValid = true;

%Flips the matrix in the case of a horizontal edge so that the same
%calculation can be run without changing anything.
if strcmp(orientation, 'Horizontal')
    croppedImage = croppedImage';
    %croppedImage = imrotate(croppedImage, -90);
end
imagesc(croppedImage); colormap('gray');

totalRows = double(size(croppedImage, 1));
totalColumns = double(size(croppedImage, 2));
centroids = zeros(totalRows, 1);
for row = 1:totalRows
    values = double(croppedImage(row,:));
    hammingVector = values;
    for i = 1:totalColumns
        hammingVector(i) = 0.54 + 0.46 * cos(2*pi*(i-totalColumns/2)/totalColumns);
    end
    numerator = double(0);
    denominator = double(0);
    for column = 1:totalColumns-1
        numerator = numerator + column*(values(1, column+1) - values(1, column))*hammingVector(column);
        denominator = denominator + (values(1, column+1) - values(1, column))*hammingVector(column);
    end


    c = numerator/denominator;
    if c <= 2 || totalColumns - c <= 2
        isValid = false;
    end
    centroids(row) = c;

end

if strcmp(orientation, 'Horizontal')
    %centroids = flip(centroids);
    %disp("centroids have been flipped back");
end

end
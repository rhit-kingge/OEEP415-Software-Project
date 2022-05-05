function [centroids, isValid] = findCentroid(croppedImage, orientation)


isValid = true;

%Flips the matrix in the case of a horizontal edge so that the same
%calculation can be run without changing anything.
if strcmp(orientation, 'Horizontal')
    croppedImage = croppedImage';
end


totalRows = size(croppedImage, 1);
totalColumns = size(croppedImage, 2);
centroids = zeros(totalRows, 1);
for row = 1:totalRows
    values = double(croppedImage(row,:));
    hammingVector = values;
    for i = 1:totalColumns
        hammingVector(i) = 0.54 +0.46 * cos(2*pi*(i-double(totalColumns)/2)/(totalColumns));
    end
    numerator = double(0);
    denominator = double(0);
    for column = 1:totalColumns-1
        numerator = numerator + column*double(values(1, column+1) - values(1, column))*hammingVector(column);
        denominator = denominator + double(values(1, column+1) - values(1, column))*hammingVector(column);
    end


    c = numerator/denominator;
    if c <= 2 || totalColumns - c <= 2
        isValid = false;
    end
    centroids(row) = c;
end
end




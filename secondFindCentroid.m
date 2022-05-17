function [updatedCentroids] = secondFindCentroid(croppedImage, shift, orientation)


if strcmp(orientation, 'Horizontal')
    croppedImage = croppedImage';
end


totalRows = size(croppedImage, 1);
totalColumns = size(croppedImage, 2);
updatedCentroids = zeros(totalRows, 1);
for row = 1:totalRows
    values = double(croppedImage(row,:));
    hammingVector = values;
    for i = 1:totalColumns
        hammingVector(i) = 0.54 +0.46 * cos(2*pi*(i + shift(row) -double(totalColumns)/2)/(totalColumns));
    end
    numerator = double(0);
    denominator = double(0);
    for column = 1:totalColumns-1
        numerator = numerator + column*double(values(1, column+1) - values(1, column))*hammingVector(column);
        denominator = denominator + double(values(1, column+1) - values(1, column))*hammingVector(column);
    end


    c = numerator/denominator;
    
    updatedCentroids(row) = c;
end
end
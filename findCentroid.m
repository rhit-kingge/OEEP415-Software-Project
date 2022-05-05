function [centroids, isValid] = findCentroid(croppedImage, orientation)



totalRows = size(croppedImage, 1);
totalColumns = size(croppedImage, 2);
isValid = true;

if strcmp(orientation, 'Vertical')
%     If the orientation is vertical, there should be a single centroid
%     value for each row even though there might be multiple per column, so
%     this is correct
    centroids = zeros(totalRows, 1);

    % We also will do the calculation for each row, so the loop should
    % indeed be through totalRows
    for row = 1:totalRows


%       This sets a temporary value as a single row, which is correct as we
%       are finding the centroid in that row
        values = double(croppedImage(row,:));
        hammingVector = values;

%       On the selected row, the hamming window needs to be applied to each
%       value, which is each column, so iterating through columns is
%       correct here
        for i = 1:totalColumns
            hammingVector(i) = 0.54 +0.46 * cos(2*pi*(i-double(totalColumns)/2)/(totalColumns));
        end
%         values = hammingVector.*values;
        numerator = double(0);
        denominator = double(0);

%       Here is where I think we are running into the issue, but I'm not
%       sure entirely why. Iterating through the columns is correct, but
%       the end value we are getting is a pixel value that seems to
%       correspond to a y value (height in the image?). So for each row
%       (y-value) we are calculating another height value seemingly? What
%       we need is an X value
%
        for column = 1:totalColumns-1
            numerator = numerator + column*double(values(1, column+1) - values(1, column))*hammingVector(column);
            denominator = denominator + double(values(1, column+1) - values(1, column))*hammingVector(column);
        end




        c = numerator/denominator;
        if c <= 2 || totalColumns - c <= 2
            %isValid = false;
        end
        centroids(row) = c;
    end
else
    centroids = zeros(totalColumns, 1);
    for column = 1:totalColumns
        values = double(croppedImage(:,column));
        hammingVector = values;
        for i = 1:totalRows
            hammingVector(i) = 0.54 +0.46 * cos(2*pi*(i-double(totalRows)*2)/(totalRows/4));
        end
        values = hammingVector.*values;
        numerator = double(0);
        denominator = double(0);
        for row = 1:totalRows-1
            numerator = numerator + row*double(values(row+1, 1) - values(row, 1));
            denominator = denominator + double(values(row+1, 1) - values(row, 1));
        end
        c = numerator/denominator;
        if c <= 2 || totalColumns - c <= 2
            %isValid = false;
        end
        centroids(column) = c;
    end  
end

<<<<<<< HEAD
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
=======
function [centroids, isValid] = findCentroid(croppedImage, orientation)



R = size(croppedImage, 1);
P = size(croppedImage, 2);
isValid = true;

if strcmp(orientation, 'Vertical')
    centroids = zeros(R, 1);
    for r = 1:R
        values = double(croppedImage(r,:));
        hammingVector = values;
        for i = 1:P
            hammingVector(i) = 0.54 +0.46 * cos(2*pi*(i-double(P)/2)/(P));
        end
        values = hammingVector.*values;
        numerator = double(0);
        denominator = double(0);
        for p = 1:P-1
            numerator = numerator + p*double(values(1, p+1) - values(1, p));
            denominator = denominator + double(values(1, p+1) - values(1, p));
        end
        c = numerator/denominator;
        if c <= 2 || P - c <= 2
            %isValid = false;
        end
        centroids(r) = c;
    end
else
    centroids = zeros(P, 1);
    for p = 1:P
        values = double(croppedImage(:,p));
        hammingVector = values;
        for i = 1:R
            hammingVector(i) = 0.54 +0.46 * cos(2*pi*(i-double(R)/2)/R);
        end
        values = hammingVector.*values;
        numerator = double(0);
        denominator = double(0);
        for r = 1:R-1
            numerator = numerator + r*double(values(r+1, 1) - values(r, 1));
            denominator = denominator + double(values(r+1, 1) - values(r, 1));
        end
        c = numerator/denominator;
        if c <= 2 || P - c <= 2
            %isValid = false;
        end
        centroids(p) = c;
    end  
>>>>>>> fbf900cae58928727832384c1540a871ba141da9
end
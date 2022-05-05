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
end
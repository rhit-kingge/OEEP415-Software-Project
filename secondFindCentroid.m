function [updatedCentroids] = secondFindCentroid(croppedImage, oriCentroids)
R = size(croppedImage, 1);
P = size(croppedImage, 2);
updatedCentroids = oriCentroids;

dC = 1:R-1;
for r = 1:R-1
    dC(r) = 1/(oriCentroids(r+1) - oriCentroids(r));
end
m = mean(dC);

for r = 1:R
    values = double(croppedImage(r,:));
    S = (R/2-r)/m;
    hammingVector = values;
    for i = 1:P
        hammingVector(i) = 0.54 +0.46 * cos(2*pi*(i+S-double(P)/2)/P);
    end
    values = hammingVector.*values;
    numerator = double(0);
    denominator = double(0);
    for p = 1:P-1
        numerator = numerator + p*double(values(1, p+1) - values(1, p));
        denominator = denominator + double(values(1, p+1) - values(1, p));
    end
    updatedCentroids(r) = numerator/denominator;
end
end
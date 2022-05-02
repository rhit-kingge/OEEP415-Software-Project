%test code
croppedImage = [1 2; 3 4; 5 6];
hammingWindowVector = [7 8 9];

windowSize = size(croppedImage);
%hammingWindowVector = hamming(windowSize(2),'symmetric');
weightedImage = zeros(windowSize);

    for row = 1: windowSize(1)
        weightedImage(row, :) = croppedImage(row, :) .* hammingWindowVector(row);
    end
disp(weightedImage)
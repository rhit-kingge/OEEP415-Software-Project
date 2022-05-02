img = im2gray(imread('reference image.jpg'));
B = bwboundaries(img);
exists = false;
disp(B)
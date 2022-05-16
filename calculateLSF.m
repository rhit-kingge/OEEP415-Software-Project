function LSF = calculateLSF(croppedImage, ESF, orientation)

if strcmp(orientation, 'Horizontal')
    croppedImage = croppedImage';
end

R = size(croppedImage, 1); P = size(croppedImage, 2); J = 4*P;

j = 1:(4*P-2);
W = 0.54 + 0.46 * cos(2*pi.*(j-(2*P-1))/(4*P-2));
LSF = zeros(J-2,1);
for i = 2:J-2
    LSF(i) = W(i) * (ESF(i+1) - ESF(i-1))/2;
end

end
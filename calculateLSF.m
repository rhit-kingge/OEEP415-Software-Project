function LSF = calculateLSF(croppedImage, ESF, orientation, shift)

if strcmp(orientation, 'Horizontal')
    croppedImage = croppedImage';
end

totalColumns = size(croppedImage, 2); J = 4*totalColumns;
j = 1:(J-2);

W = 0.54 + 0.46 * cos(2*pi*(j-(2*totalColumns))/(4*totalColumns));
LSF = zeros(J-2,1);

for i = 2:J-2
    LSF(i) = W(i) * ((ESF(i+1) - ESF(i-1))/2);
end

end
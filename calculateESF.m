function ESF = calculateESF(croppedImage, shift, orientation)

if strcmp(orientation, 'Horizontal')
    croppedImage = croppedImage';
end

R = size(croppedImage, 1); P = size(croppedImage, 2); J = 4*P;
ESF = zeros(J,1); 
for j=1:J
    numerator = double(0);
    denominator = double(0);
    for r = 1:R
        for p = 1:P
            if abs(double(p) + shift(r) - double(j/4)) <= 0.125
                alpha = 1;
            else
                alpha = 0;
            end
            numerator = numerator + double(croppedImage(r, p))*alpha;
            denominator = denominator + alpha;
        end
    end
    ESF(j,1) = double(numerator)/double(denominator);
end


end
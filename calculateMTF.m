function MTF = calculateMTF(LSF)

N = size(LSF, 1);
if rem(N, 2) ~= 0 
    max = N+1;
else
    max = N;
end

denom = sum(LSF);

for k=1:(max/2)
    val=(2*pi*(k-1)/N)/(sin(2*pi*(k-1)/N));
    D=min(val,10);
    num = double(0);
    for j=1:N
        num=LSF(j)*exp(-1i*2*pi*(k-1)*j/N)+num;
    end
    MTF(k)=D*abs(num/denom);
end
MTF(1)=1;
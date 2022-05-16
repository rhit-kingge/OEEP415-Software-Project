function MTF = calculateMTF(LSF)

[N,M]=size(LSF);

for k=1:(N/2+1)
    val=(2*pi*(k-1)/N)/(sin(2*pi*(k-1)/N));
    d=[val,10];
    D(k)=min(d);
    for j=1:N
        if j==1
            num(j)=LSF(j)*exp(-i*2*pi*(k-1)*j/N);
            denom(j)=LSF(j);
        else
            num(j)=LSF(j)*exp(-i*2*pi*(k-1)*j/N)+num(j-1);
            denom(j)=LSF(j)+denom(j-1);
        end
    end
    MTF(k)=D(k)*abs(num(j)/denom(j));
end
MTF(1)=1;
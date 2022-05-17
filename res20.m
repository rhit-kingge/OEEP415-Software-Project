function res_val = res20(x)

t=1;
n=1;
val(n)=x(1,n)-0.2;
while val(n)>0
    n=n+1;
    val(n)=x(1,n)-0.2;
end
res_val=size(val,2);

end
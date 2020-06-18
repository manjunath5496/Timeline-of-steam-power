function[jn]=sbfj_f_3(x,N);
jn(1)=sin(x)/x;
jn(2)=sin(x)/x^2 -cos(x)/x;
for n=2:N
%jn(n+1)=((2*n+1)/x)*jn(n) - jn(n-1)
jn(n+1)=radd(((2*n+1)/x)*jn(n), - jn(n-1), 3);
end


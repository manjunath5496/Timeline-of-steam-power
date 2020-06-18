% Backward recurrence for spherical Bessel function j_n(x), n=0...N-1 
% This version uses 3-digit arithmetic
function[j]=sbfj_3(x,N);
jnp1=0;
jn=1.0;
for n=N+round(x)+20:-1:N+2
jno=jn;
jn=radd(-jnp1 , ((2*n+1)/x)*jno, 3);
jnp1=jno;
end
for n=N+1:-1:1
jno=jn;
jn=radd(-jnp1 , ((2*n+1)/x)*jno, 3);
jnp1=jno;
j(n)=jn;
end
% Normalize
if (abs(j(1)) >= abs(j(2)))
 jr=j(1);
 jn=sin(x)/x;
else
  jr=j(2);  
 jn=sin(x)/x^2 -cos(x)/x;
end

 for n=N:-1:1
  j(n)=j(n)*jn/jr;
 end





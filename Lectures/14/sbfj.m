% Backward recurrence for spherical Bessel function j_n(x), n=0...N-1 
function[j]=sbfj(x,N);
jnp1=0;
jn=1.0;
for n=N+round(x)+20:-1:N+2
jno=jn;
jn=-jnp1+ ((2*n+1)/x)*jno;
jnp1=jno;
end
for n=N+1:-1:1
jno=jn;
jn=-jnp1+ ((2*n+1)/x)*jno;
jnp1=jno;
j(n)=jn;
end
% Normalize
jr=j(1);
j0=sin(x)/x;
for n=N:-1:1
j(n)=j(n)*j0/jr;
end





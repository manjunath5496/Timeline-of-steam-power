% Forward recurrence for spherical Bessel function y_n(x), n=0...N-1 
function[yn]=spfy(x,N);
yn(1)=-cos(x)/x;
yn(2)=-cos(x)/x^2 -sin(x)/x;
for n=2:N
yn(n+1)=((2*n+1)/x)*yn(n) - yn(n-1);
end

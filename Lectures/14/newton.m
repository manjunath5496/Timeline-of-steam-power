function[y] = newton(x,xi,c) 
% Computes Newton polynomial with
% coefficients c
n=length(c)-1
m=length(x)
y=c(n+1)*ones(1,m);
for i=n-1:-1:0
    cc=c(i+1);
    xx=xi(i+1);
    y=cc+y.*(x-xx);
end


function[c] = newton_coef(h,f)
% Computes Newton Coefficients of f 
% for equidistant sampling h
n=length(f)-1
c=f;
c_old=f;
fac=1;
for i=1:n
fac=i*h;
    for j=i:n
    c(j+1)=(c_old(j+1) - c_old(j))/fac;
    end 
c_old=c;
end

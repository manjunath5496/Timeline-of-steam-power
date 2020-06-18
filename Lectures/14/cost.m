function [c] = cost(x,y,mu,gam)
n=length(x);
 c=0;
for i=1:n-1
   c =c + sqrt((x(i+1)-x(i))^2 + (y(i+1)-y(i))^2) + gam*(mu(i+1)-mu(i));
end

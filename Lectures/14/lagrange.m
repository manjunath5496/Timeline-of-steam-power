function[y] = lagrange(x,xi,f)
n=length(xi)-1
m=length(x)
y=zeros(1,m);
for k=0:n
 lk=ones(1,m);
 for j=0:k-1
  lk=lk.*(x-xi(j+1))/(xi(k+1)-xi(j+1));
 end
 for j=k+1:n
  lk=lk.*(x-xi(j+1))/(xi(k+1)-xi(j+1));
 end
 y=y+f(k+1)*lk;
end


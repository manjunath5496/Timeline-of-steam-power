function[a] = interp_test(n)
%n=2
h=1/n
xi=[0:h:1]
f=sqrt(1-xi.*xi) .* (1 - 2*xi +5*(xi.*xi));
%f=1-2*xi+5*(xi.*xi)-4*(xi.*xi.*xi);

c=newton_coef(h,f)
m=101
x=[0:1/(m-1):1];
fx=sqrt(1-x.*x) .* (1 - 2*x +5*(x.*x));
%fx=1-2*x+5*(x.*x)-4*(x.*x.*x);

y=newton(x,xi,c);
hold off; b=plot(x,fx,'b'); set(b,'LineWidth',2);
hold on; b=plot(xi,f,'.r') ; set(b,'MarkerSize',30); 
b=plot(x,y,'g'); set(b,'LineWidth',2);
yl=lagrange(x,xi,f);
b=plot(x,yl,'xm'); set(b,'Markersize',5);
b=legend('Exact','Samples','Newton','Lagrange')
b=title(['n = ' num2str(n)]); set(b,'FontSize',16);

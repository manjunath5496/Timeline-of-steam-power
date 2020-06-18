fxy='x'
f=inline(fxy,'x','y');
x=[0:0.1:10];
y0=1;
figure(1)
hold off
%step size
h=1.0;
% Euler's method, forward finite difference
xt=[0:h:10];
N=length(xt);
yt=zeros(N,1);
yt(1)=y0;
for n=2:N
    yt(n)=yt(n-1)+h*f(xt(n-1),0);
end
a=plot(xt,yt,'xr');
set(a,'MarkerSize',12)
% 2nd orded Runge Kutta
yrk=yt;
for n=2:N
    k1=h*f(xt(n-1),yrk(n-1));
    k2=h*f(xt(n),yrk(n-1)+k1);
    yrk(n)=yrk(n-1)+0.5*(k1+k2);
end
hold on
a=plot(xt,yrk,'+m');
set(a,'MarkerSize',10);
% Matlab ode45
[xml,yml]=ode45(f,[x(1) xt(end)],y0);
a=plot(xml,yml,'b');
set(a,'MarkerSize',20);
a=title(['dy/dx = ' fxy ', y_0 = ' num2str(y0)])
set(a,'FontSize',16);
b=legend(['Euler, h=' num2str(h)],'Runge-Kutta','ODE45');
set(b,'FontSize',14);

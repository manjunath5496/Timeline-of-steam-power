fxy='a*x.^2+b'
f=inline(fxy,'x','a','b');
x=[0:0.01:1];
x=reshape([x' x']',2*length(x),1);
n=length(x);
y=zeros(n,1);
a=5;
b=3;
% Generate noisy data
amp=0.05*(max(f(x,a,b))-min(f(x,a,b)));
y=f(x,a,b)+random('norm',0,amp,n,1);
figure(1)
clf
hold off
p=plot(x,y,'.r');
set(p,'MarkerSize',10)
A=ones(n,2);
A(:,1)=f(x,1,0);
bb=y;
%Normal matrix
C=A'*A;
c=A'*bb;
% Least square solution
z=inv(C)*c
% Residuals
r=bb-A*z;
rn=sqrt(r'*r)/n
hold on
p=plot(x,f(x,z(1),z(2)),'b')
set(p,'LineWidth',2)
% Linear model
A(:,1)=x;
%Normal matrix
C=A'*A;
c=A'*bb;
% Least square solution
z=inv(C)*c
% Residuals
r=bb-A*z;
rn=sqrt(r'*r)/n
hold on
p=plot(x,z(1)*x+z(2),'g')
set(p,'LineWidth',2)
p=legend('Data','Non-linear','Linear');
set(p,'FontSize',14);



    
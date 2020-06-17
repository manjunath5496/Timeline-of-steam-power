%
%  notch fatigue factor efficiency
%
% Peterson: q =(Kf-1)/(Kt-1) = 1/(1+rhostar/rho)
%
%
clear
figure
rhonorm=logspace(-2,3,20);
q = 1./(1+ 1./rhonorm);
semilogx(rhonorm,q,'-b');
xlabel(' \rho / \rho^{P}');
ylabel(' q \equiv ( K_f - 1 ) / ( K_t - 1 )');
title('Normalized notch fatigue factor, K_f');
hold on
text(3.,.5,'\rho : notch root radius');
text(3.,.4,'\rho^{P} : Peterson material "blocksize" ');
text(3.,.3,'\rho^{P} \cong \rho_0 (\sigma_0/UTS)^{1.8} (wrought steels)');
text(5.,.2,'\rho_0 = .001 in = 25.4 \mu m;');
text(5.,.1,'\sigma_0 = 300 ksi = 2070 MPa');
text(.02,.9,'K_f : notch fatigue factor');
text(.02,.8,'K_t : theoretical (elastic)');
text(.04,.75,'stress concentration factor');
hold off
%
% draw figure of K_f and K_t vs rhonorm
figure
Kt=3
Kf = 1 + q.*(Kt-1);
semilogx(rhonorm,Kf,'-b');
[m,n]=size(q)
kfmax=ones(m,n)*Kt;
kfmin=ones(m,n);
axis([.01,1000.,0,Kt+1]);
xlabel('\rho / \rho^{P} = ( \rho /\rho_0 ) * ( UTS / \sigma_0 )^{1.8}');
ylabel('K_f');
hold on
semilogx(rhonorm,kfmax,'-.r');
semilogx(rhonorm,kfmin,'-.r');
text(.02,3.2,'\bf{Example}: K_t = 3; \rho=0.05 in; UTS = 100 ksi');
UTS = 100; % 100 ksi
notchrho=0.05 ;% IN INCHES
Rpeterson= .001* (300/UTS)^(1.8);% in inches
xspot=notchrho/Rpeterson
yspot=1+(Kt-1)*(1/(1+1/xspot))
plot(xspot,yspot,'*r');
stringer=sprintf('K_f =%g',yspot);
stringer2=sprintf('%g inches is Peterson blocksize',Rpeterson);
text(.1,2.5,stringer);
text(.1,2.8,'\rho^{P} = .00722 in.');
text(3.,2.3,'\rho : notch root radius');
text(3.,2.0,'\rho^{P} : Peterson material "blocksize" ');
text(3.,1.7,'\rho^{P} \cong \rho_0 (\sigma_0/UTS)^{1.8} (wrought steels)');
text(5.,0.8,'\rho_0 = .001 in = 25.4 \mu m;');
text(5.,0.5,'\sigma_0 = 300 ksi = 2070 MPa');
hold off
figure
rbya=linspace(1,7,100);
sconc_circ=1 + 1.5*rbya.^(-4)+ 0.5*rbya.^(-2);
plot(rbya,sconc_circ);
axis([1,7,0,4]);
xlabel(' r / a ');
ylabel(' \sigma_{yy}(x=a+r, 0) / \sigma^{\infty}');
text(2,3.5,'Stress concentration near circular hole');
text(1.2,3,'\bf{Maximum stress concentration: K_t = 3}')
text(2.5,2,'\sigma_{yy}(x=a+r, y=0) = \sigma^{\infty} [ 1 + 1.5 (a/r)^4 + 0.5 (a/r)^2]');
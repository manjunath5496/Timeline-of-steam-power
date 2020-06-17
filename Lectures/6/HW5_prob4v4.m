% part a
syms x(t) Dx w m g k A C D
syms soln_c soln_n soln_p
Dx=diff(x);
soln_c=dsolve(m*diff(Dx)+g*Dx+k*x==m*A*(w^2)*cos(w*t));
% The line above gives the complete solution, but it's very messy
% Below is a version much easier to express and interpret
wd=sqrt(-g^2+4*m*k)/(2*m) % damped frequency
syms B C
soln_n=exp((-g/(2*m))*t)*(B*cos(wd*t)+C*sin(wd*t));
soln_p=[cos(w*t) sin(w*t)]*inv([k-m*w^2 w*g; -w*g k-m*w^2])*[m*A*w^2; 0];
% Make plots for some specific values to see how they look
B=1; C=2; m=5; k=7; g=1; A=3; w=11;
ezplot(subs(soln_p+soln_n),[0 4])
%%
% part b
syms C D
syms w m g k A C D
inv([k-m*w^2 w*g; -w*g k-m*w^2])*[m*A*w^2; 0];
C=ans(1); D=ans(2);
Amplitude=simplify((C^2+D^2)^0.5);
pretty(Amplitude)

%%
% part c
syms w m g k A C D
w_n=sqrt(k/m); % this is a formula worth memorizing
% You can also get it by subsituting gamma=0 in the damped frequency
wd=sqrt(-g^2+4*m*k)/(2*m) % damped frequency
subs(wd,g,0)

%%
% part d

solve(diff(Amplitude,w)==0,w)
% Choose just the positive root


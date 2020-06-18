A=[ [1 0 0 -1 0 -1]' [0 1 0 1 -1 0]' [0 0 1 0 1 1]']
b=[1 2 3 1 2 1]';
C=A'*A
c=A'*b
% Least square solution
z=inv(C)*c
% Residual
r=b-A*z
rn=sqrt(r'*r)

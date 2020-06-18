% 2D Vortex/Source Lattice with Lighthill Correction Program (VLMLE)
% This is the main file which contains the algorithms.
function [xt, CPU, CPL, CLNum] = Main;
global U c N CL Alpha TOC;
%==========================================================================
for i = 1:N
   xv(i) = c/2 * (1-cos((i-1/2)*pi/N));     % Vortex Position
   xc(i) = c/2 * (1-cos(i*pi/N));           % CP Position
   dx(i) = pi * sqrt(xv(i)*(c-xv(i))) / N;  % Interval between vrotices
end
for i = 1:N         % Influence Matrix I (i:CP; j:vortex)
    for j = 1:N
        I(i,j) = 1/(2*pi*(xv(j)-xc(i)));        
    end
end
% ============================================================= Camber Term
[B,F,Gexact] = MeanLine(xv,xc);     % Function for NACA a = 0.8 Mean Line
for i = 1:N
   B(i) = CL*B(i) - Alpha*pi/180;
   F(i) = CL*F(i);                  % Camber F
end
Gamma = (B/I');                     % Point Vortex Strength
G = Gamma./dx;                      % Vortex Sheet Strength
CLNum = 2*sum(Gamma);               % Numerical Lift Coeff
% ========================================================== Thickness Term
xt(1) = 0;                          % Thickness at the leading edge
for i = 1:length(xc)
   xt(i+1) = xc(i); 
end
[RLE, yt, dydx] = Thickness(xv, xc, xt); % Function for NACA 65A010 Thickness
for i = 1:N                         % i for CP; j for Vortices
    for j = 1:N
        ut(i,j) = (yt(j+1)-yt(j))/(xc(i)-xv(j))/(2*pi);
    end
    UT(i) = sum(ut(i,:));           % UT @ Control Points
end
UTVP = spline(xc,UT,xv);            % UT @ Vortex Points
% UTVP = interp1(xc,UT,xv);
% =========================================== Leading Edge Surface Velocity
QU = Alpha*pi/180*sqrt(2*c/RLE);    % Surface Velocity
CPU(1) = QU^2-1;                    % Minus Cp on the upper surface at LE
CPL(1) = CPU(1);                    % Minus Cp on the lower surface at LE
% ======================================================== Surface Velocity
for i = 1:N
    if dydx(i)>0
        FLH(i) = 1/sqrt(1+dydx(i)^2);
    else
        FLH(i) = 1;
    end
    QU(i) = (1+UT(i)+1/2*G(i))*FLH(i);  % Velocity on Upper Surface
    CPU(i+1) = QU(i)^2-1;               % -Cp    
    QL(i) = (1+UT(i)-1/2*G(i))*FLH(i);  % Velocity on Lower Surface
    CPL(i+1) = QL(i)^2-1;               % -Cp
end
% ================================================ Plotting and Text Report
Report(xv,F,Gamma,G,CLNum,RLE,yt,UT,UTVP,CPU,CPL);
% plotting(xv,xc,xt,F,yt,Gamma,G,UT,UTVP);
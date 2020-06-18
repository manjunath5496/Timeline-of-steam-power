function [B,F,Gexact] = MeanLine(xv,xc)
% ============================================================ NACA a = 0.8
global U c N CL Alpha TOC;
a = 0.8;
% =================================================== Ideal Angle of Attack
g = -1/(1-a) * (a^2*(log(a)/2-1/4)+1/4);
h = 1/(1-a) * ((1-a)^2*log(1-a)/2 - (1-a)^2/4) + g;
AlphaIdeal = -h / (2*pi*(a+1));
% =========================================================================
for i = 1:N
   C1 = max(1- xv(i),1e-6);
   CA = a - xv(i);
   if (abs(CA)<1e-6)
       CA = CA+1e-5;
   end
       P = 1/2*CA^2*log(abs(CA))-1/2*C1^2*log(C1)+1/4*(C1^2-CA^2);
       F(i)=(P/(1-a)-xv(i)*log(xv(i))+g-h*xv(i))/(2*pi*(a+1))+C1*AlphaIdeal;
   if (xv(i)<=a)
       Gexact(i) = 1/(a+1);
   else
       Gexact(i) = 1/(a+1) * (1-xv(i))/(1-a);
   end
end
for j = 1:N
   C1 = max(1-xc(j),1e-6);
   CA = a - xc(j);
   if (abs(CA)<1e-6)
       CA = CA+1e-5;
   end
   R = -(a-xc(j))*log(abs(CA))-1/2*CA+C1*log(C1)+1/2*C1;
   S = -1/2*C1+1/2*CA;
   T = -log(xc(j))-1-h;
   B(j) = ((R+S)/(1-a)+T)/(2*pi*(a+1)) - AlphaIdeal; 
end
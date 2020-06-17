% monotonic and cyclic stress-strain curves using Ramberg-Osgood fits to
% 
clear
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% input material constants:
%
% values below are for 2024-T4 aluminum, taken from Table 1 of handout
E = 73000; %Young's modulus, (MPa)
%
%monotonic properties
%
K = 807; %monotonic strength coefficient (MPa)
n = 0.2; %monotonic strain hardening expoenent
% calculate monotonic yield stress, 0.2% offset plastic strain
sigmay002= K*(0.002)^(n); %monotonic yield stress( MPa), 0.2% offset
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%cyclic properties
%
Kprime = 655; %monotonic strength coefficient (MPa)
nprime = 0.08; %monotonic strain hardening expoenent
sigmayprime002= Kprime*(0.002)^(nprime); %monotonic yield stress( MPa), 0.2% offset
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% calculate a max on strain range; assume all to be plastic; then convert
% to corresponding stress range for both mono and cyclic curves
%
% let epmax be the maximum strain to be plotted on the axis; say 0.05
epmax=0.05;
%
%neglecting elasticity, the corresponding monotonic stress is sm_max = K      * (epmax)^n
% while the corresponding cyclic stress is                    sc_max = Kprime * (epmax)^nprime;
% 
smmax = K * (epmax)^n;
scmax = Kprime*(epmax)^nprime;
% create stress range for monotonic curve
stressrangem=linspace(0,smmax,100);
eemono=stressrangem/E; % calculate elastic monotonic strain
epmono=(stressrangem/K).^(1/n); % calculate plastic monotonic strain
emono=eemono+epmono; % total strain is sum of elastic and plastic strain
figure
plot(emono,stressrangem,'b');
xlabel('\epsilon');
ylabel('\sigma  (MPa)');
title('Cyclic curve: RED; Monotonic curve: BLUE')
hold on
%
% repeat procedure for cyclic data
%
%stress range for cyclic curve
stressrangec=linspace(0,scmax,100);
eecyclic=stressrangec/E;
epcyclic=(stressrangec/Kprime).^(1/nprime);
ecyclic=eecyclic+epcyclic;
plot(ecyclic,stressrangec,'-r');
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  plot cyclic hysteresis loops
% makes use of approximate shape of rising and falling branches of the
% hysteresis loops as a scaled (x 2) version of the original cyclic stress
% strain curve
%
% "up" cyclle begins at epsilon=-e_a; stress=-sigma_a
Delstressup=linspace(0,2*scmax,100);
Delstraine_up=Delstressup/E;
Delstrainp_up=2*(Delstressup/(2*Kprime)).^(1/nprime);
stressHyst=linspace(-scmax,scmax,100);
%strain_upe=(stressHyst-scmax)/E;
%strain_upp=2.*((stressHyst+scmax)/(2*Kprime)).^(1/nprime);
strain_up=Delstraine_up+Delstrainp_up-(scmax/E + (scmax/Kprime)^(1/nprime));
figure
plot(strain_up,stressHyst,'b');
xlabel('\epsilon');
ylabel('\sigma  (MPa)');
title('Cyclic hysteresis loops');
hold on
Delstressdown=linspace(0,2*scmax,100);
Delstraine_down=-Delstressup/E;
Delstrainp_down=-2*(Delstressup/(2*Kprime)).^(1/nprime);
strain_down=(scmax/E + (scmax/Kprime)^(1/nprime))+(Delstraine_down + Delstrainp_down);
stress_down=linspace(scmax,-scmax,100);
plot(strain_down,stress_down);
%
% outer loop drawn; scale down stress range for next curve
% this would be most efficiently done with a subroutine/ .m file
%
scmax1=scmax;
scmax=scmax1*0.95;
Delstressup=linspace(0,2*scmax,100);
Delstraine_up=Delstressup/E;
Delstrainp_up=2*(Delstressup/(2*Kprime)).^(1/nprime);
stressHyst=linspace(-scmax,scmax,100);
%strain_upe=(stressHyst-scmax)/E;
%strain_upp=2.*((stressHyst+scmax)/(2*Kprime)).^(1/nprime);
strain_up=Delstraine_up+Delstrainp_up-(scmax/E + (scmax/Kprime)^(1/nprime));
plot(strain_up,stressHyst,'b');
%xlabel('\epsilon');
%title('Cyclic hysteresis loops');
%hold on
Delstressdown=linspace(0,2*scmax,100);
Delstraine_down=-Delstressup/E;
Delstrainp_down=-2*(Delstressup/(2*Kprime)).^(1/nprime);
strain_down=(scmax/E + (scmax/Kprime)^(1/nprime))+(Delstraine_down + Delstrainp_down);
stress_down=linspace(scmax,-scmax,100);
plot(strain_down,stress_down);
scmax=scmax1*0.9;
Delstressup=linspace(0,2*scmax,100);
Delstraine_up=Delstressup/E;
Delstrainp_up=2*(Delstressup/(2*Kprime)).^(1/nprime);
stressHyst=linspace(-scmax,scmax,100);
strain_up=Delstraine_up+Delstrainp_up-(scmax/E + (scmax/Kprime)^(1/nprime));
plot(strain_up,stressHyst,'b');
%xlabel('\epsilon');
%title('Cyclic hysteresis loops');
%hold on
Delstressdown=linspace(0,2*scmax,100);
Delstraine_down=-Delstressup/E;
Delstrainp_down=-2*(Delstressup/(2*Kprime)).^(1/nprime);
strain_down=(scmax/E + (scmax/Kprime)^(1/nprime))+(Delstraine_down + Delstrainp_down);
stress_down=linspace(scmax,-scmax,100);
plot(strain_down,stress_down);
scmax=scmax1*0.8;
Delstressup=linspace(0,2*scmax,100);
Delstraine_up=Delstressup/E;
Delstrainp_up=2*(Delstressup/(2*Kprime)).^(1/nprime);
stressHyst=linspace(-scmax,scmax,100);
%strain_upe=(stressHyst-scmax)/E;
%strain_upp=2.*((stressHyst+scmax)/(2*Kprime)).^(1/nprime);
strain_up=Delstraine_up+Delstrainp_up-(scmax/E + (scmax/Kprime)^(1/nprime));
plot(strain_up,stressHyst,'b');
%xlabel('\epsilon');
%title('Cyclic hysteresis loops');
%hold on
Delstressdown=linspace(0,2*scmax,100);
Delstraine_down=-Delstressup/E;
Delstrainp_down=-2*(Delstressup/(2*Kprime)).^(1/nprime);
strain_down=(scmax/E + (scmax/Kprime)^(1/nprime))+(Delstraine_down + Delstrainp_down);
stress_down=linspace(scmax,-scmax,100);
plot(strain_down,stress_down);
scmax=scmax1*0.6;
Delstressup=linspace(0,2*scmax,100);
Delstraine_up=Delstressup/E;
Delstrainp_up=2*(Delstressup/(2*Kprime)).^(1/nprime);
stressHyst=linspace(-scmax,scmax,100);
%strain_upe=(stressHyst-scmax)/E;
%strain_upp=2.*((stressHyst+scmax)/(2*Kprime)).^(1/nprime);
strain_up=Delstraine_up+Delstrainp_up-(scmax/E + (scmax/Kprime)^(1/nprime));
plot(strain_up,stressHyst,'b');
%xlabel('\epsilon');
%title('Cyclic hysteresis loops');
%hold on
Delstressdown=linspace(0,2*scmax,100);
Delstraine_down=-Delstressup/E;
Delstrainp_down=-2*(Delstressup/(2*Kprime)).^(1/nprime);
strain_down=(scmax/E + (scmax/Kprime)^(1/nprime))+(Delstraine_down + Delstrainp_down);
stress_down=linspace(scmax,-scmax,100);
plot(strain_down,stress_down);
%
% next curve overlays cyclic stress strain curve over tensile loop tips:
%
plot(ecyclic,stressrangec,'-r');
hold off

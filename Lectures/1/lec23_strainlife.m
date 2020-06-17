%  defect-free strain- life graphing software
% plots log-log strain amplitude[s] vs.  life (in reversals to failure) curve
%
%  
clear
% TwoNf : 2N_f, number of reversals to failure
TwoNf=logspace(0,8,10)
% enter material constants: data for SAE 1040 steel (as-forged), taken from
% Table 3 of handout
E=29000      % Young's modulus (ksi) (given elsewhere)
sfprime=270   % fatigue strength coefficient (ksi)
efprime= 0.60 % fatigue ductility coefficient
b= -.073        % fatigue strength exposnent (Basquin exponent)
c= -.70        % fatigue ductility exponent (Coffin Manson exponent)
%
% Calculate transition life, in # of reversals, where cyclic elastic and
% plastic strains are equal
TwoNt= (E*efprime/sfprime)^(1/(b-c))
eap=efprime*(TwoNf.^c) ; % contains plastic strain amplitude at lives corresponding to TwoNf
eae= (sfprime/E)*(TwoNf.^b); % contains elastic strain amplitude at lives corresponding to TwoNf
ea = eae+eap; % contains total strain amplitude at lives corresponding to TwoNf
loglog(TwoNf,ea,'-b'); %creates log-log plot of total strain vs. life
title('Strain-Life: BLUE; Plastic strain-life: RED; Elastic strain-life: CYAN');
hold on
loglog(TwoNf,eae,'-c'); % on same plot, adds elastic strain vs. life
loglog(TwoNf,eap,'-r'); % on same plot, adds plastic strain vs. life
xlabel(' 2N_f (Reversals to failure)');
     ylabel(' \epsilon_a  =  \Delta \epsilon / 2 (cyclic strain amplitude)');
     text(3,1.e-4,'\bf{1045 quench and tempered : UTS= 236 ksi}');
     hold off
%grid on
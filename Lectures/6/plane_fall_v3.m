% HW#1 Prob 9 -- An airplane is falling
% Declare the variables I need  
syms V(t) t k Cd m g v_ffs
% Set values for physical parameters
m=1.2; g=9.8; Cd=0.02; k=(1/2)*1.3*0.22;
% Solve the differential eqn for the first five seconds
V_ffs=dsolve(m*g-k*Cd*V^2==m*diff(V),V(0)==0);
% Solve the differential eqn after the speed brake is deployed
V_sbd=dsolve(m*g-k*4*Cd*V^2==m*diff(V),V(5)==subs(V_ffs,5));
% Make a solution that covers the whole time period
V_all=V_ffs*heaviside(5-t)+V_sbd*heaviside(t-5);
ezplot(V_all,[0 9]) %plot the solution
% Part (e) asks when the plane reaches within 5% of the steady state
Vss=(m*g/(k*0.08))^0.5; % Compute the steady state
% Make a function that would be zero at the time when V(t)=1.05*Vss
v_sbdf=@(t) (real(double(subs(V_sbd,t)))-1.05*Vss);
tg=5.5; % Initial guess for solver
time_close=fzero(v_sbdf,tg) % Make a call to a solver
% Plot the result of solving for when V(t)=1.05*Vss
hold on
plot(time_close*[0 1 1],1.05*Vss*[1 1 0],'r--')
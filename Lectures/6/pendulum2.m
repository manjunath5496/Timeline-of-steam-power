% HW 5 problem 5 part b
clear
% set the parameters of the problem
m=0.001;
M=10;
k=100;
g=9.8;
R=1;

% Initial values stipulated in the problem statement
theta(1)=15*pi/180;
x(1)=0.01;
% Initial values I sent out in the email
x_dot(1)=0;
theta_dot(1)=0;
theta_dot_dot(1)=0;

dt=0.01; % Time step
time=16; % Final time
t_steps=time/dt;
% Execute the forward Euler method
for i=1:t_steps  
    x_dot_dot(i)=(1/(M+m))*(-k*x(i)+...
        m*R*theta_dot_dot(i)*cos(theta(i))+...
        m*(theta_dot(i)^2)*R*sin(theta(i)));
    theta_dot_dot(i+1)=(g*sin(theta(i))-x_dot_dot(i)*cos(theta(i)))/R;
    theta_dot(i+1)=theta_dot(i)+theta_dot_dot(i+1)*dt;
    theta(i+1)=theta(i)+theta_dot(i+1)*dt;
    x_dot(i+1)=x_dot(i)+x_dot_dot(i)*dt;
    x(i+1)=x(i)+x_dot(i+1)*dt;
end
t=(0:t_steps)*dt;
figure(1)
plot(t,x)
figure(2)
plot(t,theta)


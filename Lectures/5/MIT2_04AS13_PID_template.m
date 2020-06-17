%% System Parameters
clear;close all
m1=5.11;m2=0.87+0.075; %kg
k1=1120;k2=75;         %N/m
b1=0.87;b2=8.4;        %N-sec/m
kvoice=7.1;            %Volts-sec/m for sensor & N/Amp for the actuator
ka=2;                  %Amp/Volt

%% ---------------------*State-space system modeling---------------------- 
% Enter your state-space modeling here:
A=
B=
C=
D=

%-------You should check your state-space modeling with the following test case-------
%A*[0;2.1;0;3.2] =  2.1000;  1.6659;   3.2000;   -9.7778
%B*[2; 1]        =  0     ;  0.1957   ;0        ; 1.0582
%-------------------------------------------------------------------------------------

states = {'x1' 'v1' 'x2' 'v2'}; inputs = {'WindForce' 'ActuatorForce'}; outputs = {'v1' 'v2-v1'};
G_ss=ss(A,B,C,D,'statename',states,'inputname',inputs,'outputname',outputs);

[nn,dd]=ss2tf(A,B,C,D,1); %transfer functions due to the first input (wind force)
Gv1_w=tf(nn(1,:),dd);     %V1(s)/W(s)
Gv2_v1_w=tf(nn(2,:),dd);  %V2-V1(s)  /   W(s)
[nn,dd]=ss2tf(A,B,C,D,2);
Gv1_a=tf(nn(1,:),dd);     %V1(s)/A(s)
Gv2_v1_a=tf(nn(2,:),dd);  %V2(s)-V1(s)  /  A(s)

f1=figure;
impulse(G_ss)             %state-space openloop impulse response
%% ----------------SISOTOOL design-----------------
CC=pid(1,0,0);            %Controller design. Input arguments are kp, ki and kd 
sisotool(ka*kvoice*Gv2_v1_a,CC,kvoice,1) %triggers sisotool

%% ----------------Simulation------------------------------
% This part simulates the performance of the system with wind as an impulse-like disturbance
%Gw=ss(A,B(:,1),eye(4),D);Ga=ss(A,B(:,2),eye(4),0);
%CC=pid(1,0,0); %Enter your controller design HERE. 
%ctrans=C*feedback(eye(4),Ga*14.2*kvoice*C(2,:)*CC)*Gw;
%impulse(ctrans)
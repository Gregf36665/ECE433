%% Motor parameters

Rm = 2.6; % +/- 12%
Lm = 0.18e-3;
kt = 7.68e-3; % +/- 12%
km = 7.68e-3; % +/- 12%
Kg = 70; % for low gear 14
eta_m = 0.69; % +/- 5%
eta_g = 0.90; % +/- 10%
Jm_rotor = 3.9e-7; % +/- 10%
Jtach = 7.06e-8; % +/- 10%
Jeq = 9.76e-5; % 2.08e-5 for low gear
Beq = 0.015; % 1.5e-4 for low gear
m_b = 0.038;
L_b = 0.1525;
m_d = 0.04;
r_d = 0.05;

Ka = eta_g * Kg * eta_m * kt / Jeq;
Kb = km * Kg;

I_inf = Beq/(Kb*Ka*Jeq+Rm*Beq)
w_inf = Ka*Jeq/(Kb*Ka*Jeq+Rm*Beq)

%GF/IM motor
% alpha = 66.9379;
% tau = 39.3285;
%KP/SB motor
alpha = 87.7886;
tau = 52.1073;

%% Calculate control parameters for pos control

% Read inputs
OS = input('Percent Overshoot: ', 's');
OS = str2double(OS);

Ts = input('Settling Time: ', 's');
Ts = str2double(Ts);

% Calculate damping ratio and natural frequency from control parameters
%lnpart = (log(100/OS))^2;
%zeta = sqrt(lnpart/(pi^2 + lnpart));
zeta = 1;

omega = 4/(zeta*Ts);

% Calculate control gains

%We have an extra pole, set it to something far away so it is not very
%dominant
p = 10*zeta*omega;

Kd = (2*zeta*omega+p-tau)/alpha
Kp = (omega^2+2*zeta*omega*p)/alpha
Ki = (omega^2*p)/alpha

%% plot magic

subplot(2,1,1);
plot(t,pos,t,pos_input);
title('Input and output vs time');
subplot(2,1,2);
plot(t,pos_error);
title('Steady state error');
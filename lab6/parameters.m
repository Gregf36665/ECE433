clear

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

I_inf = Beq/(Kb*Ka*Jeq+Rm*Beq);
w_inf = Ka*Jeq/(Kb*Ka*Jeq+Rm*Beq);

alpha = 66.9379;
tau = 39.3285;

%% Calculate Kp, Ki for %OS and Ts

OS = str2double(input('Percent Overshoot: ', 's'));
Ts = str2double(input('Settling Time: ', 's'));

temp = (log(OS/100))^2;
zeta = sqrt(temp/(temp+pi^2));

omega_n = 4/(zeta*Ts);

Ki = omega_n^2/alpha
Kp = (2*zeta*omega_n-tau)/(alpha)
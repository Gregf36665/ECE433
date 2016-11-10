%% Calculate control parameters for pos control

%KP/SB motor
alpha_pos = 87.7886;
tau_pos = 52.1073;

Ts = 1; % Settle in one second
% Have no overshoot
zeta_pos = 1;

omega_pos = 4/(zeta_pos*Ts);

% Calculate control gains

%We have an extra pole, set it to something far away so it is not very
%dominant
p = 10*zeta_pos*omega_pos;

Kd_pos = (2*zeta_pos*omega_pos+p-tau_pos)/alpha_pos;
Kp_pos = (omega_pos^2+2*zeta_pos*omega_pos*p)/alpha_pos;
Ki_pos = (omega_pos^2*p)/alpha_pos;


%% Calculate control parameters for speed control
%GF/IM motor
alpha_fast = 66.9379;
tau_fast = 39.3285;

zeta_fast = 1;
omega_n_fast = 4/(zeta_fast*Ts);

Ki_fast = omega_n_fast^2/alpha_fast;
Kp_fast = (2*zeta_fast*omega_n_fast-tau_fast)/(alpha_fast);

%% Calculate control parameters for speed control
%GF/IM motor
alpha_slow = 66.9379;
tau_slow = 39.3285;

zeta_slow = 1;
omega_n_slow = 4/(zeta_slow*Ts);

Ki_slow = omega_n_slow^2/alpha_slow;
Kp_slow = (2*zeta_slow*omega_n_slow-tau_slow)/(alpha_slow);

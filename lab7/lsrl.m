clear

%% Generate simulation constants from real data

load data

% Parse the data file
t = Vm(:,1);
Vm = Vm(:,2);
W_tach= omega(:,2);
theta = theta(:,2);

% Set frequencies
fs = 1000; % sampling rate 1khz
fc = 35; % cutoff frequency
fcm = fc/(fs/2); % normalised cutoff frequency

% generate a butterworth filter
[b,a] = butter(2, fcm);

% Find motor speed
dtheta = diff(theta)*fs;

% Filter the speed
wf = filter(b,a,dtheta);
% remove phase shift by passing forwards and backwords
wff = filtfilt(b,a,dtheta);

dwf = filter(b,a,diff(wf) * fs);
dwff = filtfilt(b,a,diff(wff) * fs);

index = 21:length(t)-20;
W = [dwff(index), wff(index)];
Y = [Vm(index)];

Rw = transpose(W) * W;
Ry = transpose(Y) * Y;
Rwy = transpose(W) * Y;
Ryw = transpose(Rwy);

K = Rw \ Rwy; % \ is inverse not escape

Ei = sqrt((Ry - Ryw*inv(Rw)*Rwy)/Ry)

alpha = 1/K(1)
tau = alpha*K(2)

%% Calc ideal cutoff freq
fs = 1000;
index = 21:length(t)-20;
%frequency vectors
for f = [1:400]
    fcm = f/(fs/2);
    [b,a] = butter(2, fcm);
    % Find motor speed
    dtheta = diff(theta)*fs;
    % remove phase shift by passing forwards and backwords
    wff = filtfilt(b,a,dtheta);
    %find derivative
    dwff = filtfilt(b,a,diff(wff) * fs);
    % find error
    W = [dwff(index), wff(index)];
    Y = [Vm(index)];

    Rw = transpose(W) * W;
    Ry = transpose(Y) * Y;
    Rwy = transpose(W) * Y;
    Ryw = transpose(Rwy);
    Ei_list(f) = sqrt((Ry - Ryw*inv(Rw)*Rwy)/Ry);
end

plot(Ei_list)
[Ei_min, freq_min] = min(Ei_list)
%% Compare with new parameter simulation

Etheta_rms = sqrt(sum(theta(index)-theta_sim(index))^2/sum(theta(index))^2)*100

Eomega_rms = sqrt(sum(wff(index)-omega_sim(index))^2/sum(wff(index))^2)*100

subplot(2,1,1)
plot(t(index),theta(index),t(index),theta_sim(index))
xlabel('time (s)');
ylabel('ang pos (rad)');
title(sprintf('Simulated and actual positions Error: %f%%', Etheta_rms));
subplot(2,1,2)
plot(t(index),wff(index),t(index),omega_sim(index))
xlabel('time (s)');
ylabel('ang speed (rad/s)');
title(sprintf('Simulated and actual ang vel Error: %f%%', Eomega_rms));

fprintf('Cutoff freq: %i Hz\n', fc)
fprintf('Error index: %f\n', Ei)
fprintf('alpha: %f\n', alpha)
fprintf('tau: %f\n', tau)
% parameters for the speaker

R = 5;
L = 0.05E-3;
k = 2E5;
b = 50;
m = 4E-3;
r = 0.04;
N = 50;
beta = 0.25;

Kf = 2*pi*r*N*beta;

num = [Kf];
den = [(L*m), (L*b+R*m), (L*k+R*b + Kf^2), R*k];

figure(1);
step(num, den)
stepinfo(tf(num, den))

figure(2);
bode(tf(num, den))

%% part 4

bode(tf(num,den), 100:30000)
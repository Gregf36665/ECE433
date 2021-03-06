%% Problem 1
clear

%Part A
disp('Part a')
%denom
disp(roots([1,2,-1,1]))
%num
disp(roots([1,0,2]))

a = tf([1,0,2], [1,2,-1,1]);
disp(pole(a))
disp(tzero(a))

figure(1)
pzmap(a)


%Part B
disp('Part b')
disp(roots([1,0,2,0,1]))
disp(roots([1,0,0,1]))

b = tf([1,0,0,1], [1,0,2,0,1]);
disp(pole(b))
disp(tzero(b))

figure(2)
pzmap(b)


%Part C
disp('Part c')
disp(roots([2,8,18,20]))
disp(roots([4,8,10]))

c = tf([4,8,10], [2,8,18,20]);
disp(pole(c))
disp(tzero(c))

figure(3)
pzmap(c)

figure(4)
iopzmap(a,b,c)

num = conv([6], [1,5]);
denom = conv([1,3,1], [1,3,1]);
denom = conv([1,6], denom);
denom = conv([1,6,5,3], denom);
disp(num)
disp('------------------------------------------------------------------')
disp(denom)

ta = tf([6], [1,3,1]);
tb = tf([1,5], [1,3,1]);
tc = tf([1], [1,6]);
td = tf([1], [1,6,5,3]);

t = ta*tb*tc*td

%% Problem 2
clear global

a_num = poly([-1,-2]);
a_den = poly([-3,-1-1i*3,-1+1i*3]);
disp(a_num)
disp('------------------------------------------------------------------')
disp(a_den)

zpk([-1,-2],[-3,-1-1i*3,-1+1i*3],1)
[NUM, DEN] = zp2tf([-1;-2],[-3,-1-1i*3,-1+1i*3],1);
disp(NUM)
disp(DEN)

disp('B:')
b_num = 3*poly([-3,-1]);
b_den = poly([-2,-2+1i,-2-1i]);
disp(b_num)
disp('------------------------------------------------------------------')
disp(b_den)

zpk([-3,-1],[-2,-2+1i,-2-1i],3)
[NUM, DEN] = zp2tf([-3;-1],[-2,-2+1i,-2-1i],3);
disp(NUM)
disp(DEN)

% part 5 + 6

zpk(roots([2,4,-16]),roots([1,6,11,6]),2)
[Z,P,K] = tf2zp([2,4,-16],[1,6,11,6]);
zpk(Z,P,K) % ZPK looks prettier

%% Part 7 of Q2
clear

% part a
disp('A');
NUM = [-1,-4];
DEN = [1,3,2];
[R,P,K] = residue(NUM,DEN);
disp(R);
disp(P);
disp(K);

% part b
disp('B');
NUM = [1,2,5,3,6];
DEN = [1,12,39,28];
[R,P,K] = residue(NUM,DEN);
disp(R);
disp(P);
disp(K);

% part c
disp('C')
NUM = [2,-1];
DEN = [1,2,1];
[R,P,K] = residue(NUM,DEN);
disp(R);
disp(P);
disp(K);

%% part 8 and 9 of Q2
clear
H = tf([8],[1,1,2]);

step(H)
ltiview(H)

%% part 10 Q2
clear

H = tf([1],[1,2,5]);
[A,B,C,D] = tf2ss([1],[1,2,5]);
t = 0:0.01:15;
lsim(A,B,C,D,sin(5*t), t, [0; 2])

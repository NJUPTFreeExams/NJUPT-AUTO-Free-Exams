%% 实验一
% Question: 1
% way1
res = [];
for i= 1: 1000
%    res(end+1) = pow2(1, i);
    res(end+1) = 2 ^ i;
end
sum(res, 2)

% way 2
out = sum(2 .^( 1: 1000), 2)


% Question: 2
syms x;
y1 = trif('sin', x);
y2 = trif('cos', x);

x = pi/2;
y1 = trif('sin', x);
x = pi/3;
y2 = trif('cos', x);



%% 实验二
% (1)
clear all;clc;
tspan = [0 20];
y0 = [0, 1];
ps = 1;
[T1, Y1] = ode45('vdp', tspan, y0, odeset, ps)
ps = 2;
[T2, Y2] = ode45('vdp', tspan, y0, odeset, ps)
plot(T1, Y1(:, 1), 'r', T2, Y2(:, 1), 'b-.');
 
% (2)
clear all;clc;
sys1 = zpk(-0.5, 0.1, 1);
sys2 = zpk([], [0, -2, -10], 20);
sys3 = series(sys1, sys2);
sys = feedback(sys3, 1, -1);

figure;
step(sys)

figure;
[U, T] = gensig('square', 15, 30);
lsim(sys, U, T)


figure;
[U, T] = gensig('sin', 15, 30);
lsim(sys, U, T)

% (3)
sysc = tf(1, [1, 0.2, 1.01]);
step(sysc);

Ts = 0.3;
method = 'zoh';
sysd = c2d(sysc, Ts, method);
[num, den] = tfdata(sysd, 'v');
dstep(num, den)

% (4）
clear all; clc;
model = zpk(0.7, 0.5, 1, 0.1);
sys = d2d(model, 0.05)

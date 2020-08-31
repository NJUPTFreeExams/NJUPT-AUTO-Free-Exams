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


%% 第三次实验
% 1.(1)
G = zpk([], [-1, -0.5, -1/3] , 10/6);
figure;
subplot(1, 2, 1)
nyquist(G)
subplot(1, 2, 2)
bode(G)

% 1.(2)
G2=zpk([],[0 -1 -1/10],1);
figure
subplot(1,2,1)
nyquist(G2)
subplot(1,2,2)
bode(G2)

% 1.(3)
G3=zpk([],[0 0 -10 -5],500);
figure
subplot(1,2,1)
nyquist(G3)
subplot(1,2,2)
bode(G3)


% 1.(4)
G4=zpk([],[0 0 -10 -0.1],10);
figure
subplot(1,2,1)
nyquist(G4)
subplot(1,2,2)
bode(G4)

% 2
clear; clc;
wn=90;
xi = 0.2;
 
for k=1:1:100
    Gk=tf([k],[1/(wn^2),2*xi/wn,1,0]);
    [Gm,Pm,Wcg,Wcp]=margin(Gk);
    if Wcp<=Wcg
        k % the last one is the k’s max value 
    else
        break;
    end 
end

% 3
clear;clc;
G1=0.5;
G2=tf([2,0],[2,1]);
G3=zpk([],[0,-2,-1],1);
G=parallel(G1,-G2);
 
sysK=series(G,G3);
sys=feedback(sysK,1,-1);
figure
margin(sysK)

ltiview;



% 4
clear;clc;
T1=0.01;
T2=1;
G=zpk([],[0 -1],10);
H=1;
Gz1=c2d(G,T1,'zoh');
Gz2=c2d(G,T2,'zoh');
 
[num1,den1,T1]=tfdata(Gz1,'v');
[num2,den2,T2]=tfdata(Gz2,'v');

% T1
figure;
subplot(1 ,2, 1)
dbode(num1,den1,T1)
 
subplot(1 ,2, 2)
dnyquist(num1,den1,T1)
 
% T2
figure;
subplot(1 ,2, 1)
dbode(num2,den2,T2)
 
subplot(1 ,2, 2)
dnyquist(num2,den2,T2)
 
% T1 Step
figure;
Gb1 = feedback(Gz1,1,-1);
[numb1, denb1, Ts1] = tfdata(Gb1,'v');
dstep(numb1,denb1)

% T2 Step
figure;
Gb2 = feedback(Gz2,1,-1);
[numb2, denb2, Ts2] = tfdata(Gb2,'v');
dstep(numb2,denb2)


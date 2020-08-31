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


%% 实验四
% 第一题
% (1)计算改变增益前后，系统开环对数频率特性。
Gp=tf(1,[2 1])*tf(1,[0.5 1])*tf(1,[0.05 1])*4;        
Gp1=Gp*49/4;                                         
figure(1);
margin(Gp)              
figure(2);
margin(Gp1)             
 
%（2）计算改变增益后，具有希望相位裕度的 系统开环对数幅频穿越频率wc。
% P166  Gp1(jwc) = -180() + 60 + 10 = -110
W = logspace(-1,2,100);    
[mag ph] = bode(Gp1,W);    
mag=reshape(mag,100,1);    
ph=reshape(ph,100,1);      
wc=interp1(ph,W,-110)      
 
%（3）确定校正环节参数即beta和T1
% 1） 在wc处校正环节的对数幅度值应满足：20lgbeta = 20lg|Gp1（jwc）|
% 2) 一阶微分环节转折频率1/T1 可以根据相位裕度的变化进行调整
mag110=interp1(ph,mag,-110)     
Beta=mag110                     
T1=6/wc, BT1=Beta*T1            
Gc=tf([T1,1],[BT1,1])           
 
% (4) 系统校核   
% 计算Gc（s）G(s)构成的系统频域性能指标，确定是否满足要求，
sys=Gc*Gp1;
figure(3)
margin(sys)
 
%（5）时间响应比较
figure(4);
subplot(2,1,1);
step(feedback(Gp1,1,-1))
subplot(2,1,2);
step(feedback(sys,1,-1),'r')


% 第二题
clear all
% (1)  系统开环对数频率特性。
Gp1=tf(1,[1 0])*tf(1,[0.5 1])*tf(1,[0.15 1])*7;        
figure;
margin(Gp1)
 
%（2）计算改变增益后，具有希望相位裕度的 系统开环对数幅频穿越频率wc。
% 根据P166 相位裕度公式可得：r = -180 + Q(wc)  = 45 + 10（预补偿量）
W = logspace(-1,2,100);     
[mag ph] = bode(Gp1,W);     
mag=reshape(mag,100,1);     
ph=reshape(ph,100,1);       
wc=interp1(ph,W,-125)       
% wc = 0.9970
 
%（3）确定校正环节参数即beta和T1
% 1） 在wc处校正环节的对数幅度值应满足：20lgbeta = 20lg|Gp1（jwc）|
% 2) 一阶微分环节转折频率1/T1 可以根据相位裕度的变化进行调整
mag110=interp1(ph,mag,-125);     
Beta=mag110;                     
T1=6/wc, BT1=Beta*T1;            
Gc=tf([T1,1],[BT1,1]);           
 
% (4) 系统校核   
% 计算Gc（s）G(s)构成的系统频域性能指标，确定是否满足要求，
sys=Gc*Gp1;
figure(2);
margin(sys)
 
%（5）时间响应比较
figure(3);
subplot(2,1,1);
step(feedback(Gp1,1,-1))
subplot(2,1,2);
step(feedback(sys,1,-1),'r')


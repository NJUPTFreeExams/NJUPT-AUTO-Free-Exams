clear, clc;
% 变量定义
syms x1 x2;
x=[x1;x2];
A=[0,1;0,0];
B=[0;1];
C=[1,0];
D=0;
Q=[2 0;0 0];R=2;
 
n = size(A);
r = rank(ctrb(A,B));   % 判断可控性
s = rank(obsv(A,C));   % 判断可观测性
if  n == r
    display("controllable")
end
if  n == s
    display("observable")
end
% 
[K,P,E]=lqr(A,B,Q,R);
u=-inv(R)*B'*P*x;
Ac=A-B*K;
Bc=B;
Cc=C;
Dc=D;
figure(1);
step(Ac,Bc,Cc,Dc)
 
X0 = [1;2];
sys1=ss(Ac,Bc,Cc,Dc);        % 状态反馈系统
t=0:0.01:10;
[y,t,x]=initial(sys1,X0,t);  % 零输入状态和输出
figure(2);
plot(t,x(:,1:2))
title('最优控制率下的系统状态响应曲线');
xlabel('Time(s)');
ylabel('x');

    %% Chapter1-1
% 打开matlab，点击“home”(主页)按钮。然后会看到layout(布局)，点开会出来界面，第一个Dafault(默认)就可以还原默认的界面；
% 分为"选择布局"和"显示"根据相应要求选择即可
% 如果想对某一个窗口进行设定的话，可以拖动窗口与窗口之间的细线; 以及可以对着窗口右击，里面有可以选择的，最大化，最小化等。

% Chapter1-3
% Abc、wu_2004

% Chapter1-4 
% 1
ans = [12+2*(7-4)]/3^2
% 2
A = [1, 2, 3; 4, 5, 6; 7, 8, 9]
% 3
clear;x = -8:0.5:8;
y = x';
X = ones(size(y))*x;
Y = y*ones(size(x));
R = sqrt(X.^2+Y.^2)+eps;
Z = sin(R)./R;
mesh(X,Y,Z);
colormap(hot)
xlabel('x'),ylabel('y'),zlabel('z')



%% Chapter2-1
clear, clc;
% 由于指令窗不好呈现, 因此直接写在文件中
x = 1: 0.2: 2
y = 2: 0.2: 1
% results:
% x =
%     1.0000    1.2000    1.4000    1.6000    1.8000    2.0000
% y =
%   空的 1×0 double 行矢量


% Chapter2-2
clear, clc;
% First:
x = linspace(0, 2*pi, 50)
% Second
y = 0: 2*pi/(50-1): 2*pi


% Chapter2-3
clear, clc;
t = linspace(0, 2*pi, 10);
y = sin(t).*exp(-2*t)


% Chapter2-4
clear, clc;
A = [1 2; 3 4];
B = [5 6; 7 8];
C = A*B
D = A.*B
% results:
% C =
%     19    22
%     43    50
% D =
%      5    12
%     21    32

% Chapter2-5
clear, clc;
A = [1 2; 3 4];
A(:, 3) = [5; 6];
A_NEW = reshape(A, 3, 2)
%
% ans =
%      1     4
%      3     5
%      2     6
A_NEW(:,1) = []
% results:
% A_NEW =
%      4
%      5
%      6


% Chapter2-6
clear, clc;
A = [0 2 3 4; 1 3 5 0];
B = [1 0 5 3; 1 5 0 5];
one = A&B
two = A|B
three = ~A
four = A==B
five = A > B
% one =
%   2×4 logical 数组
%    0   0   1   1
%    1   1   0   0
% two =
%   2×4 logical 数组
%    1   1   1   1
%    1   1   1   1
% three =
%   2×4 logical 数组
%    1   0   0   0
%    0   0   0   1
% four =
%   2×4 logical 数组
%    0   0   0   0
%    1   0   0   0
% five =
%   2×4 logical 数组
%    0   1   0   1
%    0   0   1   0

% Chapter2-7
clear, clc;
A = randn(3, 3)
f1 = floor(A)
f2 = ceil(A)
f3 = fix(A)
f4 = round(A)
% Results:
% A =
%    -0.3034    0.8884   -0.8095
%     0.2939   -1.1471   -2.9443
%    -0.7873   -1.0689    1.4384
% f1 =
%     -1     0    -1
%      0    -2    -3
%     -1    -2     1
% f2 =
%      0     1     0
%      1    -1    -2
%      0    -1     2
% f3 =
%      0     0     0
%      0    -1    -2
%      0    -1     1
% f4 =
%      0     1    -1
%      0    -1    -3
%     -1    -1     1

% Chapter2-8
clear, clc;
A = [1 2; 3 4];
A(:, 3) = [5; 6];
A_NEW = reshape(A, 3, 2)
A_NEW(:,1) = []
ans = num2str(A_NEW)
sA = size(A_NEW),sStr = size(ans)
% A_NEW =
%      4
%      5
%      6
% ans =
%   3×1 char 数组
%     '4'
%     '5'
%     '6'
% sA =
%      3     1
% sStr =
%      3     1





%% Chapter3
% 3-1
clear; clc;
t = 0:0.02: 18;     
% size(t) => 1   901
xi = [0.2, 0.4, 0.6, 0.8];
beta = sqrt(1-xi.^2)
sita = atan(beta./xi)
% size(...) => 1   4
y = 1-exp(-xi'.*t).*sin(beta'.*t+sita'*ones(1, 901))./(beta'.*ones(1, 901))
size(y)
plot(t, y(1,:), 'r-', t, y(2,:), 'g*', t, y(3, :),  'b+', t, y(4, :), 'k.')
text(3.4, 1.4, '\xi = 0.2');
text(3.0, 0.85, '\xi = 0.8');


% 3-2
clear all;
x = -1: 0.01: 1;
y = -1: 0.01: 1;
[X, Y] =meshgrid(x,y)
one = sqrt((1-X).^2 + Y.^2);
two = sqrt((1+X).^2 + Y.^2);
z = 1./(one + two);
subplot(1,3,1)
plot3(X, Y ,z);
% plot3(x, y ,z);
subplot(1,3,2)
mesh(X, Y, z);
% mesh(x, y, z);
subplot(1,3,3);
% surf(x, y, z);
surf(X, Y, z);

%% Chapter4
%4-1
%for循环
K = 0;
for i=0:1:63
   K = 2^i+K
end
%while循环
K=0;i=0;
while i<64
 K = 2^i+K
i=i+1
end
%避免循环
i= 0:63;
a=pow2(i);
K=sum(a,2)


%4-2
clear all;clc;
a=30; t=(0:a)/a*2*pi;
sss={'base','caller','self'}
for k=1:3
    y0=mainfun(8,sss{k});
    plot(real(y0),imag(y0),'r','lineWidth',3)
    hold on
    axis square
end

%4-3
clear all;clc;
syms t
x= [0:0.02:18] 
xi=0.5; wn=5
wd=wn*sqrt(1-xi^2)
sita=atan(sqrt(1-xi^2)/xi)
y=1-exp(-xi*wn*t).*sin(wd*t+sita)./sqrt(1-xi^2)
dy=diff(y)
F=subs(dy, x)
figure;
plot(x,F)

%4-4
syms x;
y1 = trif('sin',x);
y2 = trif('cos',x);
y1,y2

%% Chapter5
% 5.1(1)
sys1 = tf([1 35 291 1093 1700], [1, 289 254 2541 4684 1700]);

% 5.1(2)
z=-3;
p=[-1 -5 -15];
k=15;
sys2 = zpk(z,p,k)

% 5.1(3)
sys3 = tf([1 3 2],[1 2 5 2])*zpk([0 -2 -2],[-1 1],100)

%5.2
res1=ss(sys1)
sys2=ss(sys2)
sys3=ss(sys3)

%5.3
A=[3 2 1;0 4 6;0 -3 -5];
B=[1 2 3]';
C=[1 2 5];
D=0;    
sys3=ss(A,B,C,D)

%5.4
sys41=tf(sys3)
sys42=zpk(sys3)

%5.5(1)
sys51=tf([1 2 0],[1 15 50 500])
%5.5(2)
sys52=tf([4 0],[1 3 6 4])



%% Chapter6
%6-2
u=1;
[T1,Y1]=ode45('vdpp',[0 20],[0 1],1,u);
u=2;
[T2,Y2]=ode45('vdpp',[0 20],[0 1],1,u);
plot(T1,Y1(:,1),T2,Y2(:,1));
Y1(:,1),Y2(:,1)

%6-3-1
G1=tf([1 0.5],[1,0.1]);
G2=zpk([],[0 -2 -10],20);
G3=G1*G2;
G4=feedback(G3,-1);

%6-3-2
subplot(1,2,1);
step(G4);

%6-3-3
[u,t]=gensig('square',30,60);
subplot(1,2,2);
lsim(G4,u,t);

%6-4-1
G1=tf(1,[1 0.2 1.01]);
subplot(1,2,1);
step(G1);
%6-4-2
G2=c2d(G1,0.3,'zoh');
[num den]=tfdata(G2,'v');
subplot(1,2,2);
dstep(num,den);

%6-5
H=tf([1 -0.7],[1 -0.5],0.1);
H1=d2d(H,0.05);


%% Chapter7
%7-1
G1=zpk([],[-1 -0.5 -1/3],5/3);
subplot(1,2,1);
margin(G1);
subplot(1,2,2);
nyquist(G1);

G2=zpk([],[0 -1 -0.1],1);
subplot(1,2,1);
margin(G2);
subplot(1,2,2);
nyquist(G2);

G3=zpk([],[0 0 -10 -5],500);
subplot(1,2,1);
margin(G3);
subplot(1,2,2);
nyquist(G3);

G4=zpk([],[0 0 -10 -0.1],2);
subplot(1,2,1);
margin(G4);
subplot(1,2,2);
nyquist(G4);


%7-2
G = tf([1], [1/90^2 0.4/90 1 0]);
[Gm Pm Wcg Wcp] = margin(G);
K=Gm;


%7-4
G=zpk([],[0 -1],10);
G1=c2d(G,1,'zoh');G2=c2d(G,0.01,'zoh');
[num1 den1 ts1]=tfdata(G1,'v');[num2 den2 ts2]=tfdata(G2,'v');

figure(1)
subplot(1,3,1)
dbode(num1,den1,ts1);
subplot(1,3,2)
dnyquist(num1,den1,ts1);
subplot(1,3,3) 
dstep(num1,den1);
suptitle('T=1s');

figure(2)
subplot(1,3,1)
dbode(num2,den2,ts2);
subplot(1,3,2)
dnyquist(num2,den2,ts2);
subplot(1,3,3) 
dstep(num2,den2);
suptitle('T=0.01s');

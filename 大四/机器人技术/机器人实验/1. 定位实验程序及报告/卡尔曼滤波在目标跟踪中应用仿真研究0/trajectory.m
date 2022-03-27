function [X,Y]=trajectory(Ts,offtime)
% 产生真实航迹[X,Y]，并在直角坐标系下显示出
% Ts为雷达扫描周期，每隔Ts秒取一个观测数据
% 最初做匀速运动，接下来进行两个90度的机动转弯

if nargin>2
    error('输入的变量过多，请检查');
end

if offtime<600
    error('仿真时间必须大于600s，请重新输入');
end

x=zeros(offtime,1);
y=zeros(offtime,1);
X=zeros(ceil(offtime/Ts),1);
Y=zeros(ceil(offtime/Ts),1);

% t=0:400s，速度vx,vy为沿x和y轴的速度分量(m/s)
x0=2000;%起始点坐标
y0=10000;
vx=0;
vy=-15; % 沿-y方向

for t=1:400
    x(t)=x0+vx*t;
    y(t)=y0+vy*t;
end

% t=400:600s，ax,ay为沿x和y轴的加速度分量(m/s/s)
ax=0.075;
ay=0.075;

for t=0:200
    x(t+401)=x(400)+vx*t+ax*t*t/2;
    y(t+401)=y(400)+vy*t+ay*t*t/2;
end

vx=vx+ax*200; % 第一次机动转弯结束时的速度
vy=vy+ay*200;

% t=600:610s匀速运动
for t=0:10
    x(t+601)=x(601)+vx*t;
    y(t+601)=y(601)+vy*t;
end

% t=610:660s，第二次转弯
ax=-0.3;
ay=0.3;

for t=0:50
    x(t+611)=x(611)+vx*t+ax*t*t/2;
    y(t+611)=y(611)+vy*t+ay*t*t/2;
end

vx=vx+ax*(660-610);% 第二次机动转弯结束时的速度
vy=vy+ay*(660-610);

% 660s以后匀速运动，一直到截止时间
for t=0:(offtime-660)
    x(t+661)=x(661)+vx*t;
    y(t+661)=y(661)+vy*t;
end

% 得到雷达的观测数据
for n=0:Ts:offtime
    X(n/Ts+1)=x(n+1);
    Y(n/Ts+1)=y(n+1);
end


%显示真实轨迹
plot(X,Y,'LineWidth',2),axis([1800 4500 2000 10000]),grid on;
legend('目标真实航迹');

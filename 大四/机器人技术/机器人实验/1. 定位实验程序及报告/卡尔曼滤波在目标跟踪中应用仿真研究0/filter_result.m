function [XER,YER]=filter_result(Ts,mon,d)
% filter_result         对观测数据进行卡尔曼滤波，得到预测的航迹以及估计误差的均值和标准差
% Ts                    采样时间，即雷达的工作周期
% mon                   进行Monte-Carlo仿真的次数
% d                     测量的误差,单位m
%返回值包括滤波预测后的估计航迹,以及均值和误差协方差
Ts=2;
mon=50;
d=100;

if nargin>3
    error('Too many input arguments.');
end

offtime=800;

% 产生理论的航迹
[x,y]=trajectory(Ts,offtime);
Pv=d*d;
N=ceil(offtime/Ts);

randn('state',sum(100*clock)); % 设置随机数发生器
for i=1:N
   vx(i)=d*randn(1); % 观测噪声，两者独立
   vy(i)=d*randn(1);
   zx(i)=x(i)+vx(i); % 实际观测值
   zy(i)=y(i)+vy(i);
end

% 产生观测数据
for n=1:mon
    % 用卡尔曼滤波得到估计的航迹
    XE=Kalman_filter(Ts,offtime,d,0); 
    YE=Kalman_filter(Ts,offtime,d,1);
    %误差矩阵
    XER(1:N,n)=x(1:N)-(XE(1:N))';
    YER(1:N,n)=y(1:N)-(YE(1:N))';
end



%滤波误差的均值
XERB=mean(XER,2);
YERB=mean(YER,2);

%滤波误差的标准差
XSTD=std(XER,1,2); % 计算有偏的估计值，flag='1'
YSTD=std(YER,1,2);

%作图
figure
plot(x,y,'r');hold on;
plot(zx,zy,'g');hold on;
plot(XE,YE,'b');hold off;
axis([1500 5000 1000 10000]),grid on;
legend('真实轨迹','观测数据','滤波估计');

figure
subplot(2,2,1)
plot(XERB)
axis([0 500 -50 50])
xlabel('观测次数')
ylabel('X方向滤波误差均值'),grid on;
subplot(2,2,2)
plot(YERB)
axis([0 500 -50 50])
xlabel('观测次数')
ylabel('Y方向滤波误差均值'),grid on;
subplot(2,2,3)
plot(XSTD)
axis([0 500 0 150])
xlabel('观测次数')
ylabel('X方向滤波误差标准值'),grid on;
subplot(2,2,4)
plot(YSTD)
axis([0 500 0 150])
xlabel('观测次数')
ylabel('Y方向滤波误差标准值'),grid on;

X=XER;Y=YER;
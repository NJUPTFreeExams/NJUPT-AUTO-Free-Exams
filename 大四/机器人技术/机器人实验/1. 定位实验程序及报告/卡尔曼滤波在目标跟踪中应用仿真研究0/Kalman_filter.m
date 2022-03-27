function XE=Kalman_filter(Ts,offtime,d,Flag)
% Kalman_filter             采用Kalman滤波方法，从观测数值中得到航迹的估计
% XE                        输出x轴方向上的误差
% Ts                        采样时间，即雷达工作周期
% offtime                   仿真截止时间
% d                         噪声的标准差值
% Flag                      判断计算x轴或y轴数据,'0'--x,'1'--y
if nargin>4
    error('输入的变量过多，请检查');
end

if offtime<600
    error('仿真时间必须大于600s，请重新输入');
end

Pv=d*d; % 噪声的功率
N=ceil(offtime/Ts); % 采样点数
sigma=10;% 加速度方向的的扰动

switch Flag
    case 0
        a=[zeros(1,400) 0.075*ones(1,200) zeros(1,10) -0.3*ones(1,50) zeros(1,offtime-660)]; % 对不同时段的加速度进行描述
    case 1
        a=[zeros(1,400) 0.075*ones(1,200) zeros(1,10)  0.3*ones(1,50) zeros(1,offtime-660)];
    otherwise
        error('输入仅能为0或1');
end 

% 定义系统的状态方程
Phi=[1,Ts;0,1];
Gamma=[Ts*Ts/2;Ts];
C=[1 0];
R=Pv;
Q=sigma^2;W=[];

randn('state',sum(100*clock)); % 设置随机数发生器
for n=0:Ts:offtime-1
    W(n/Ts+1)=a(n+1)+sigma*randn(1,1);
end


Xest=zeros(2,1); % 用前k-1时刻的输出值估计k时刻的预测值
Xfli=zeros(2,1); % k时刻Kalman滤波器的输出值
Xes=zeros(2,1); % 预测输出误差
Xef=zeros(2,1); % 滤波后输出的误差
Pxe=zeros(2,1); % 预测输出误差均方差矩阵 
Px=zeros(2,1);  % 滤波输出误差均方差矩阵
XE=zeros(1,N); % 得到最终的滤波输出值，仅仅考虑距离分量

[x,y]=trajectory(Ts,offtime); % 产生理论的航迹

for i=1:N
   vx(i)=d*randn(1); % 观测噪声，两者独立
   vy(i)=d*randn(1);
   zx(i)=x(i)+vx(i); % 实际观测值
   zy(i)=y(i)+vy(i);
end

switch Flag
    case 0
        Xfli=[zx(2) (zx(2)-zx(1))/Ts]'; %利用前两个观测值来对初始条件进行估计
        Xef=[-vx(2) Ts*W(1)/2+(vx(1)-vx(2))/Ts]';
        Px=[Pv,Pv/Ts;Pv/Ts,2*Pv/Ts+Ts*Ts*Q/4];

        for k=3:N
        Xest=Phi*Xfli; % 更新该时刻的预测值
        Xes=Phi*Xef+Gamma*W(k-1); % 预测输出误差
        Pxe=Phi*Px*Phi'+Gamma*Q*Gamma'; % 预测误差的协方差阵
        K=Pxe*C'*inv(C*Pxe*C'+R); % Kalman滤波增益
    
        Xfli=Xest+K*(zx(k)-C*Xest); 
        Xef=(eye(2)-K*C)*Xes-K*vx(k);
        Px=(eye(2)-K*C)*Pxe;
        
        XE(k)=Xfli(1,1);
        end
        
        XE(1)=zx(1);XE(2)=zx(2);
        
    case 1
        Xfli=[zy(2) (zy(2)-zy(1))/Ts]'; %利用前两个观测值来对初始条件进行估计
        Xef=[-vy(2) Ts*W(1)/2+(vy(1)-vy(2))/Ts]';
        Px=[Pv,Pv/Ts;Pv/Ts,2*Pv/Ts+Ts*Ts*Q/4];

        for k=3:N
        Xest=Phi*Xfli; % 更新该时刻的预测值
        Xes=Phi*Xef+Gamma*W(k-1); % 预测输出误差
        Pxe=Phi*Px*Phi'+Gamma*Q*Gamma'; % 预测误差的协方差阵
        K=Pxe*C'*inv(C*Pxe*C'+R); % Kalman滤波增益
    
        Xfli=Xest+K*(zy(k)-C*Xest); 
        Xef=(eye(2)-K*C)*Xes-K*vy(k);
        Px=(eye(2)-K*C)*Pxe;
        
        XE(k)=Xfli(1,1);
        end
        
        XE(1)=zy(1);XE(2)=zy(2);       
    otherwise
        error('False iuput nargin');
end




   
    

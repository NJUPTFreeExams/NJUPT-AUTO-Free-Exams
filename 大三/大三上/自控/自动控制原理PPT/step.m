figure;
num=[1];den=[1 0 1];
sys=tf(num,den);
t=0:0.1:30;
step(sys,t);
hold on ;
num=[1 1];den=[1 1 1];
sys=tf(num,den);
step(sys,t);
hold on ;
num=[1];den=[1 1 1];
sys=tf(num,den);
step(sys,t);
hold on ;
grid
xlabel('t');
ylabel('h(t)');
title('step response');


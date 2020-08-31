clc, clear;

%% Question: 1
% way1
res = [];
for i= 1: 1000
%    res(end+1) = pow2(1, i);
    res(end+1) = 2 ^ i;
end
sum(res, 2)

% way 2
out = sum(2 .^( 1: 1000), 2)


%% Question: 2
syms x;
y1 = trif('sin', x);
y2 = trif('cos', x);

x = pi/2;
y1 = trif('sin', x);
x = pi/3;
y2 = trif('cos', x);


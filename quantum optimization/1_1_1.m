clear all;
close all;
% 标记态与状态总数比值
t=0.001:0.001:1;
% 标记Grove算法迭代步数
r=round(acos(sqrt(t))./(2*asin(sqrt(t))));
% 标记Grove算法成功概率
P=sin((2*r+1).*asin(sqrt(t))).^2;
% 当t>1/3且旋转相位为π/2时，
% 经过一步迭代后算法成功概率
P1=4*t.^3-8*t.^2+5*t;
plot(t,P,t,P1)
grid on
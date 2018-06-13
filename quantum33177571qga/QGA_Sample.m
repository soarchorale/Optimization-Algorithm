function QGA_Sample
clc
clear all
close all

% figure
global QGA
% 目标函数
QGA.fun=@objfun;
% 种群大小
QGA.popsize=100;
% 最大代数
QGA.maxgen=200;
% 变量个数
QGA.nvars=2;
% 量子位长度
QGA.codesize=[40 50];
% 下边界
QGA.lb=[-3 4.1];
% 上边界
QGA.ub=[12.1 5.8];


for igen=1:QGA.maxgen
    disp('-----------------------------------------------------')
    disp(['迭代次数：',num2str(igen),' / ',num2str(QGA.maxgen)])
    QGA.igen=igen;
    % 初始化种群
    if igen==1
        QGA_Init
    end
    % 将量子变量转换为十进制
    QGA_Dec;
    % 计算目标函数
    QGA_Fitness;
    % 计算最优目标
    QGA_Best
    % 量子旋转门
    QGA_Gate
end
% QGA
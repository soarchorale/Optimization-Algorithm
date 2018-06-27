function rs=qga(fun,nvars,lb,ub,maxgen,popsize,codesize)
% 量子遗传算法计算目标函数最大值
%
% 输入参数：
% fun：适应度函数句柄
% nvars：自变量个数
% lb,ub：自变量上下限
% maxgen：最大迭代次数，默认500
% popsize：种群数量，默认100
% codesize：编码长度，默认20
%
% 输出参数：
% rs：包含程序运行中所有参数
%
% 举例说明：
% fun=@(x)x(1)*sin(4*pi*x(1))+x(2)*sin(20*pi*x(2));
% nvars=2;
% lb=[-3 4.1];ub=[12.1 5.8];
% qga(fun,nvars,lb,ub)
%
% By LaterComer of MATLAB技术论坛
% See also http://www.matlabsky.com
% Contact me matlabsky@gmail.com
% Modifid at 2012-01-31 14:31:14
%

global QGA

if nargin<4
    error('至少需要四个输入参数');
else
    QGA.fun=fun;
    QGA.nvars=nvars;
    QGA.lb=lb;
    QGA.ub=ub;
    if nargin==4
        QGA.maxgen=500;
        QGA.popsize=100;
        QGA.codesize=20;
    elseif nargin==5
        QGA.maxgen=maxgen;
        QGA.popsize=100;
        QGA.codesize=20;
    elseif nargin==6
        QGA.maxgen=maxgen;
        QGA.popsize=popsize;
        QGA.codesize=20;
    else
        QGA.maxgen=maxgen;
        QGA.popsize=popsize;
        QGA.codesize=codesize;
    end
end
rs=QGA;

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
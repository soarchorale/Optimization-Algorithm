function rs=qga(fun,nvars,lb,ub,maxgen,popsize,codesize)
% �����Ŵ��㷨����Ŀ�꺯�����ֵ
%
% ���������
% fun����Ӧ�Ⱥ������
% nvars���Ա�������
% lb,ub���Ա���������
% maxgen��������������Ĭ��500
% popsize����Ⱥ������Ĭ��100
% codesize�����볤�ȣ�Ĭ��20
%
% ���������
% rs�������������������в���
%
% ����˵����
% fun=@(x)x(1)*sin(4*pi*x(1))+x(2)*sin(20*pi*x(2));
% nvars=2;
% lb=[-3 4.1];ub=[12.1 5.8];
% qga(fun,nvars,lb,ub)
%
% By LaterComer of MATLAB������̳
% See also http://www.matlabsky.com
% Contact me matlabsky@gmail.com
% Modifid at 2012-01-31 14:31:14
%

global QGA

if nargin<4
    error('������Ҫ�ĸ��������');
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
    disp(['����������',num2str(igen),' / ',num2str(QGA.maxgen)])
    QGA.igen=igen;
    % ��ʼ����Ⱥ
    if igen==1
        QGA_Init
    end
    % �����ӱ���ת��Ϊʮ����
    QGA_Dec;
    % ����Ŀ�꺯��
    QGA_Fitness;
    % ��������Ŀ��
    QGA_Best
    % ������ת��
    QGA_Gate
end
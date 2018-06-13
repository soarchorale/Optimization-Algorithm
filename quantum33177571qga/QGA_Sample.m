function QGA_Sample
clc
clear all
close all

% figure
global QGA
% Ŀ�꺯��
QGA.fun=@objfun;
% ��Ⱥ��С
QGA.popsize=100;
% ������
QGA.maxgen=200;
% ��������
QGA.nvars=2;
% ����λ����
QGA.codesize=[40 50];
% �±߽�
QGA.lb=[-3 4.1];
% �ϱ߽�
QGA.ub=[12.1 5.8];


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
% QGA
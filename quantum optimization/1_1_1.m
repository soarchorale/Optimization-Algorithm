clear all;
close all;
% ���̬��״̬������ֵ
t=0.001:0.001:1;
% ���Grove�㷨��������
r=round(acos(sqrt(t))./(2*asin(sqrt(t))));
% ���Grove�㷨�ɹ�����
P=sin((2*r+1).*asin(sqrt(t))).^2;
% ��t>1/3����ת��λΪ��/2ʱ��
% ����һ���������㷨�ɹ�����
P1=4*t.^3-8*t.^2+5*t;
plot(t,P,t,P1)
grid on
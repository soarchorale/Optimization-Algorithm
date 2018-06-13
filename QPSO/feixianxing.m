%���������
function [ci,ypred,delta,msE,x,y]=feixianxing
%������ԭʼ���ݵĲ���
K=0.3;
x=[0 1 2 3 4 5 6 7 8 9 10]'; %ԭʼ�����Ա���
y0=1.123243121788667*10^4*exp(0.104185011521190*x);   %�����ģ��
y_noise=K*(rand(size(x))-0.5);
y=y0+y_noise;
%��������ϼ������������
a0=[1 1];
options=statset('Jacobian','on');
[a,r,J,~,msE]=nlinfit(x,y,@twoexps,a0,options);
ci=nlparci(a,r,'jacobian',J);
[ypred,delta]=nlpredci(@twoexps,x,a,r,'jacobian',J,'predopt','observation','simopt','on');
function yhat=twoexps(a,x)
x=x(:);
yhat=a(1)*exp(a(2)*x);  %���ģ��
end
end
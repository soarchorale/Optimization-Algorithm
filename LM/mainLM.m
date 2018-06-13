clc;clear;
% 计算函数f 的雅克比矩阵，是解析式
syms a b x;
f=a*exp(-b*x);
Jsym=jacobian(f,[a b]);
% 拟合数据
data_1=[0.25 0.5 1 1.5 2 3 4 6 8];
obs_1=[19.21 18.15 15.36 14.10 12.89 9.32 7.45 5.24 3.01];
% LM 算法
a0=10; b0=0.5;
Nparams=2; n_iters=100;
[a_est,b_est] = LM( data_1,obs_1,a0,b0,Nparams,n_iters )
% X = [a_est,b_est];
% d = feval( 'myfun', X)
[a_est,b_est,iters] = myLM( a0,b0,Nparams,n_iters,'myfun' )
% X = [a_est,b_est];
% d = feval( 'myfun', X)
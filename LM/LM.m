function [a_est,b_est] = LM( data_1,obs_1,a0,b0,Nparams,n_iters )
% 拟合数据:
% data_1=[0.25 0.5 1 1.5 2 3 4 6 8];
% obs_1=[19.21 18.15 15.36 14.10 12.89 9.32 7.45 5.24 3.01];
% 初始猜测值   a0=10; b0=0.5;
% 参数维数     Nparams
% 迭代最大次数 n_iters

% 数据个数
Ndata=length(data_1);
% LM 算法的阻尼系数初值
lamda=0.01;
% step1: 变量赋值
updateJ=1;
a_est=a0;
b_est=b0;
% step2: 迭代
for it=1:n_iters
    if updateJ==1
        % 根据当前估计值，计算雅克比矩阵
        J=zeros(Ndata,Nparams);
        for i=1:length(data_1)
            J(i,:)=[exp(-b_est*data_1(i)) -a_est*data_1(i)*exp(-b_est*data_1(i))];
        end
        % 根据当前参数，得到函数值
        y_est = a_est*exp(-b_est*data_1);
        % 计算误差
        d=obs_1-y_est;
        % 计算（拟）海塞矩阵
        H=J'*J;
        % 若是第一次迭代，计算误差
        if it==1
            e=dot(d,d);
        end
    end
    % 根据阻尼系数lamda 混合得到H 矩阵
    H_lm=H+(lamda*eye(Nparams,Nparams));
    % 计算步长dp，并根据步长计算新的可能的参数估计值
    dp=inv(H_lm)*(J'*d(:));
    g = J'*d(:);
    a_lm=a_est+dp(1);
    b_lm=b_est+dp(2);
    % 计算新的可能估计值对应的y 和计算残差e
    y_est_lm = a_lm*exp(-b_lm*data_1);
    d_lm=obs_1-y_est_lm;
    e_lm=dot(d_lm,d_lm);
    % 根据误差，决定如何更新参数和阻尼系数
    if e_lm<e
        lamda=lamda/10;
        a_est=a_lm;
        b_est=b_lm;
        e=e_lm;
        updateJ=1;
    else
        updateJ=0;
        lamda=lamda*10;
    end
end

function [a_est,b_est,iters] = myLM( a0,b0,Nparams,n_iters,myfun )
% 拟合数据:
% 初始猜测值   a0=10; b0=0.5;
% 参数维数     Nparams
% 迭代最大次数 n_iters

% LM 算法的阻尼系数初值
lamda=0.01;
% step1: 变量赋值
updateJ=1;
a_est=a0;
b_est=b0;
iters=0;
gradToler = 1e-7;
% step2: 迭代
for it=1:n_iters
    iters = iters+1;
    if updateJ==1
        % 根据当前估计值，计算雅克比矩阵
        X = [a_est,b_est];
        g = FirstDerivatives( myfun, X );
        fnorm = norm(g);
        if fnorm < gradToler
            break;
        end
        J = SecondDerivatives( myfun, X );
        % 根据当前参数，得到函数值误差
        d = feval( myfun, X);
        % 计算（拟）海塞矩阵
        H=J'*J;
        % 若是第一次迭代，计算误差
        if it==1
            e=dot(d,d);
        end
    end
    H_lm=H+(lamda*eye(Nparams,Nparams));
    % 计算步长dp，并根据步长计算新的可能的参数估计值
    dp=inv(H_lm)*(J'*d(:));
    a_lm=a_est+dp(1);
    b_lm=b_est+dp(2);
    % 计算新的可能估计值对应的y 和计算残差e
    d_lm = feval( myfun, [a_lm,b_lm]);
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
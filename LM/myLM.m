function [a_est,b_est,iters] = myLM( a0,b0,Nparams,n_iters,myfun )
% �������:
% ��ʼ�²�ֵ   a0=10; b0=0.5;
% ����ά��     Nparams
% ���������� n_iters

% LM �㷨������ϵ����ֵ
lamda=0.01;
% step1: ������ֵ
updateJ=1;
a_est=a0;
b_est=b0;
iters=0;
gradToler = 1e-7;
% step2: ����
for it=1:n_iters
    iters = iters+1;
    if updateJ==1
        % ���ݵ�ǰ����ֵ�������ſ˱Ⱦ���
        X = [a_est,b_est];
        g = FirstDerivatives( myfun, X );
        fnorm = norm(g);
        if fnorm < gradToler
            break;
        end
        J = SecondDerivatives( myfun, X );
        % ���ݵ�ǰ�������õ�����ֵ���
        d = feval( myfun, X);
        % ���㣨�⣩��������
        H=J'*J;
        % ���ǵ�һ�ε������������
        if it==1
            e=dot(d,d);
        end
    end
    H_lm=H+(lamda*eye(Nparams,Nparams));
    % ���㲽��dp�������ݲ��������µĿ��ܵĲ�������ֵ
    dp=inv(H_lm)*(J'*d(:));
    a_lm=a_est+dp(1);
    b_lm=b_est+dp(2);
    % �����µĿ��ܹ���ֵ��Ӧ��y �ͼ���в�e
    d_lm = feval( myfun, [a_lm,b_lm]);
    e_lm=dot(d_lm,d_lm);
    % ������������θ��²���������ϵ��
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
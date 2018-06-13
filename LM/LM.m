function [a_est,b_est] = LM( data_1,obs_1,a0,b0,Nparams,n_iters )
% �������:
% data_1=[0.25 0.5 1 1.5 2 3 4 6 8];
% obs_1=[19.21 18.15 15.36 14.10 12.89 9.32 7.45 5.24 3.01];
% ��ʼ�²�ֵ   a0=10; b0=0.5;
% ����ά��     Nparams
% ���������� n_iters

% ���ݸ���
Ndata=length(data_1);
% LM �㷨������ϵ����ֵ
lamda=0.01;
% step1: ������ֵ
updateJ=1;
a_est=a0;
b_est=b0;
% step2: ����
for it=1:n_iters
    if updateJ==1
        % ���ݵ�ǰ����ֵ�������ſ˱Ⱦ���
        J=zeros(Ndata,Nparams);
        for i=1:length(data_1)
            J(i,:)=[exp(-b_est*data_1(i)) -a_est*data_1(i)*exp(-b_est*data_1(i))];
        end
        % ���ݵ�ǰ�������õ�����ֵ
        y_est = a_est*exp(-b_est*data_1);
        % �������
        d=obs_1-y_est;
        % ���㣨�⣩��������
        H=J'*J;
        % ���ǵ�һ�ε������������
        if it==1
            e=dot(d,d);
        end
    end
    % ��������ϵ��lamda ��ϵõ�H ����
    H_lm=H+(lamda*eye(Nparams,Nparams));
    % ���㲽��dp�������ݲ��������µĿ��ܵĲ�������ֵ
    dp=inv(H_lm)*(J'*d(:));
    g = J'*d(:);
    a_lm=a_est+dp(1);
    b_lm=b_est+dp(2);
    % �����µĿ��ܹ���ֵ��Ӧ��y �ͼ���в�e
    y_est_lm = a_lm*exp(-b_lm*data_1);
    d_lm=obs_1-y_est_lm;
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

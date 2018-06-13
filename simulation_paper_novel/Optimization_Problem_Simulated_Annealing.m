%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ���MATLAB����ʵ����ģ���˻�Simulated Annealing������⺯���Ż�����
%��Optimization Problem��
% ����ģ��Ϊ Min F(x,y��=(1-x)^2+100(y-x^2)^2
% �Ѿ�֪�����Ż������ȫ����СֵΪ0���ڵ㣨1,1����ȡ��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;
clear;
%%��ʼ��ֵ
T0=0.1;%0.1
T_min=1e-5;
r=0.98;     %�˻�����
tl=10;     %��ÿ���¶��µ�����������

Bound=[5.0004	6.1116;0.072	0.088; 0.5418	0.6622;-0.01161	-0.01419; 6.2334	7.6186;0.0198	0.0242]


for i=1:1			 %�����������±߽�
    lowerbound=Bound(:,1);
    upperbound=Bound(:,2);
end
lowerbound;
upperbound;
	%��ʼ�������ӳ�ʼλ�ã�����Ч��Χ�����ѡ��	
    population=rand*(Bound(:,2)-Bound(:,1)) + Bound(:,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%population(1,:)=round(population(1,;)*1000)/1000;
%population(2,;)=round(population(2,;)*1000)/1000;

epl33s  =  population(1) *1e-9;
tan_ct_e  =  population(2);
k_t  =  population(3);
tan_ct_k  =  population(4);
c33_D  =  population(5)*1e+10;
tan_ct_c  =  population(6);

% epl33s  =  3*1e-9;
% tan_ct_e  =  -0.5;
% k_t  =  0.5;
% tan_ct_k  = 0.5;
% c33_D  =  5*1e+10;
% tan_ct_c  =  0.9;

%Var0=rand(1,6)*(-6)+[1 3]; %��ʼ������ֵ�����������[-3,3]��ȡֵ
Z0= fun_epoxy_sum_diff(epl33s, tan_ct_e, k_t,tan_ct_k,c33_D, tan_ct_c );
Var_best=population;
Z_best=Z0;
T=T0;
Time=ceil(double(solve(['0.1*(0.98)^x=',num2str(T_min)])));
obj=zeros(Time,1);
i=0;
while T>T_min
    i=i+1;
%     if i>500
%     T=T*r;
%     end
    r=(T-T_min)/(T_min*T*tl);
    T=T/(1+T*r);
    M=zeros(6,tl);
    N=zeros(1,tl);
    for k=1:tl
        Var_new=get_newanswer(Var_best);
        Z_new=fun_epoxy_sum_diff(Var_new(1)*1e-9,Var_new(2),Var_new(3),Var_new(4),Var_new(5)*1e+10,Var_new(6));
        d=Z_new-Z_best;
        if d<0
           Z_best=Z_new;
           Var_best=Var_new;
        else
            if exp(-d/T)>rand
                Z_best=Z_new;
                Var_best=Var_new; 
            end
        end
         M(:,k)=Var_best;
         N(k)=Z_best;
    end
    [d0(i),n]=min(N);      %�ҳ���ǰ�¶������Ž�
    if i==1||d0(i)<obj(i-1)             
       obj(i)=d0(i);          %�����ǰ�¶������Ž�С����һ�¶ȣ����¼��ǰ��
    else
       obj(i)=obj(i-1);    %�����ǰ�¶������Ž������һ�¶ȣ����¼��һ�¶Ƚ�
    end 
    Var_best=M(:,n);
    Best(i)=Z_best;
%     plot(obj,'ro-');
    plot(d0,'ro-');
    xlabel('��������');
    ylabel('���Ž�');
    title('�Ż�����');
    text(0.5,0.95,['Best = ', num2str(Best(i))],'Units','normalized');
    drawnow;
end
obj(i)
Var_best
Z_best
% figure
% plot(1:i,obj);
% drawnow;
% xlabel('��������');
% ylabel('���Ž�');
% title('�Ż�����');



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






            
        



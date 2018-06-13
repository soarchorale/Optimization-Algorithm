clear all
clc

initial_temperature=1000;
threshold=1000;
Bound=[0  10; 0  0.1;    0.1  1;  -0.1  0.1;  2  10; 0 0.1]

Ndim = length(Bound)		%空间维数

for i=1:1			 %定义粒子上下边界
    lowerbound(:,i)=Bound(:,1);
    upperbound(:,i)=Bound(:,2);
end
lowerbound;
upperbound;
	%初始化各粒子初始位置，在有效范围内随机选数	
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

[sum_diff_Z]=  fun_epoxy_sum_diff(epl33s,tan_ct_e, k_t,tan_ct_k,c33_D, tan_ct_c );
fvalue(i) =sum_diff_Z;
simulatedannealing(population,1000,threshold);
population

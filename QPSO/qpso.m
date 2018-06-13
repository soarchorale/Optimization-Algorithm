
popsize=20;    %种群规模
MAXITER=2000;   %最大迭代次数
dimension=30;   %维数
irange_l=-5.12;  
irange_r=5.12;
xmax=10;        %x的变化范围

sum1=0;
sum2=0;
mean=0;
st=0;
runno=10;
data1=zeros(runno,MAXITER);   %10*2000型矩阵
for run=1:runno
T=cputime;         %程序开始时间
x=(irange_r- irange_l)*rand(popsize,dimension,1) + irange_l;   %初始化种群，将x的范围映射到[-5.12,5.12]空间内


pbest=x;     %个体极值
gbest=zeros(1,dimension);    %全局极值



for i=1:popsize                      
    f_x(i)=f3(x(i,:));           %更新个体极值，f3是什么函数
    f_pbest(i)=f_x(i);
end
   
   
    g=min(find(f_pbest==min(f_pbest(1:popsize))));   %更新全局极值
    gbest=pbest(g,:);
   
    f_gbest=f_pbest(g);


MINIUM=f_pbest(g);                       
for t=1:MAXITER
  
    beta=(1-0.5)*(MAXITER-t)/MAXITER+0.5;                 %学习系数
    mbest=sum(pbest)/popsize;

       
 for i=1:popsize  
        fi=rand(1,dimension);
        p=fi.*pbest(i,:)+(1-fi).*gbest;
        u=rand(1,dimension);
        b=beta*(mbest-x(i,:));
        v=-log(u);
        y=p+((-1).^ceil(0.5+rand(1,dimension))).*b.*v;
        x(i,:)=y;
        x(i,:)=sign(y).*min(abs(y),xmax); 
          
            f_x(i)=f3(x(i,:));
            if f_x(i)<f_pbest(i)
                pbest(i,:)=x(i,:);
                f_pbest(i)=f_x(i);
            end
            if f_pbest(i)<f_gbest
                gbest=pbest(i,:);
                f_gbest=f_pbest(i);
            end            
            MINIUM=f_gbest;                    
 end
    data1(run,t)=MINIUM;
    if MINIUM>1e-007
        mean=t;
    end
  end
sum1=sum1+mean;  
sum2=sum2+MINIUM;
 %MINIUM
time=cputime-T;
st=st+time;

end
av1=sum1/10;  %输出平均收验代数
av2=sum2/10;  %输出平均最优解
st/10  %就是最后anw输出的解
        
 
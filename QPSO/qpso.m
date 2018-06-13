
popsize=20;    %��Ⱥ��ģ
MAXITER=2000;   %����������
dimension=30;   %ά��
irange_l=-5.12;  
irange_r=5.12;
xmax=10;        %x�ı仯��Χ

sum1=0;
sum2=0;
mean=0;
st=0;
runno=10;
data1=zeros(runno,MAXITER);   %10*2000�;���
for run=1:runno
T=cputime;         %����ʼʱ��
x=(irange_r- irange_l)*rand(popsize,dimension,1) + irange_l;   %��ʼ����Ⱥ����x�ķ�Χӳ�䵽[-5.12,5.12]�ռ���


pbest=x;     %���弫ֵ
gbest=zeros(1,dimension);    %ȫ�ּ�ֵ



for i=1:popsize                      
    f_x(i)=f3(x(i,:));           %���¸��弫ֵ��f3��ʲô����
    f_pbest(i)=f_x(i);
end
   
   
    g=min(find(f_pbest==min(f_pbest(1:popsize))));   %����ȫ�ּ�ֵ
    gbest=pbest(g,:);
   
    f_gbest=f_pbest(g);


MINIUM=f_pbest(g);                       
for t=1:MAXITER
  
    beta=(1-0.5)*(MAXITER-t)/MAXITER+0.5;                 %ѧϰϵ��
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
av1=sum1/10;  %���ƽ���������
av2=sum2/10;  %���ƽ�����Ž�
st/10  %�������anw����Ľ�
        
 
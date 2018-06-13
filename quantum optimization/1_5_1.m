%-------------程序正文-------------
clear all;
close all;
%-------------定义全局变量-------------
global outu output timef
%-------------定义局部变量-------------
Size=50;CodeL=17;G=50;Pm=0.05;
%-------------以下是参数范围的设置-------------
%摇杆角度和角速度参数范围
MinX(1)=0.05;MaxX(1)=1.00;
MinX(2)=0.05;MaxX(2)=3.00;
MinX(3)=0.05;MaxX(3)=1.00;
MinX(4)=0.05;MaxX(4)=3.00;
%小车位移和小车速度参数范围
MinX(5)=0.05;MaxX(5)=1.00;
MinX(6)=0.05;MaxX(6)=3.00;
MinX(7)=0.05;MaxX(7)=1.00;
MinX(8)=0.05;MaxX(8)=3.00;
%控制器输出参数范围
MinX(9)=0.5;MaxX(9)=1.0;
MinX(10)=0.1;MaxX(10)=0.5;
MinX(11)=0.1;MaxX(11)=0.5;
MinX(12)=-0.1;MaxX(12)=0.1;
MinX(13)=0.1;MaxX(13)=0.5;
MinX(14)=-0.1;MaxX(14)=0.1;
MinX(15)=-0.1;MaxX(15)=0.1;
MinX(16)=-0.5;MaxX(16)=-0.1;
%控制器输出因子
MinX(17)=1.0;MaxX(17)=3.0;
%-------------染色体初始化-------------
t0=2*pi*rand(Size,CodeL);
chrom(1,:,:)=cos(t0);
chrom(2,:,:)=sin(t0);
oldt0=2*pi*rand(Size,CodeL);
oldchrom(1,:,:)=cos(oldt0);
oldchrom(2,:,:)=sin(oldt0);
%-------------解空间变换-------------
for i=1:1:CodeL
    oldvars(:,:,i)=0.5*(MaxX(i)*(1+oldchrom(:,:,i)+MinX(i)*(1-oldchrom(:,:,i)));
end
%-------------计算评价值-------------
for Si=1:1:Size
    oldBestJ(1,Si)=fnncontrollerf(oldvars(1,Si,:));
    oldBestJ(2,Si)=fnncontrollerf(oldvars(2,Si,:));
end
%-------------主循环开始-------------
for kg=1:1:G
    iteration(kg)=kg;
    %-------------解空间变换-------------
    for i=1:1:CodeL
        vars(:,:,i)=0.5*(MaxX(i)*(1+chrom(:,:,i)+MinX(i)*(1-chrom(:,:,i)));
    end
    %-------------计算评价值-------------
    for Si=1:1:Size
    BestJ(1,Si)=fnncontrollerf(vars(1,Si,:));
    BestJ(2,Si)=fnncontrollerf(vars(2,Si,:));
    end
    %-------------染色体评估-------------
    [OderBestJ,IndexBestJ]=sort(BestJ,2);
    [OderBestJJ,IndexBestJJ]=sort(OderBestJ); 
    BestC=IndexBestJJ(1,1);
    BestP=InddexBestJ(BestC,1);
    BestS=chrom(:,BestP,:);
    BestJJ(kg)=OderBestJJ(1,1);
    Fit(kg)=1000./OderBestJJ(1,1);
    %-------------计算最大最小梯度-------------
    for i=1:1:CodeL
        tmp=abs(vars(BestC,1,i)-oldvars(BestC,1,i));
        if tmp<0.00001
            tmp=0.00001;
        end
        max(i)=abs(BestJ(BestC,1)-oldBestJ(BestC,1))/tmp;
        min(i)=abs(BestJ(BestC,1)-oldBestJ(BestC,1))/tmp;
        for k=1:1:Size
            tmp=abs(vars(BestC,k,i)-oldvars(BestC,k,i));
            if tmp<0.00001
            tmp=0.00001;
            end
            if max(i)<abs(BestJ(BestC,k)-oldBestJ(BestC,k))/tmp;
                max(i)=abs(BestJ(BestC,k)-oldBestJ(BestC,k))/tmp;
            end
            if min(i)>abs(BestJ(BestC,k)-oldBestJ(BestC,k))/tmp;
                min(i)=abs(BestJ(BestC,k)-oldBestJ(BestC,k))/tmp;
            end
        end
    end
    %-------------计算个体梯度-------------
    for i=1:1:Size
        for j=1:1:CodeL
            tmp=abs(vars(BestC,i,j)-oldvars(BestC,i,j));
            if tmp<0.00001
            tmp=0.00001;
            end 
            grad=abs(BestJ(BestC,i)-oldBestJ(BestC,i))/tmp;
            rate(i,j)=exp(-abs(grad-min(j))/abs(max(j)-min(j)));
        end
    end
    %-------------旋转操作-------------
    for i=1:1:Size
        for j=1:1:CodeL
            t0(i,j)=t0(i,j)+sign(chrom(1,i,j)*BestS(2,j)-BestS(1,j)*chrom(2,i,j))*rate(i,j)*0.05*pi*exp(-kg/(4*G));
        end
    end
    %-------------变异操作-------------
    for i=1:1:Size
        for j=1:1:CodeL
            Pm_rand=rand;
            if (Pm>Pm_rand)&(i=BestP)
                t0(i,j)=0.5*pi-t0(i,j);
            end
        end
    end
    %-------------代间复制-------------
    oldvars=vars;
    oldBEstJ=BestJ;
    %-------------生成新的量子染色体-------------
    chrom(1,:,:)=cos(t0(:,:));
    chrom(2,:,:)=sin(t0(:,:));
    BestResult=BestJJ(kg);
    play(1)=kg;
    play(2)=BestResult;
    play
    BestVar(1,:)=vars(BestC,BestP,:)
end
%-------------最优解变换-------------
BsJ=fnncontrollerf(BestVar(1,:));
%-------------存储优化结果-------------
save parameter timef output outu iteration BestJJ Fit BestVar BestResult
%-------------显示优化结果-------------
figure(1);
plot(timef,output(:,1)),grid on;
xlabel('time(s)',ylabel('pendulun angle');
figure(2);
plot(timef,output(:,2)),grid on;
xlabel('time(s)',ylabel('pendulun dangle');
figure(3);
plot(timef,output(:,3)),grid on;
xlabel('time(s)',ylabel('car position');
figure(4);
plot(timef,output(:,4)),grid on;
xlabel('time(s)',ylabel('car dposition');
figure(5);
plot(timef,outu),grid on;
xlabel('time(s)',ylabel('controller output');
figure(6);
plot(timef,BestJJ),grid on;
xlabel('Iterations',ylabel('Best BJ');
figure(7);
plot(timef,Fit),grid on;
xlabel('Iterations',ylabel('Best Fit');



































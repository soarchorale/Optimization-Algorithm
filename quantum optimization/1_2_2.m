%---------------------程序正文
clear all;
close all;
Size=50;
ColeL=2;
MinX(1)=-2;
MaxX(1)=2;
MinX(2)=-2;
MaxX(2)=2;
%初始化开始
fai(:,1)=2*pi*rand(Size,1);
sita(:,1)=pi*rand(Size,1);
fai(:,2)=2*pi*rand(Size,1);
sita(:,2)=pi*rand(Size,1);
p(:,1,1)=cos(fai(:,1)).*sin(sita(:,1));
p(:,1,2)=sin(fai(:,1)).*sin(sita(:,1));
p(:,1,3)=cos(fai(:,1));
p(:,2,1)=cos(fai(:,2)).*sin(sita(:,2));
p(:,2,2)=sin(fai(:,2)).*sin(sita(:,2));
p(:,2,3)=cos(sita(:,2));
Pm=ones(1,Size)*0.05;
G=100;
BsJ=0;
%解空间变换开始
x(:,1,:)=0.5*(MaxX(1)*(1+p(:,1,:))+MinX(1)*(1-p(:,1,:)));
x(:,2,:)=0.5*(MaxX(2)*(1+p(:,1,:))+MinX(2)*(1-p(:,2,:)));
%计算函数值开始
for i=1:1:Size
   x11=x(i,1,1);x12=x(i,2,1);
   x21=x(i,1,2);x12=x(i,2,2);
   x31=x(i,1,3);x12=x(i,2,3);
   F(i,1)=[1+(x11+x12+1)^2*(19-14*x11+3*x11^2-14*x12+6*x11*x12+3*x12^2)]*[30+(2*x11-3*x12)^2*(18-32*x11+12*x11^2+48*x12-36*x11*x12+27*x12^2)];
   F(i,2)=[1+(x21+x22+1)^2*(19-14*x21+3*x21^2-14*x12+6*x21*x22+3*x22^2)]*[30+(2*x21-3*x22)^2*(18-32*x21+12*x21^2+48*x22-36*x21*x22+27*x22^2)];
   F(i,3)=[1+(x31+x32+1)^2*(19-14*x31+3*x31^2-14*x32+6*x31*x32+3*x32^2)]*[30+(2*x31-3*x32)^2*(18-32*x31+12*x31^2+48*x32-36*x31*x12+27*x32^2)];
end
%开始获得最小值及相应自变量
[Bestf,Indexf]=sort(F,2);
[BestF,IndexF]=sort(Bestf,1);
Bestfi=BestF(1,1);
Bestp=IndexF(1,1);
Bests=Indexf(Bestp,1);
Bestx=x(Bestp,:,Bests);
BestC=p(Bestp,:,:);
%主循环开始
for kg=1:1:G
    time(kg)=kg;
    %开始更新量子相位
    for i=1:1:Size
        for j=1:1:CodeL
            if p(i,j,1)*BestC(1,j,2)>BestC(1,j,1)*p(i,j,2)
                fai(i,j)=fai(i,j)+0,05*pi;
            end
            if p(i,j,1)*BestC(1,j,2)<BestC(1,j,1)*p(i,j,2)
                fai(i,j)=fai(i,j)-0,05*pi;
            end
            if BestC(1,j,3)>p(i,j,3)
                sita(i,j)=sita(i,j)-0.05*pi;
            end
            if BestC(1,j,3)<p(i,j,3)
                sita(i,j)=sita(i,j)+0.05*pi;
            end
        end
    end
    %结束更新量子相位
    %开始变异量子相位
    Pm-rand=rand(Size,CodeL);
    for i=1:1:Size
        for j=1:1:CodeL
            if Pm(i)>Pm-rand(i,j)&(i=Bestp)
                fai(i,j)=0.5*pi-fai(i,j);
                sita(i,j)=0.5*pi-sita(i,j);
            end
        end
    end
    %结束变异量子相位
    %生成染色体开始
    p(:,1,1)=cos(fai(:,1)).*sin(sita(:,1));
    p(:,1,2)=sin(fai(:,1)).*sin(sita(:,1));
    p(:,1,3)=cos(sita(:,1));
    p(:,2,1)=cos(fai(:,2)).*sin(sita(:,2));
    p(:,2,2)=sin(fai(:,2)).*sin(sita(:,2));
    p(:,2,3)=cos(sita(:,2));
    % 生成燃烧热体结束
    % 计算函数值开始
    for i=1:1:Size
    x11=x(i,1,1);x12=x(i,2,1);
    x21=x(i,1,2);x12=x(i,2,2);
    x31=x(i,1,3);x12=x(i,2,3);
    F(i,1)=[1+(x11+x12+1)^2*(19-14*x11+3*x11^2-14*x12+6*x11*x12+3*x12^2)]*[30+(2*x11-3*x12)^2*(18-32*x11+12*x11^2+48*x12-36*x11*x12+27*x12^2)];
    F(i,2)=[1+(x21+x22+1)^2*(19-14*x21+3*x21^2-14*x12+6*x21*x22+3*x22^2)]*[30+(2*x21-3*x22)^2*(18-32*x21+12*x21^2+48*x22-36*x21*x22+27*x22^2)];
    F(i,3)=[1+(x31+x32+1)^2*(19-14*x31+3*x31^2-14*x32+6*x31*x32+3*x32^2)]*[30+(2*x31-3*x32)^2*(18-32*x31+12*x31^2+48*x32-36*x31*x12+27*x32^2)];
    end
    %计算函数值结束
    %开始获得最小值及相应自变量
    [Bestf,Indexf]=sort(F,2);
    [BestF,IndexF]=sort(Bestf,1);
    Bestfi=BestF(1,1);
    Bestp=IndexF(1,1);
    Bests=Indexf(Bestp,1);
    Bestx=x(Bestp,:,Bests);
    BestC=p(Bestp,:,:);
    %结束获得最小值及相应自变量
    %记录最小值及评价值
    Bfi(kg)=Bestfi;
    BestJ(kg)=1+3-Bestfi;
    %显示当前代数及优化结果
    kg
    Bestx
end
%显示最小值
Bestfi
%画图
figure(1);
plot(time,BestJ,'k');
xlabel('Times');ylabel('BestJ');
figure(2);
plot(time,Bfi,'k');
xlabel('time');ylabel('BestF');
    
    
    
    
    
    
    
    
    
    
    
    
            

   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
%-------------程序正文-------------
clear all;
close all;
%-------------变量部分-------------
mode=1;
sample=202;
IN=3;
net=4;
C=net^2;
speed0=1.0;
radius0=1;
kesi0=2.00;
class=2;
eachclass=[101,101];
maxgen1=100;
maxgen2=100;
%-------------样本初始化-------------
load samdata
for i=1:1:sample
    xi(i,1)=samdata(i,1);
    xi(i,2)=samdata(i,2);
    xi(i,3)=sign(samdata(i,1)*samdata(i,2))*(abs(samdata(i,1)*samdata(i,2)))^0.05;
end
for j=1:1:IN
    tmp=0;
    for i=1:1:sample
        if tmp<abs(xi(i,j))
            tmp=abs(xi(i,j));
        end
    end
    if tmp>0
        for i=1:1:sample
            xi(i,j)=xi(i,j)/tmp;
        end
    end
end
%-------------样本量子化-------------
qxi(:,1,:)=cos(pi.*(1./(1+exp(-xi))));
qxi(:,2,:)=sin(pi.*(1./(1+exp(-xi))));
%-------------如果为训练模式-------------
if mode==0
    qwa=pi*rand(C,IN);
    qw(:,1,:)=cos(qwa);
    qw(:,2,:)=sin(qwa);
%-------------计算竞争节点网络坐标-------------
%这个循环将竞争节点映射到net*net方阵，其中：
%第1个节点坐标（1,1），第net个（net,1),
%第（net-1)*net+1个（1，net),第net*net个（net,net)
for i=1:1:C
    for j=1:1:net
        if i<j*net
            break;
        end
    end
    coordiate(i,1)=i-(j-1)*net;
    coordiate(i,2)=j;
end
%-------------第一主循环开始-------------
for gen1=1:1:maxgen1
    speed=speed0;
    %speed=speed0*exp(-gen1/maxgen1);
    radius=ceil(radius0*(1-gen1/maxgen1));
    for i=1:1:sample
        for j=1:1:C
            tmp=0;
            for k=1:1:IN
                a1=qw(j,1,k);b1=qw(j,2,k);a2=qxi(i,1,k);b2=qxi(i,2,k);
                tmp=tmp+(a1*a2+b1*b2)/((a1^2+b1^2)*(a2^2+b2^2))^0.5;
            end
            y(i,j)=tmp;
        end
        [tmp,index]=sort(y(i,:),2);
        win(i)=index(C);
        winy(i)=tmp(C);
    end
    %-------------调整量子权值相位-------------
    for i=1:1:sample
        winno=win(i);
        t1=coordiate(winno,1)-radius;t2=coordiate(winno,1)+radius;
        t3=coordiate(winno,2)-radius;t4=coordiate(winno,2)+radius;
        if t1<1
            t1=1;
        end
        if t2>net
            t2=net;
        end
        if t3<1
            t3=1;
        end
        if t4>net
            t4=net;
        end
        for j=t1:1:t2
            for k=t3:1:t4
                updateno=(k-1)*net+j;
                for m=1:1:IN
                    a1=qxi(i,1,m);b1=qxi(i,2,m);
                    a2=qw(updateno,1,m);b2=qw(updateno,2,m);
                    A=a1*b2-b1*a2;
                    B=(a1*a2+b1*b2)/((a1^2+b1^2)*(a2^2+b2^2))^0.5;
                    dangle=-speed*sign(A)*acos(abs(B));
                    qwa(updateno,m)= qwa(updateno,m)+dangle;
                    if qwa(updateno,m)>pi
                       qwa(updateno,m)=2*pi-qwa(updateno,m);
                    end
                    if qwa(updateno,m)<0
                    qwa(updateno,m)=-qwa(updateno,m);
                    end
                    qw(updateno,1,m)=cos(qwa(updateno,m));
                    qw(updateno,2,m)=sin(qwa(updateno,m));
                end
            end
        end
    end
    gen1
end
%-------------计算各类样本的理论中心平均样本-------------
for i=1:1:class
    tmp1=0;
    for j=1:1:i-1
        tmp1=tmp1+eachclass(j);
    end
    for j=1:1:IN
        tmp2=0;
        for k=1:1:eachclass(i)
            tmp2=tmp2+xi(tmp1+k,j)/eachclass(i);
        end
        center(i,j)=tmp2;
    end
end
%-------------计算各类样本的实际中心样本编号-------------
for i=1:1:class
    tmp1=0;
    for j=1:1:i-1
        tmp1=tmp1+eachclass(j);
    end
    for j=1:1:eachclass(i)
        tmp2=0;tmp3=0;
        for k=1:1:IN
            tmp2=tmp2+xi(tmp1+j,k)^2;
            tmp3=tmp3+center(i,k)^2;
        end
        tmp4(j)=xi(tmp1+j,:)*center(i,:)'/(tmp2*tmp3)^0.5;
    end
    [tmp5,index]=sort(tmp4,2);
    centersam(i)=tmp1+index(eachclass(i));
end
%-------------第二主循环开始-------------
for gen2=1:1:maxgen2
    %speed=speed0*exp(-gen2/maxgen2);
    kesi=kesi0;
    %kesi=kesi0*exp(-gen2/maxgen2);
    for i=1:1:class
        winno(i)=win(centersam(i));
        tmp1=0;
        for i=1:1:i-1
            tmp1=tmp1+eachclass(j);
        end
        for j=1:1:eachclass(i)
            for k=1:1:IN
                a1=qxi(tmp1+j,1,k);b1=qxi(tmp1+j,2,k);
                a2=qw(winno(i),1,k);b2=qw(winno(i),2,k);
                A=a1*b2-b1*a2;
                B=(a1*a2+b1*b2)/((a1^2+b1^2)*(a2^2+b2^2))^0.5;
                dangle=-speed*sign(A)*acos(abs(B));
                qwa(winno(i),k)= qwa(winno(i),k)+dangle;
                if qwa(winno(i),k)>pi
                   qwa(winno(i),k)=2*pi-qwa(winno(i),k);
                end
                if qwa(winno(i),k)<0
                   qwa(winno(i),k)=-qwa(winno(i),k);
                end
                qw(winno(i),1,k)=cos(qwa(winno(i),k));
                qw(winno(i),2,k)=sin(qwa(winno(i),k));
            end
            if (win(tmp1+j)~=winno(i))&(abs(winy(tmp1+j)-winy(centersam(i)))<kesi)%不等于符号输入?????
                for k=1:1:IN
                a1=qxi(tmp1+j,1,k);b1=qxi(tmp1+j,2,k);
                a2=qw(win(tmp1+j),1,k);b2=qw(win(tmp1+j),2,k);
                A=a1*b2-b1*a2;
                B=(a1*a2+b1*b2)/((a1^2+b1^2)*(a2^2+b2^2))^0.5;
                dangle=-speed*sign(A)*acos(abs(B));
                qwa(win(tmp1+j),k)= qwa(win(tmp1+j),k)+dangle;
                if qwa(win(tmp1+j),k)>pi
                qwa(win(tmp1+j),k)=2*pi-qwa(win(tmp1+j),k);
                end
                if qwa(win(tmp1+j),k)<0
                qwa(win(tmp1+j),k)=-qwa(win(tmp1+j),k);
                end
                qw(win(tmp1+j),1,k)=cos(qwa(win(tmp1+j),k));
                qw(win(tmp1+j),2,k)=sin(qwa(win(tmp1+j),k));  
                end
            end
        end
    end
    for i=1:1:sample
        for j=1:1:C
            tmp=0;
            for k=1:1:IN
                a1=qw(j,1,k);b1=qw(j,2,k);a2=qxi(i,1,k);b2=qxi(i,2,k);
                tmp=tmp+(a1*a2+b1*b2)/((a1^2+b1^2)*(a2^2+b2^2))^0.5;
            end
            y(i,j)=tmp;
        end
        [tmp,index]=sort(y(i,:),2);
        win(i)=index(C);
        winy(i)=tmp(C);
    end
    gen2
end
%-------------第二主循环结束-------------
    for i=1:1:101
    first(i)=win(i);
    X1(i)=i;
    end
    for j=1:1:101
        second(i)=win(i+101);
        X2(i)=i;
    end
    save qwa qwa
    save result X1 first X2 second
end
%-------------如果为测试模式-------------
if mode==1
    load bestqwa
    qw(:,1,:)=cos(qwa);
    qw(:,2,:)=sin(qwa);
    for i=1:1:sample
        for j=1:1:C
            for k=1:1:IN
                a1=qw(j,1,k);b1=qw(j,2,k);a2=qxi(i,1,k);b2=qxi(i,2,k);
                tmp=tmp+(a1*a2+b1*b2)/((a1^2+b1^2)*(a2^2+b2^2))^0.5;
            end
            y(i,j)=tmp;
        end
        [tmp,index]=sort(y(i,:),2);
        win(i)=index(C);
        winy(i)=tmp(C);
    end
    for i=1:1:101
        first(i)=win(i);
        X1(i)=i;
    end
    for j=1:1:101
        second(i)=win(i+101);
        X2(i)=i;
    end
end
%-------------显示结果-------------
figure(1)
plot(X1,first,'*',X2,second,'o')
grid on
first 
second
for i=1:1:101
    x1(i)=samdata(i,1);
    y1(i)=samdata(i,2);
    x2(i)=samdata(i+101,1);
    y2(i)=samdata(i+101,2);
end
figure(2)
plot(x1,y1,'*',x2,y2,'o')
grid on
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
    
 























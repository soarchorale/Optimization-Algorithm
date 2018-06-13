clear all;
close all;
x=0.001:0.001:1;
N=1000;
%标准Grove算法迭代步数
r0=round(acos(sqrt(x))./(2.*asin(sqrt(x))));%????
% 标准Grove算法成功概率
P0=（sin((2.*r0+1).*asin(sqrt(x)))).^2;
MINO=1;MINNO=1;
for i=1:1:N
    if PO(i)<MINO
        MINO=PO(i);MINNO=i;
    end 
end
g1=0.1*pi;
b1=asin(sin(g1/2).*sqrt(x));
a=sqrt(1-x);
b=cos(g1/2).*sqrt(x)+cos(b1);
nt=a.^2+b.^2;
% 固定相位(0.1)Grove算法迭代步数
r1=fix(pi./(4*asin(sin(g1/2).*sqrt(x))));
s1=4.*a.^4.*b.^2.*(sin(2.*r1.*b1)).^2;
s2=(a.^4+b.^4).*x;
s3=-4.*a.^2.*b.^3.*sqrt(x).*sin(2.*r1.*b1).*cos(2.*r1.*b1+g1/2+pi/2);
s4=-4.*a.^4.*b.sqrt(x).*sin(2.*r1.*b1).*cos(2.*r1.*b1-g1/2-pi/2);
s5=2.*x.*a.^2.*b.^2.*cos(4.*r1.*b1);
% 固定相位(0.1)Grove算法成功概率
P1=(s1+s2+s3+s4+s5)./(nt.^2);
MIN1=1;MINN1=1;
for i=1:1:N
    if P1(i)<MIN1
        MIN1=P1(i);MINN1=i;
    end
end

g2=1.825*pi;
a1=acos(x*(1-cos(g2))-1);
% 固定相位(1.825)Grove算法迭代步数
r2=fix(g2./(2.*sqrt(x)));
q1=sin((r2+1).*a1)./sin(a1);
q2=sin(r2.*a1)./sin(a1);
% 固定相位(1.825)Grove算法成功概率
P2=1-(1-x).*(q1+q2).^2;
MIN2=1;MINN2=1;
for i=1:1:N
    if P2(i)<MIN2
        MIN2=P2(i);MINN2=i;
    end
end
a3=1-x;
% 局部扩散Grove算法成功概率
P3=(1-a3).*(((sin(r3+1).*acos(a3))).^2)./(sin(acos(a3))).^2+((sin(r3.*acos(a3))).^2)./(sin(acos(a3))).^2);
MIN3=1;MINN3=1;
for i=1:1:N
    if P3(i)<MIN3
        MIN3=PI(3);MINN3=i;
    end
end
MIN0 % 标准算法最小概率
x(MIN0) %标准算法最小概率时x
r0(MINN0)%标准算法最小概率时迭代步数
MIN1 %固定相位(0.1)算法最小概率
x(MINN1)% 固定相位(0.1)算法最小概率时x
r1(MINN1)% 固定相位(0.1)算法最小概率时迭代步数
MIN2 %固定相位(1.825)算法最小概率
x(MINN2)% 固定相位(1.825)算法最小概率时x
r1(MINN2)% 固定相位(1.825)算法最小概率时迭代步数
MIN3 %局部扩散算法最小概率
x(MINN3) %局部扩散算法最小概率时x
r3(MINN3) %局部扩散算法最小概率时迭代步数
figure(1)
plot(x,P0,x,P1,x,P2,x,P3)
figure(2)
plot(x,r0,x,r1,x,r2,x,r3)














































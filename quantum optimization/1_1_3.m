clear all;
close all;
x=0.001:0.001:1;
g1=pi;
b1=asin(sin(g1/2).*sqrt(x));
a=sqrt£¨1-x);
b=cos(g1/2).*sqrt(x)+cos(b1);
nt=a.^2+b.^2;
r1=fix(pi./(4*asin(sin(g1/2).*sqrt(x))));
s1=4.*a.^4.*b.^2.*(sin(2.*r1.*b1)).^2;
s2=(a.^4+b.^4).*x;
s3=-4.*a.^2.*b.*sqrt(x).*sin(2.*r1.*b1).*cos(2.*r1.*b1+g1/2+pi/2);
s4=-4.*a.^4.*b.*sqrt(x).*sin(2.*r1.*b1).*cos(2.*r1.*b1-g1/2-pi/2);
s5=2.*x.*a.^2.*b.^2.*cos(4.*r1.*b1);
P1=(s1+s2+s3+s4+s5)./(nt.^2);

g1=0.5*pi;
b1=asin(sin(g1/2).*sqrt(x));
a=sqrt(1-x);
b=cos(g1/2).*sqrt(x)+cos(b1);
nt=a.^2+b.^2;
r1=fix(pi./(4*asin(sin(g1/2).*sqrt(x))));
s1=4.*a.^4.*b.^2.*(sin(2.*r1.*b1)).^2;
s2=(a.^4+b.^4).*x;
s3=-4.*a.^2.*b.*sqrt(x).*sin(2.*r1.*b1).*cos(2.*r1.*b1+g1/2+pi/2);
s4=-4.*a.^4.*b.*sqrt(x).*sin(2.*r1.*b1).*cos(2.*r1.*b1-g1/2-pi/2);
s5=2.*x.*a.^2.*b.^2.*cos(4.*r1.*b1);
P2=(s1+s2+s3+s4+s5)./(nt.^2);

g1=1.825*pi;
b1=asin(sin(g1/2).*sqrt(x));
a=sqrt(1-x);
b=cos(g1/2).*sqrt(x)+cos(b1);
nt=a.^2+b.^2;
r1=fix(pi./(4*asin(sin(g1/2).*sqrt(x))));
s1=4.*a.^4.*b.^2.*(sin(2.*r1.*b1)).^2;
s2=(a.^4+b.^4).*x;
s3=-4.*a.^2.*b.*sqrt(x).*sin(2.*r1.*b1).*cos(2.*r1.*b1+g1/2+pi/2);
s4=-4.*a.^4.*b.*sqrt(x).*sin(2.*r1.*b1).*cos(2.*r1.*b1-g1/2-pi/2);
s5=2.*x.*a.^2.*b.^2.*cos(4.*r1.*b1);
P3=(s1+s2+s3+s4+s5)./(nt.^2);

g1=0.1*pi;
b1=asin(sin(g1/2).*sqrt(x));
a=sqrt(1-x);
b=cos(g1/2).*sqrt(x)+cos(b1);
nt=a.^2+b.^2;
r1=fix(pi./(4*asin(sin(g1/2).*sqrt(x))));
s1=4.*a.^4.*b.^2.*(sin(2.*r1.*b1)).^2;
s2=(a.^4+b.^4).*x;
s3=-4.*a.^2.*b.*sqrt(x).*sin(2.*r1.*b1).*cos(2.*r1.*b1+g1/2+pi/2);
s4=-4.*a.^4.*b.*sqrt(x).*sin(2.*r1.*b1).*cos(2.*r1.*b1-g1/2-pi/2);
s5=2.*x.*a.^2.*b.^2.*cos(4.*r1.*b1);
P4=(s1+s2+s3+s4+s5)./(nt.^2);
plot(x,P4,x,P3,x,P2,x,P1)
















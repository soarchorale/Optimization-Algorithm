%-------------程序正文-------------
function BsJ=fnncontrollerf(vars)
global outu output timef
%-------------倒立摆物理参数-------------
M=1.096;
m=0.109;
l=0.28;
J=0.0034;
g=9.81;
F=0.1;
f=0.002;
%-------------其他仿真参数-------------
Y0=[pi/6;0;;0.5;0];
N=500;
output=zeros(N,4);
u=0;
outu=zeros(N,1);
ts=0.006;
t0=0;
tf=ts;
Q=[1 0 0 0;0 0 0 0;0 0 10 0;0 0 0 0];
R=0.001;
BsJ=0;
%-------------建立基于ODE45函数的动态控制过程-------------
for k=1:1:N
    timef(k)=k*ts;
    tspan=[t0,tf];
    [t,Y]=ode45('invertf3',tspan,Y0,[],M,m,l J,g,F,f,u);
    t0=t(end);
    tf=t0+ts;
    tspan=[t0,tf];
    Y0=Y(end,:);
    output(k,:)=Y0;
    e1=Y0(1);
    ec1=Y0(2);
    e2=Y0(3);
    ec2=Y0(4);
    if (abs(e1)>2*pi)|(abs(e2)>10)
        BsJ=1000000+rand;
        break;
    end
    gx1=member(e1,vars(1),vars(2),-vars(1),vars(2));
    gx2=member(ec1,vars(3),vars(4),-vars(3),vars(4));
    gx3=member(e2,vars(5),vars(5),-vars(5),vars(6));
    gx4=member(ec2,vars(7),vars(8),-vars(7),vars(8));
    ggx1(1)=gx1(1)/(gx1(1)+gx1(2));
    ggx1(2)=gx1(2)/(gx1(1)+gx1(2));
    ggx2(1)=gx2(1)/(gx2(1)+gx2(2));
    ggx2(2)=gx2(2)/(gx2(1)+gx2(2));
    ggx3(1)=gx3(1)/(gx3(1)+gx3(2));
    ggx3(2)=gx3(2)/(gx3(1)+gx3(2));
    ggx4(1)=gx4(1)/(gx4(1)+gx4(2));
    ggx4(2)=gx4(2)/(gx4(1)+gx4(2));
    for m1=1:1:2
        for m2=1:1:2
            for m3=1:1:2
                for m4=1:1:2
                    rule(8*(m1-1)+4*(m2-1)+2*(m3-1)+m4)=ggx1(m1)*ggx2(m2)*ggx3(m3)*ggx4(m4);
                end
            end
        end
    end
    tmp=0;
    for i=1:1:8
        tmp=tmp+rule(i)*(vars(i+8));
    end
    for i=1:1:8
        tmp=tmp+rule(i+8)*(-vars(17-i));
    end
    u=400*vars(17)*tmp;
    outu(k)=u;
    BsJ=BsJ+Y0*Q*Y0'+outu(k)*R*outu(k)';
end

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
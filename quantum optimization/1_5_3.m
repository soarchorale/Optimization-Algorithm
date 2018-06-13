function DyDt=invertf3(t,x,flag,M,m,l,J,g,F,f,u)
switch flag
    case ''
        dydt(1)=x(2);
            a=-(m*1*x(2))^2*cos(x(1))*sin(x(1));
            b=-m*1*cos(x(1))*u;
            c=F*x(4)*m*1*cos(x(1));
            d=(M+m)*m*g*l*sin(x(1));
            e=-(M+m)*f*x(2);
            p=(M+m)*(J+m*l^2);
            q=-(m*l*cos(x(1)))^2;
        dydt(2)=(a+b+c+d+e)/(p+q);
        dydt(3)=x(4);
            a=m*1*cos(x(1))*fz8x(2);
            b=-(m*1)^2*g*sin(x(1))*cos(x(2));
            c=-(J+m*l^2)*F*x(4);
            d=-(J+m*l^2)*m*l*x(2)^2*sin(x(1));
            e=-(J+m*l^2)*u;
            p=(M+m)*(J+m*l^2);
            q=-(m*l*cos(x(1)))^2;
        dydt(4)=(a+b+c+d+e)/(p+q);
        DyDt=dydt';
    otherwise
        error(['Unknown flag'''flag '''.']);
end
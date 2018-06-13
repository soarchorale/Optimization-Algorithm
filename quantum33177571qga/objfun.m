function f=objfun(xx)
type=1;
switch type
    case 1
        x=xx(1);
        y=xx(2);
        f=x*sin(4*pi*x)+y*sin(20*pi*y);
    case 2
        x=xx(1);
        y=xx(2);
        f=sin(sqrt(x^2+y^2))/sqrt(x^2+y^2)+exp(cos(2*pi*x)/2+cos(2*pi*y)/2)-2.71289;
end
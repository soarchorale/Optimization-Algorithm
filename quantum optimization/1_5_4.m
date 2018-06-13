function quanzhong=member(a,b,c,f,g)
if a>b
    quanzhong(1)=1;
else
    quanzhong(1)=exp(-(a-b)^2/c^2);
end
if a<f
    quanzhong(2)=1;
else 
    quanzhong(2)=exp(-(a-f)^2/g^2);
end
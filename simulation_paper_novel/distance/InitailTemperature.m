function IT = InitailTemperature(inputcities,k)
%INITAILTEMPRATURE Summary of this function goes here
%   确定初始温度
    n=length(inputcities);
    D=zeros(n,n);
    maxcity=0;
    mincity=0;
    for i=1:n
       for j=1:n
         D(i,j) = norm(inputcities(:,i) - inputcities(:,j));   %矩阵D(i,j)表示第i个城市和第j个城市的距离
       end
    end
   maxcitys=max(D);%取其中最远的距离
   for i=1:n
      maxcity=maxcity + maxcitys(i);   %将距离第i个城市最远的距离相加
   end
   mincitys=min(D);%取其中最近的距离
   for i=1:n
      mincity=mincity + mincitys(i);   %将距离第i个城市最近的距离相加
   end
   T1=maxcity-mincity;
   IT=k*T1;
end


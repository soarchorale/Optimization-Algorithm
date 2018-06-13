function IT = InitailTemperature(inputcities,k)
%INITAILTEMPRATURE Summary of this function goes here
%   ȷ����ʼ�¶�
    n=length(inputcities);
    D=zeros(n,n);
    maxcity=0;
    mincity=0;
    for i=1:n
       for j=1:n
         D(i,j) = norm(inputcities(:,i) - inputcities(:,j));   %����D(i,j)��ʾ��i�����к͵�j�����еľ���
       end
    end
   maxcitys=max(D);%ȡ������Զ�ľ���
   for i=1:n
      maxcity=maxcity + maxcitys(i);   %�������i��������Զ�ľ������
   end
   mincitys=min(D);%ȡ��������ľ���
   for i=1:n
      mincity=mincity + mincitys(i);   %�������i����������ľ������
   end
   T1=maxcity-mincity;
   IT=k*T1;
end


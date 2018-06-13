% ��������Ⱥ�㷨�������  ���Ӽ����������Ż��㷨  ��ʿ�� �����������
% -----------------��������------------------------------
clear all;
close all;
clc;
% -----------------��������--------------------------
popsize = 50;    %��Ⱥ��ģ
vartotal = 2;    %��������
inertia = 0.5;   %��������
selfw = 2.0;     %��������
globalw = 2.0;   %ȫ������
mutatep = 0.05;  %�������
maxgen = 5000;    %�޶�����
%-----------------���鲿��-----------------------------

varrange(1,1) = -512;   %��һ������Сֵ
varrange(1,2) = 512;    %��һ�������ֵ
varrange(2,1) = -512;   %�ڶ�������Сֵ
varrange(2,2) = 512;    %�ڶ��������ֵ

%----------------����λ�ó�ʼ��----------------------------
for i = 1:1:popsize
    for j = 1:1:vartotal
        angle(i,j) = 2*pi*rand;
        chrom(i,1,j) = cos(angle(i,j));  %��i�����ӣ�����Ⱦɫ�壩�ķ�������
        chrom(i,2,j) = sin(angle(i,j));  %��i�����ӣ�����Ⱦɫ�壩�ķ�������
        selfangle(i,j) = 2*pi*rand;      
        selfchrom(i,1,j) = cos(angle(i,j));  %��i��������������λ�õķ�������
        selfchrom(i,2,j) = sin(angle(i,j));  %��i��������������λ�õķ�������
        dangle(i,j) = 0;                     %��ʼ��ת���������ٶȣ�
    end
end
%-------------------��ռ�任---------------------------------------
for i = 1:1:popsize
    for j = 1:1:2
        for k = 1:1:vartotal
            chromx(i,j,k) = 0.5*(varrange(k,2)*(1+chrom(i,j,k))+ ...
              varrange(k,1)*(1-chrom(i,j,k)));
            selfchromx(i,j,k) = 0.5*(varrange(k,2)*(1+selfchrom(i,j,k)) ...
              +varrange(k,1)*(1-selfchrom(i,j,k)));
        end
    end
end
%-------------------������Ӧ��-------------------------------------------
for i = 1:1:popsize
    for j = 1:1:2
        fitness(i,j) = -chromx(i,j,1) ...
            *sin((abs(chromx(i,j,2)+1-chromx(i,j,1)))^0.5) ...
            *cos((abs(chromx(i,j,2)+1+chromx(i,j,1)))^0.5) ...
            -(chromx(i,j,2)+1) ...
            *cos((abs(chromx(i,j,2)+1-chromx(i,j,1)))^0.5) ...
            *sin((abs(chromx(i,j,2)+1+chromx(i,j,1)))^0.5);
        selffitness(i,j) = -selfchromx(i,j,1) ...
            *sin((abs(selfchromx(i,j,2)+1-selfchromx(i,j,1)))^0.5) ...
            *cos((abs(selfchromx(i,j,2)+1+selfchromx(i,j,1)))^0.5) ...
            -(selfchromx(i,j,2)+1) ...
            *cos((abs(selfchromx(i,j,2)+1-selfchromx(i,j,1)))^0.5) ...
            *sin((abs(selfchromx(i,j,2)+1+selfchromx(i,j,1)))^0.5);
    end
end

%------------------------��Ӧ��ͳ��----------------------------------
minfit = fitness(1,1);
if fitness(1,1)>fitness(1,2)
    minfit = fitness(1,2);
end
maxfit = fitness(1,2);
bestchain = 2;
if fitness(1,1)>fitness(1,2)
    maxfit = fitness(1,1);
    bestchain = 1;
end
minfitindex = 1;
maxfitindex = 1;
avgfit = (fitness(1,1)+fitness(1,2))/(2*popsize);
for i = 2:1:popsize
    for j = 1:1:2
        if minfit > fitness(i,j)
            minfit = fitness(i,j);
            minfitindex = i;
        end
        if maxfit < fitness(i,j)
            maxfit = fitness(i,j);
            maxfitindex = i;
            bestchain = j;
        end
        avgfit = avgfit + fitness(i,j)/(2*popsize);
    end
end
%------------------��ʼ��ȫ�����Ž�---------------------
gloangle(1,:) = angle(maxfitindex,:);       %���ȫ��������λ
glochrom(1,:,:) = chrom(maxfitindex,:,:);   %��ʼ��ȫ������λ��
glochromx(1,:,:) = chromx(maxfitindex,:,:); %��ʼ��ȫ������λ��
glofit = fitness(maxfitindex,bestchain);    %���ȫ�������Ӧ��
%------------------������ѭ����ʼ---------------------------
for gen = 1:1:maxgen
%--------------����λ���ƶ�--------------
    for i = 1:1:popsize
        for j = 1:1:vartotal
            t1 = selfangle(i,j) - angle(i,j);
            if t1 < -pi
                t1 = t1 + 2*pi;
            end
            if t1 > pi
                t1 = t1-2*pi;
            end
            t2 = gloangle(1,j) - angle(i,j);
            if t2 < -pi
                t2 = t2+2*pi;
            end
            if t2 > pi
                t2 = t2-2*pi;
            end
            dangle(i,j)=inertia*dangle(i,j)+selfw*rand*t1+globalw*rand*t2;
            angle(i,j) = angle(i,j)+dangle(i,j); %�ƶ������λ
            chrom(i,1,j) = cos(angle(i,j));      %�ƶ����λ��
            chrom(i,2,j) = sin(angle(i,j));      %�ƶ����λ��
            %-------��ռ�任--------------
            chromx(i,1,j) = 0.5*(varrange(j,2)*(1+chrom(i,1,j)) ...
                +varrange(j,1)*(1-chrom(i,1,j)));
            chromx(i,2,j) = 0.5*(varrange(j,2)*(1+chrom(i,2,j)) ...
                +varrange(j,1)*(1-chrom(i,2,j)));
        end
            for j = 1:1:2    %������Ӧ��
                fitness(i,j) = -chromx(i,j,1) ...
                    *sin((abs(chromx(i,j,2)+1-chromx(i,j,1)))^0.5) ...
                    *cos((abs(chromx(i,j,2)+1+chromx(i,j,1)))^0.5) ...
                    -(chromx(i,j,2)+1) ...
                    *cos((abs(chromx(i,j,2)+1-chromx(i,j,1)))^0.5) ...
                    *sin((abs(chromx(i,j,2)+1+chromx(i,j,1)))^0.5);
            end
    end
    %---------------------����λ�ñ���--------------------------
    for i = 1:1:popsize
        for j = 1:1:vartotal
            if rand < mutatep
                angle(i,j) = pi/2 - angle(i,j);  %��������λ
                chrom(i,1,j) = cos(angle(i,j));  %������λ��
                chrom(i,2,j) = sin(angle(i,j));  %������λ��
                %------------��ռ�任----------------
                chromx(i,1,j) = 0.5*(varrange(j,2)*(1+chrom(i,1,j)) ...
                    +varrange(j,1)*(1-chrom(i,1,j)));
                chromx(i,2,j) = 0.5*(varrange(j,2)*(1+chrom(i,2,j)) ...
                    +varrange(j,1)*(1-chrom(i,2,j)));
            end
        end
        for j = 1:1:2                 %������Ӧ��
            fitness(i,j) = -chromx(i,j,1) ...
                    *sin((abs(chromx(i,j,2)+1-chromx(i,j,1)))^0.5) ...
                    *cos((abs(chromx(i,j,2)+1+chromx(i,j,1)))^0.5) ...
                    -(chromx(i,j,2)+1) ...
                    *cos((abs(chromx(i,j,2)+1-chromx(i,j,1)))^0.5) ...
                    *sin((abs(chromx(i,j,2)+1+chromx(i,j,1)))^0.5);
        end
    end
    %------------��Ӧ��ͳ��--------------------------
    minfit = fitness(1,1);
    if fitness(1,1)>fitness(1,2)
        minfit = fitness(1,2);
    end
    maxfit = fitness(1,2);
    bestchain = 2;
    if fitness(1,1)>fitness(1,2)
        maxfit = fitness(1,1);
        bestchain = 1;
    end
    minfitindex = 1;
    maxfitindex = 1;
    avgfit = (fitness(1,1)+fitness(1,2))/(2*popsize);
    for i =2:1:popsize
        for j = 1:1:2
            if minfit>fitness(i,j)
                minfit = fitness(i,j);
                minfitindex = i;
            end
            if maxfit < fitness(i,j)
                maxfit = fitness(i,j);
                maxfitindex = i;
                bestchain = j;
            end
            avgfit = avgfit + fitness(i,j)/(2*popsize);
        end
    end
    %-----------------������������λ��------------------------
    for i = 1:1:popsize
        t1 = fitness(i,1);
        if t1<fitness(i,2)
            t1 = fitness(i,2);
        end
        t2 = selffitness(i,1);
        if t2<selffitness(i,2)
            t2 = selffitness(i,2);
        end
        if t1>t2
            selfangle(i,:) = angle(i,:);
            selfchrom(i,:,:) = chrom(i,:,:);
            selfchromx(i,:,:) = chromx(i,:,:);
            selffitness(i,:) = fitness(i,:);
        end
    end
    %-----------------����ȫ������λ��-----------------------
    if glofit < fitness(maxfitindex,bestchain)
        gloangle(1,:) = angle(maxfitindex,:);
        glochrom(1,:,:) = chrom(maxfitindex,:,:);
        glochromx(i,:,:) = chromx(maxfitindex,:,:);
        glofit = fitness(maxfitindex,bestchain);
    end
    %------------------��¼���----------------------
    iteration(gen) = gen
    result(gen) = glofit
    if result(gen)>511
        break;
    end     %511.707 7
end
%------------------������ѭ������---------------------------
bestresult = glofit;
iterationstep = gen;
bestresult
iterationstep
figure(1)
plot(iteration,result)
            
            
                
        
        











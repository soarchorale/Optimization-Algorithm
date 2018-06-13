%-------------------------��������
clear all;
close all;
%-------------------------��������
popsize=100;
vartotal=2;
shiftstep=0.001*pi;
Pm=ones(1,popsize)*0.05;
maxgen=500;
%-------------------------���鲿��
varrange(1,1)=-100;
varrange(1,2)=100;
varrange(2,1)=-100;
varrange(2,2)=100;
%-------------------------Ⱦɫ���ʼ��
for i=1:1:vartotal
    fai(:,i)=2*pi*rand(popsize,1);
    chorm(:,1,i)=cos(fai(:,i));
    chorm(:,2,i)=sin(fai(:,i));
    oldfai(:,i)=2*pi*rand(popsize,1);
    oldchorm(:,1,i)=cos(oldfai(:,i));
    oldchorm(:.2,i)=sin(oldfai(:,i));
end
%-------------------------��ռ�任
for i=1:1:2
    for j=1:1:vartotal
        chromx(:,i,j)=0.5*(varrange(j��2��*��1+chorm(:,i,j)+varrange(j,1)*(1-chorm(:,i,j)));
         oldchromx(:,i,j)=0.5*(varrange(j��2��*��1+oldchorm(:,i,j)+varrange(j,1)*(1-oldchorm(:,i,j)));
    end
end
%-------------------------������Ӧ��
for i=1:1��popsize
    for j=1:1:2
        x1=chromx(i,j,1);x2=chrom(i,j,2);
        fitness(i,j)=0.5-((sin(sqrt(x1^2+x2^2)))^2-0.5)/(1+0.001*(x1^2+x2^2)(^2;
        x2=oldchromx(i,j,1);x2=oldchrom(i,j,2);
        oldfitness(i,j)=0.5-((sin(sqrt(x1^2+x2^2)))^2-0.5)/(1+0.001*(x1^2+x2^2)(^2;
    end
end
%-------------------------������Ž⼰��Ӧ�Ա���
[Bestf,Indexf]=sort(fitness,2);
[BestF,IndexF]=sort(Bestf,1);
gBestfi=BestF(popsize,2);
gBestp=IndexF(popsize,2);
gBestg=Indexf(gBestp,:);
gBestfai=fai(gBestp,:);
gBestC=Chrom(gBestp,:,:);
gBestx=Chromx(gBestp,:,:);
gBestfit=fitness(gBestp,:);
%-------------------------���������С�ݶ�
for i=1:1:vartotal
    tmp=abs(chromx(1,gBestg,i)-oldchromx(1,gBestg,i));
    if tmp<1.0e-2
        tmp=1.0e-2
    end
    max(i)=abs(fitness(1,gBestg)-oldfitness(1,gBestg))/tmp;
    min(i)=abs(fitness(1,gBestg)-oldfitness(1,gBestg))/tmp;
    for j=1:1:popsize
     if tmp<1.0e-2
        tmp=1.0e-2
     end
    if min(i)>abs(fitness(j,gBestg)-oldfitness(j,gBestg))/tmp
       min(i)>abs(fitness(j,gBestg)-oldfitness(j,gBestg))/tmp;
    end
    end
end
%-------------------------ִ������λ��λ��ת
for i=1:1:popsize
    for i=1:1:vartotal
        tmp=abs(chromx(i,gBestg,j)-oldchromx(i,gBestg,j));
        if tmp<1.0e-2
        tmp=1.0e-2
        end
    grad=abs(fitness(j,gBestg)-oldfitness(j,gBestg))/tmp;
    tmp=abs(grad-min(j));
     if tmp<1.0e-2
        tmp=1.0e-2;
     end
     rate(i,j)=abs(max(j)-min(j))/tmp;
     fai(i,j)=fai(i,j)+sign(chrom(i,1,j)*gBestC(1,2,j)-gBestC(1,1,j)*chrom(i,2,j))*rate(i,j)*shiftstep*exp(-gen/maxgen);
    end
end
%-------------------------ִ������λ��λ����
Pm-rand=rand(popsize,vartotal);
for i=1:1:popsize
    for j=1:1:vartotal
        if (Pm(i)>Pm-rand(i,j))&(i=gBestp)
            fai(i,j)-0.5*pi-fai(i,j);
        end
    end
end
%-------------------------���临��
oldchrom=chrom;
oldchromx=chromx;
oldfitness=fitness;
%-------------------------��ռ�任
for i=1:1:2
    for j=1:1:vartotal
        chromx(:,i,j)=0.5*(varrange(j,2)*(1+chrom(:,i,j)+varrange(j,1)*(1-chrom(:,i,j)));
    end
end
%-------------------------������Ӧ��
for i=1:1:popsize
    for j=1:1:2
        x1=chromx(i,j,1);x2=chromx(i,j,2);
        fitness(i,j)=0.5-((sin(sqrt(x1^2+x2^2)))^2-0.5)/(1+0.001*��x1^2+x2^2))^2;
    end
end
%-------------------------������Ž⼰��Ӧ�Ա���
[Bestf,Indexf]=sort(fitness,2);
[BestF,IndexF]=sort(Bestf,1);
Bestfi=BestF(popsize,2);
Bestp=IndexF(popsize,2);
Bestg=Indexf(Bestp,2);
Bestfai=fai(Bestp,:);
BestC=Chrom(Bestp,:,:);
Bestx=Chromx(Bestp,:,:);
Bestfit=fitness(Bestp,:);
Badp=IndexF(1,1);    
%-------------------------�����Ž��˻���ȡ���ϴ����Ž�
if Bestfi<gBestfi
    bestfi=gBestfi;
    fai(Badp,:)=gBestfai(1,:);
    chrom(Badp,:,:)=gBestC(1,:,:);
    chromx(Badp,:,:)=gBestx(1,:,:);
    fitness(Badp,:)=gBestfit(1,:);
    gBestp=Badp;
end
%-------------------------�����Ž���������Ž��滻
if Bestfi>gBestfi
    gBestfi=Bestfi;
    gBestp=Bestp;
    gBestg=Bestg;
    gBestfai=Bestfai;
    gBestC=BestC;
    gBestx=Bestx;
    gBestfit=Bestfit;
end
%-------------------------��¼���Ż����
result(gen)=gBestfi
iteration(gen)=gen
gen
if result(gen)>0.995
    break;
end
end
%-------------------------������ѭ������
bestresult=result(gen);
irerationstep=iteration(gen);
bestresult
iterationstep
figure(1)
plot(iteration,result)

       
    






















































clear all
clc

flag=0;		%ֹͣ�����־
oldbestval=0;	%��¼�ɵ���Ӧ��ֵ	
samecounter=0; 	%��¼�õ���ͬ��Ӧ��ֵ�ĵ�������
iteration = 0;	%��������
MaxIter =30  	%����������
PopSize=6   	%��Ⱥ��С
c1 = 0.65       	%ѧϰ����
c2 = 0.65       	%ѧϰ����
w=0.75; 		%��������	

        Bound=[1 10; 0.1 0.2;    20 30; 0.2 0.3;  30 40; 0.3 0.4]	%���ӵ����귶Χ	
% %���ӵ����귶Χ:��1   ��2         ��3     ��4      ��5     ��6
% % ��PopSize=6   	%��Ⱥ��С���ɲ���population 6ά����ÿ��Ϊһ�����������ҹ�6�飬
% population =
% % 
% %     3.5600    5.2230    1.5830    9.8950    6.2450    4.8110
% %     0.1520    0.1330    0.1430    0.1230    0.1580    0.1760
% %    25.2982   26.4053   22.0907   23.7982   27.8333   26.8085
% %     0.2461    0.2568    0.2794    0.2059    0.2603    0.2050
% %    34.1537   33.0500   38.7437   30.1501   37.6795   39.7084
% %     0.3990    0.3789    0.3439    0.3498    0.3214    0.3643
%��Ӧ fvalueΪ�������룬��6����



Ndim = length(Bound)		%�ռ�ά��

for i=1:PopSize			 %�����������±߽�
    lowerbound(:,i)=Bound(:,1);
    upperbound(:,i)=Bound(:,2);
end
lowerbound;
    upperbound;
for i=1:Ndim		%��ʼ�������ӳ�ʼλ�ã�����Ч��Χ�����ѡ��	
    population(i,:)=rand(1, PopSize)*(Bound(i,2)-Bound(i,1)) + Bound(i,1);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
population(1,:)=round(population(1,:)*1000)/1000;
population(2,:)=round(population(2,:)*1000)/1000;

population
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:Ndim		%��ʼ������������ٶȣ�ʹ���Ӳ���Խ���߽�
    vmax(i,:)=(Bound(i,2)-Bound(i,1))/2;
end

 for i=1:Ndim		%��ʼ���������ٶ�
    velocity(i, :) =vmax(i,1)*rand(1, PopSize);
 end
velocity;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fvalue=input('��ʼ��ֵ:������Ansys Ƶ�ʲ�[1,2,...,6],һ��������')
% for i = 1:PopSize		%��������ӵ���Ӧ��ֵ
%         fvalue(i) = population(1,i)^2+population(2,i)^2+population(3,i)^2;    
% end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pbest = population;   		%��¼�����ӵĸ��弫ֵ��λ��
fpbest = fvalue;      		%��¼�����Ӧ��ֵ
[fbestval,index] = min(fvalue);    	% �ҳ�ȫ�ּ�ֵ����Ӧ�����   

while(flag == 0) & (iteration < MaxIter)	%Ѱ������������
    
    iteration = iteration +1;		%������������
%     w=(1+1/(0.5+log(iteration)))/2  %��������
    w
    
    for i=1:PopSize			%����ȫ�ּ�ֵ��λ��
        gbest(:,i) = population(:,index);
    end
     
    R1 = rand(Ndim, PopSize);		%�������������
    R2 = rand(Ndim, PopSize);
%     R3 = rand(Ndim, PopSize);
    
    velocity = w*velocity + c1*R1.*(pbest-population) + c2*R2.*(gbest-population);
    				% ���¸������ٶ�
    population = population + velocity;	% ���¸�����λ��
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
population(1,:)=round(population(1,:)*1000)/1000;
population(2,:)=round(population(2,:)*1000)/1000;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    OutFlag = population<=lowerbound | population>=upperbound; 	% �ݳ���־
    population = population - OutFlag.*velocity;		% ��ֹ�ݳ�
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
%     for i = 1:PopSize			% ���¸�������Ӧ��ֵ
%           fvalue(i) = population(1,i)^2+population(2,i)^2+population(3,i)^2;
%     end
    population
   fvalue=input('��ʼ��ֵ:������Ansys Ƶ�ʲ�[1,2,...,6],һ��������')
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    changeColumns = fvalue <fpbest;	% ���º����Ӧ��ֵ���ڸ���ǰ�ģ���¼���
    pbest(:, find(changeColumns)) = population(:, find(changeColumns));    % ���¸��弫ֵ��λ��
    fpbest = fpbest.*( ~changeColumns) + fvalue.*changeColumns            %���¸��弫ֵ
    [fbestval, index] = min(fvalue); 	%����ȫ�ּ�ֵ����Ӧ�����
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   trace(iteration,1)=min(fvalue)
   trace(iteration,2)=sum(fvalue)/length(fvalue)
   population(:,index)
   size(trace)
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if floor(fbestval*1e30)==oldbestval	 %�Ƚϸ���ǰ�͸��º�ķŴ����Ӧ��ֵ;
    samecounter=samecounter+1;		 %���ʱ��¼��һ;
    else
        oldbestval=floor(fbestval*1e30);	%�����ʱ���·Ŵ����Ӧ��ֵ������¼����;
        samecounter=0;
    end 

    if samecounter >= 20		%��ε�������Ӧ��ֵ���ʱ����ֹͣ
        flag=1;
    end

     Best(iteration) =fbestval;		% ���������ҵ���ȫ�ּ�ֵ
	
     plot(Best,'ro-');xlabel('generation'); ylabel('f(x)');
     text(0.5,0.95,['Best = ', num2str(Best(iteration))],'Units','normalized');   
     drawnow; 

end		

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(3)
plot(trace(:,1),'b*-')
ylabel('minimum')
figure(2)
plot(trace(:,2),'r*-')
ylabel('average')
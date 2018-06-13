clear all
clc

flag=0;		%停止程序标志
oldbestval=0;	%记录旧的适应度值	
samecounter=0; 	%记录得到相同适应度值的迭代次数
iteration = 0;	%迭代次数
MaxIter =30  	%最大迭代次数
PopSize=6   	%种群大小
c1 = 0.65       	%学习因子
c2 = 0.65       	%学习因子
w=0.75; 		%惯性因子	

        Bound=[1 10; 0.1 0.2;    20 30; 0.2 0.3;  30 40; 0.3 0.4]	%粒子的坐标范围	
% %粒子的坐标范围:数1   数2         数3     数4      数5     数6
% % 当PopSize=6   	%种群大小，可产生population 6维数，每列为一组数，从左到右共6组，
% population =
% % 
% %     3.5600    5.2230    1.5830    9.8950    6.2450    4.8110
% %     0.1520    0.1330    0.1430    0.1230    0.1580    0.1760
% %    25.2982   26.4053   22.0907   23.7982   27.8333   26.8085
% %     0.2461    0.2568    0.2794    0.2059    0.2603    0.2050
% %    34.1537   33.0500   38.7437   30.1501   37.6795   39.7084
% %     0.3990    0.3789    0.3439    0.3498    0.3214    0.3643
%对应 fvalue为按行输入，共6个数



Ndim = length(Bound)		%空间维数

for i=1:PopSize			 %定义粒子上下边界
    lowerbound(:,i)=Bound(:,1);
    upperbound(:,i)=Bound(:,2);
end
lowerbound;
    upperbound;
for i=1:Ndim		%初始化各粒子初始位置，在有效范围内随机选数	
    population(i,:)=rand(1, PopSize)*(Bound(i,2)-Bound(i,1)) + Bound(i,1);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
population(1,:)=round(population(1,:)*1000)/1000;
population(2,:)=round(population(2,:)*1000)/1000;

population
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:Ndim		%初始化各粒子最大速度，使粒子不能越出边界
    vmax(i,:)=(Bound(i,2)-Bound(i,1))/2;
end

 for i=1:Ndim		%初始化各粒子速度
    velocity(i, :) =vmax(i,1)*rand(1, PopSize);
 end
velocity;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fvalue=input('初始附值:请输入Ansys 频率差[1,2,...,6],一行内输入')
% for i = 1:PopSize		%计算各粒子的适应度值
%         fvalue(i) = population(1,i)^2+population(2,i)^2+population(3,i)^2;    
% end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pbest = population;   		%记录各粒子的个体极值点位置
fpbest = fvalue;      		%记录最佳适应度值
[fbestval,index] = min(fvalue);    	% 找出全局极值和相应的序号   

while(flag == 0) & (iteration < MaxIter)	%寻找最优主程序
    
    iteration = iteration +1;		%迭代次数递增
%     w=(1+1/(0.5+log(iteration)))/2  %惯性因子
    w
    
    for i=1:PopSize			%更新全局极值点位置
        gbest(:,i) = population(:,index);
    end
     
    R1 = rand(Ndim, PopSize);		%重新设置随机性
    R2 = rand(Ndim, PopSize);
%     R3 = rand(Ndim, PopSize);
    
    velocity = w*velocity + c1*R1.*(pbest-population) + c2*R2.*(gbest-population);
    				% 更新各粒子速度
    population = population + velocity;	% 更新各粒子位置
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
population(1,:)=round(population(1,:)*1000)/1000;
population(2,:)=round(population(2,:)*1000)/1000;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    OutFlag = population<=lowerbound | population>=upperbound; 	% 逸出标志
    population = population - OutFlag.*velocity;		% 阻止逸出
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
%     for i = 1:PopSize			% 更新各粒子适应度值
%           fvalue(i) = population(1,i)^2+population(2,i)^2+population(3,i)^2;
%     end
    population
   fvalue=input('初始附值:请输入Ansys 频率差[1,2,...,6],一行内输入')
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    changeColumns = fvalue <fpbest;	% 更新后的适应度值优于更新前的，记录序号
    pbest(:, find(changeColumns)) = population(:, find(changeColumns));    % 更新个体极值点位置
    fpbest = fpbest.*( ~changeColumns) + fvalue.*changeColumns            %更新个体极值
    [fbestval, index] = min(fvalue); 	%更新全局极值和相应的序号
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   trace(iteration,1)=min(fvalue)
   trace(iteration,2)=sum(fvalue)/length(fvalue)
   population(:,index)
   size(trace)
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if floor(fbestval*1e30)==oldbestval	 %比较更新前和更新后的放大的适应度值;
    samecounter=samecounter+1;		 %相等时记录加一;
    else
        oldbestval=floor(fbestval*1e30);	%不相等时更新放大的适应度值，并记录清零;
        samecounter=0;
    end 

    if samecounter >= 20		%多次迭代的适应度值相近时程序停止
        flag=1;
    end

     Best(iteration) =fbestval;		% 输出及描出找到的全局极值
	
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
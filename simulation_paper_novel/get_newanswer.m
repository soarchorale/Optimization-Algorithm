function Var_new=get_newanswer(Var_best)
Var_new=Var_best+(2*rand(6,1)-[1;1;1;1;1;1]);%以0.1为精度随机搜索邻域
Bound=[5.0004	6.1116;0.072	0.088; 0.5418	0.6622;-0.01161	-0.01419; 6.2334	7.6186;0.0198	0.0242];
			 
lowerbound=Bound(:,1);%定义粒子上下边界
upperbound=Bound(:,2);
outupper=Var_new>=upperbound;
outlower=Var_new<=lowerbound;
while max(outupper)||max(outlower) % 逸出标志
    if max(outupper)==1
    Var_new=Var_new-outupper.*(0.1*rand(6,1));
    outupper=Var_new>=upperbound;
    else
        if max(outlower)==1
    Var_new=Var_new+outlower.*(0.1*rand(6,1));
    outlower=Var_new<=lowerbound;
end
    end
end
end
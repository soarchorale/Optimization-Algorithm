function QGA_Fitness
global QGA

t=QGA.igen;
% 计算每个个体的适应度值
for j=1:QGA.popsize;
    x=QGA.xval{t,j};
    QGA.fval(t,j)=QGA.fun(x);
end

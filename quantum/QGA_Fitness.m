function QGA_Fitness
global QGA

t=QGA.igen;
% ����ÿ���������Ӧ��ֵ
for j=1:QGA.popsize;
    x=QGA.xval{t,j};
    QGA.fval(t,j)=QGA.fun(x);
end

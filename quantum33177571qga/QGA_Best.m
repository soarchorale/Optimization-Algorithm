function QGA_Best
global QGA
% 找出最优个体
t=QGA.igen;
[fmax,idx]=max(QGA.fval(t,:));
if t==1 || fmax>QGA.best.fval
    QGA.best.fval=fmax;
    QGA.best.xval=QGA.xval{t,idx};    
    QGA.best.bin=QGA.bin{t,idx};
    QGA.trace(t,:)=[t,idx,fmax,QGA.xval{t,idx}];
else
    QGA.trace(t,:)=QGA.trace(t-1,:);
end

disp(['最优个体：',num2str(QGA.trace(t,2)),' / ',num2str(QGA.trace(t,1))])
disp(['适应度值f：',num2str(QGA.trace(t,3))])
disp(['变量取值x：',num2str(QGA.trace(t,4:end))])

QGA_PlotBestFitness;
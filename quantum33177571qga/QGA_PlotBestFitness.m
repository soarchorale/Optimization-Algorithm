function QGA_PlotBestFitness
global QGA

h=findobj('type','axes','tag','QGA_PlotBestFitness');
if isempty(h)
    axes('nextplot','replacechildren','tag','QGA_PlotBestFitness');
    grid on
    xlabel('当前迭代次数')
    ylabel('最优适应度值')
else
    axes(h);
end

t=1:QGA.igen;
f=QGA.trace(t,3);

plot(t,f,'-*');
title(['迭代次数：',num2str(t(end)),'/',num2str(QGA.maxgen),...
    '，最优适应度：',num2str(f(end))]);
drawnow;
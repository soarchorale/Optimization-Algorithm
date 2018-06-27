function QGA_PlotBestFitness
global QGA

h=findobj('type','axes','tag','QGA_PlotBestFitness');
if isempty(h)
    axes('nextplot','replacechildren','tag','QGA_PlotBestFitness');
    grid on
    xlabel('��ǰ��������')
    ylabel('������Ӧ��ֵ')
else
    axes(h);
end

t=1:QGA.igen;
f=QGA.trace(t,3);

plot(t,f,'-*');
title(['����������',num2str(t(end)),'/',num2str(QGA.maxgen),...
    '��������Ӧ�ȣ�',num2str(f(end))]);
drawnow;
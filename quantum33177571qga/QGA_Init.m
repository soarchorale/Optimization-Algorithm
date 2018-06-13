function QGA_Init
global QGA

maxgen=QGA.maxgen;
popsize=QGA.popsize;
nvars=QGA.nvars;

% ��ʼ��ĳЩ�ֶ�
tmp=cell(maxgen,popsize);
QGA.code=tmp;
QGA.bin=tmp;
QGA.dec=tmp;
QGA.xval=tmp;

best.fval=[];
best.bin=[];
best.xval=[];
QGA.best=best;

QGA.trace=zeros(maxgen,3+nvars);

% ��ĳЩ�ֶν����Զ����
QGA_Repmat;

t=QGA.igen; % ��ǰ����
p=1/sqrt(2); % ��ʼ����

for j=1:popsize
    for k=1:nvars
        QGA.code{t,j}{k,1}=ones(2,QGA.codesize(k))*p;
    end
end
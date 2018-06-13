function QGA_Init
global QGA

maxgen=QGA.maxgen;
popsize=QGA.popsize;
nvars=QGA.nvars;

% 初始化某些字段
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

% 对某些字段进行自动填充
QGA_Repmat;

t=QGA.igen; % 当前代数
p=1/sqrt(2); % 初始概率

for j=1:popsize
    for k=1:nvars
        QGA.code{t,j}{k,1}=ones(2,QGA.codesize(k))*p;
    end
end
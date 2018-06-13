function [x,dec,bin]=QGA_Dec(code,lb,ub)

global QGA

switch nargin
    case 0
        t=QGA.igen;
        popsize=QGA.popsize;
        nvars=QGA.nvars;
        
        for j=1:popsize % 对个体进行循环
            for k=1:nvars % 对变量进行循环
                code=QGA.code{t,j}{k}; % 当前变量量子编码
                lb=QGA.lb(k);
                ub=QGA.ub(k);
                [QGA.xval{t,j}(k),...
                    QGA.dec{t,j}(k),...
                    QGA.bin{t,j}{k}]=...
                    QGA_Dec_Sigle(code,lb,ub); % 将二进制转换为十进制
            end
        end
        x=[];dec=[];bin=[];
    case 3
        [x,dec,bin]=QGA_Dec_Sigle(code,lb,ub);
    otherwise
        error('参数输入错误！');
end

function [x,dec,bin]=QGA_Dec_Sigle(code,lb,ub)
% 将量子编码转换为二进制编码
n=size(code,2); % 编码长度
bin=zeros(1,n);
for i=1:n
    pick=rand;
    if pick>code(1,i)^2
        bin(i)=1;
    else
        bin(i)=0;
    end
end
% 将二进制编码转换为十进制编码
dec=power(2,(n-1):-1:0)*bin(:);
% 将十进制编码缩放到上下边界之间
x=lb+dec/(2^n-1)*(ub-lb);



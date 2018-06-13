function [x,dec,bin]=QGA_Dec(code,lb,ub)

global QGA

switch nargin
    case 0
        t=QGA.igen;
        popsize=QGA.popsize;
        nvars=QGA.nvars;
        
        for j=1:popsize % �Ը������ѭ��
            for k=1:nvars % �Ա�������ѭ��
                code=QGA.code{t,j}{k}; % ��ǰ�������ӱ���
                lb=QGA.lb(k);
                ub=QGA.ub(k);
                [QGA.xval{t,j}(k),...
                    QGA.dec{t,j}(k),...
                    QGA.bin{t,j}{k}]=...
                    QGA_Dec_Sigle(code,lb,ub); % ��������ת��Ϊʮ����
            end
        end
        x=[];dec=[];bin=[];
    case 3
        [x,dec,bin]=QGA_Dec_Sigle(code,lb,ub);
    otherwise
        error('�����������');
end

function [x,dec,bin]=QGA_Dec_Sigle(code,lb,ub)
% �����ӱ���ת��Ϊ�����Ʊ���
n=size(code,2); % ���볤��
bin=zeros(1,n);
for i=1:n
    pick=rand;
    if pick>code(1,i)^2
        bin(i)=1;
    else
        bin(i)=0;
    end
end
% �������Ʊ���ת��Ϊʮ���Ʊ���
dec=power(2,(n-1):-1:0)*bin(:);
% ��ʮ���Ʊ������ŵ����±߽�֮��
x=lb+dec/(2^n-1)*(ub-lb);



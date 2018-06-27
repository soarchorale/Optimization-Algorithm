function QGA_Gate

global QGA

% ��������
t=QGA.igen;
% ���и�����Ӧ��ֵ
fval=QGA.fval(t,:);
% ���Ÿ�����Ӧ��ֵ
fbest=QGA.best.fval;
% ���Ÿ�������Ʊ���
bbest=QGA.best.bin;

for j=1:QGA.popsize
    % ��j���������Ӧ��ֵ
    jfval=fval(j);
    for k=1:QGA.nvars
        % ��k�����������ӱ���
        code=QGA.code{t,j}{k};
        % ��k�������Ķ����Ʊ���
        bin=QGA.bin{t,j}{k};        
        for i=1:QGA.codesize(k)
            alpha=code(1,i); % ��iλ���ӱ����
            beta=code(2,i); % ��iλ���ӱ����
            ibin=bin(i); % ��iλ�����Ʊ���
            ibbest=bbest{k}(i);
            
            % ��ת����ѡ��
            if (ibin==0&&ibbest==0) || (ibin==1&&ibbest==1)
                delta=0;
                sig=0;
            elseif (ibin==0&&ibbest==1) && (jfval<fbest)
                delta=0.01*pi;
                if alpha*beta>0;
                    sig=1;
                elseif alpha*beta<0;
                    sig=0;
                elseif alpha==0
                    sig=0;
                elseif beta==0
                    sig=sign(randn);
                end
            elseif (ibin==0&&ibbest==1) && (jfval>=fbetst)
                delta=0.01*pi;
                if alpha*beta>0
                    sig=-1;
                elseif alpha*beta<0
                    sig=1;
                elseif alpha==0
                    sig=sign(randn);
                elseif beta==0;
                    sig=0;
                end
            elseif (ibin==1&&ibbest==0) && (jfval<fbest)
                delta=0.01*pi;
                if alpha*beta>0
                    sig=-1;
                elseif alpha*beta<0
                    sig=1;
                elseif alpha==0
                    sig=sign(randn);
                elseif beta==0
                    sig=0;
                end
            elseif (ibin==1&&ibbest==0) && (jfval>=fbest)
                delta=0.01*pi;
                if alpha*beta>0
                    sig=1;
                elseif alpha*beta<0
                    sig=-1;
                elseif alpha==0
                    sig=0;
                elseif beta==0
                    sig=sign(randn);
                end                
            end
            theta=sig*delta;
            T=[cos(theta),-sin(theta);sin(theta),cos(theta)];
            y=T*[alpha;beta];
            QGA.code{t+1,j}{k}(:,i)=y;            
        end
    end
end
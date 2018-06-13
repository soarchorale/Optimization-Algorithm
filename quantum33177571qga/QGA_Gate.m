function QGA_Gate

global QGA

% 迭代次数
t=QGA.igen;
% 所有个体适应度值
fval=QGA.fval(t,:);
% 最优个体适应度值
fbest=QGA.best.fval;
% 最优个体二进制编码
bbest=QGA.best.bin;

for j=1:QGA.popsize
    % 第j个个体的适应度值
    jfval=fval(j);
    for k=1:QGA.nvars
        % 第k个变量的量子编码
        code=QGA.code{t,j}{k};
        % 第k个变量的二进制编码
        bin=QGA.bin{t,j}{k};        
        for i=1:QGA.codesize(k)
            alpha=code(1,i); % 第i位量子编码α
            beta=code(2,i); % 第i位量子编码β
            ibin=bin(i); % 第i位二进制编码
            ibbest=bbest{k}(i);
            
            % 旋转策略选择
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
function QGA_Repmat
global QGA

nvars=QGA.nvars;
QGA.lb=QGA_Repmat_Sub(QGA.lb,nvars);
QGA.ub=QGA_Repmat_Sub(QGA.ub,nvars);
QGA.codesize=QGA_Repmat_Sub(QGA.codesize,nvars);

function y=QGA_Repmat_Sub(x,n)

if isscalar(x)
    y=repmat(x,1,n);
elseif isvector(x)
    if length(x)==n
        y=x(:)';
    else
        error('length(x)≠n');
    end
else
    error('x必须是向量或者标量');
end
       
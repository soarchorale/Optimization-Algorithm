function p = subsasgn(p,index,val)
% SUBSASGN Define index assignment for agent objects
switch index.type
case '()'
    switch index.subs{:}
    case 1
        p.ID = val;
    case 2
        p.angle = val;
    otherwise
        error('Index out of range')
    end
case '.'
    switch index.subs
    case 'ID'
        p.ID = val;
    case 'angle'
        p.angle = val;
    otherwise
        error('Invalid field name')
    end
end
function f = subsasgn(f,index,val)
% SUBSASGN Define index assignment for frogc objects
L=length(f); % for a single object
if L==1
    
    fc = fieldcount(f.frogp);
    switch index.type
        case '()'
            if (index.subs{:} <= fc)
                f.frogp = subsasgn(f.frogp,index,val);
            else
                switch index.subs{:}-fc
                    case 1
                        f.gap = val;
                    case 2
                        f.supergap = val;
                    otherwise
                        error(['Index must be in the range 1 to ',num2str(fc + 2)])
                end
            end
        case '.'
            switch index.subs
                case 'gap'
                    f.gap = val;
                case 'supergap'
                    f.supergap = val;
                otherwise
                    f.frogp = subsasgn(f.frogp,index,val);
            end
    end
    
else
    f(index.subs{:})=val; % returns one object at index
end
function frogs = newangles(frogs)
% Computes the frog new angles when they move to another position

global gaps supergaps N

for i = 1: N
    if i == 2       %This special case avoids having wrong indices in the new angles computation
        [val,ind] = min([gaps(N), supergaps(i), gaps(i)]);
        if ind == 1         % gap(N) is the minimum gap
            frogs(i)=set(frogs(i), 'angle', get(frogs(i-1),'angle')-0.3*gaps(N));   %Calls the get and set methods in @frogc
        elseif ind == 3     % gap(i) is the minimum gap
            frogs(i)=set(frogs(i), 'angle', get(frogs(i+1),'angle')+0.3*gaps(i+1));
        end
    elseif i == N-1
        [val,ind] = min([gaps(mod(i-2,N)), supergaps(i), gaps(N)]);
        if ind == 1         % gap(mod(i-2,N)) is the minimum gap
            frogs(i)=set(frogs(i), 'angle', (get(frogs(mod(i-2,N)),'angle')+0.7*gaps(mod(i-2,N))));
        elseif ind == 3     % gap(mod(i+1,N)) is the minimum gap
            frogs(i)=set(frogs(i), 'angle', (get(frogs(N),'angle')+0.3*gaps(N)));
        end
        
    else
        [val,ind] = min([gaps(mod(i-2,N)), supergaps(i), gaps(mod(i+1,N))]);
        if ind == 1         % gap(mod(i-2,N)) is the minimum gap
            frogs(i)=set(frogs(i), 'angle', (get(frogs(mod(i-2,N)),'angle')+0.7*gaps(mod(i-2,N))));
        elseif ind == 3     % gap(mod(i+1,N)) is the minimum gap
            frogs(i)=set(frogs(i), 'angle', (get(frogs(mod(i+1,N)),'angle')+0.3*gaps(mod(i+1,N))));
        end
    end
end
return
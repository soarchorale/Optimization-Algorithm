function gaps = compgaps(frogs)
% Computes the angular difference between two consecutive frogs

global N gaps

for i = 1: N
    i1 = mod(i,N);
    i2 = mod(i+1,N);
    if i1 == 0          %This handles the case for the computation of the gap of the Nth frog
        gaps(i) = get(frogs(i2),'angle')-get(frogs(i),'angle')+360; %Calls the get method in the directory @frogc
    elseif i2 == 0      %This handles the case for the computation of the gap of the (N-1)th frog
        gaps(i) = get(frogs(N),'angle')-get(frogs(i),'angle');
    else
        gaps(i) = get(frogs(i+1),'angle')-get(frogs(i),'angle');
    end
    
end
return
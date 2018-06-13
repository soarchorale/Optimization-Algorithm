function supergaps = compsupergaps(gaps)
% Computes the angular difference between two consecutive gaps

global N supergaps

for i = 1: N
    if i == 1       %This handles the case for the computation of the gap of the Nth frog
        supergaps(i) = gaps(i)+gaps(N);
    else
        supergaps(i) = gaps(i)+gaps(i-1);
    end
    
end
return
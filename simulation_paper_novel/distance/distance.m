function d = distance( inputcities )
% DISTANCE
% �����ܵľ���

d = 0;
for n = 1 : length(inputcities)
    if n == length(inputcities)
        d = d + norm(inputcities(:,n) - inputcities(:,1));
    else    
        d = d + norm(inputcities(:,n) - inputcities(:,n+1));
    end
end


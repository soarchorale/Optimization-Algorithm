function [angles] = everyangle(frogs)
% Assigns the angles of all frogs to angles(m,1) vector
global N
for  m = 1:N
        angles(m,1) = get(frogs(m),'angle');
end
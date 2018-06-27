function [frogs] = sort(frogs)
% Sort in ascending order the angles of frogp object ant its associate fields (ID, angle, gap, supergap)

global N

for i = 1: N
    % Gets the angles from frogs
    tmp_angle(i) = get(frogs(i),'angle');
end
%Sorts them and stores their indices
[tmp_angle,ind]=sort(tmp_angle);

temp = frogs;
%Now stores the angles in ascendent order with all their fields
for i = 1:N
    %Two methods are called here: set is called first and then subsasgn is called
    frogs(i) = set(temp(i), 'ID', get(temp(ind(i)),'ID'), 'angle', get(temp(ind(i)),'angle'),...
        'gap', get(temp(ind(i)),'gap'), 'supergap', get(temp(ind(i)),'supergap'));
end
return
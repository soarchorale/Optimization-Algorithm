function val = get(f,prop_name)
% GET Get frogc property from the specified object
% and return the value. Property names are: ID,
% angle, gap, supergap.
switch prop_name
%parent fields
case 'ID'
    val = get(f.frogp,'ID');    % call frogp get method
case 'angle'
    val = get(f.frogp,'angle'); % call frogp get method
% child fields    
case 'gap'
    val = f.gap;
case 'supergap'
    val = f.supergap; 
otherwise
    error([prop_name ,'Is not a valid frogc property'])
end
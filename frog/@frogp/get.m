function val = get(frogp,prop_name)
% GET Get asset properties from the specified object
% and return the value
switch prop_name
case 'ID'
    val = frogp.ID;
case 'angle'
    val = frogp.angle;
otherwise
    error([prop_name,' Is not a valid frogp property'])
end
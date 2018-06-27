function f = set(f,varargin)
% SET Set frogc properties to the specified values
% and return the updated object

property_argin = varargin;      
while length(property_argin) >= 2,  %This takes care of the number of properties that needs to be set
    prop = property_argin{1};
    val = property_argin{2};
    property_argin = property_argin(3:end);
    switch prop
    %fields define by the parents of the frogp object    
    case 'ID'
        f.frogp = set(f.frogp, 'ID', val);      %Calls the set method in @frogp
    case 'angle'
        f.frogp = set(f.frogp, 'angle', val);   %Calls the set method in @frogp
    %additional fields from the child object
    case 'gap'
        f.gap = val;
    case 'supergap'
        f.supergap = val;
    otherwise
        error('Invalid property')
    end
end
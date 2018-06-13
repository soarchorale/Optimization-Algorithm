function f = set(f,varargin)
% SET Set frogp properties to the specified values
% and return the updated object
property_argin = varargin;
while length(property_argin) >= 2,
    prop = property_argin{1};
    val = property_argin{2};
    property_argin = property_argin(3:end);
    
    switch prop
    case 'ID'
        f.ID = val;
    case 'angle'
        f.angle = val;
    otherwise
        error('Invalid property')
    end
end
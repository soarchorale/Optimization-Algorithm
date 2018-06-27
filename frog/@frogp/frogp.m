function p = frogp(varargin)
% FROGP Constructor function for frogp object
% f = frogp(ID, angle)
switch nargin
    case 0 
        % if no input arguments, create a default object
        p.ID = 0;
        p.angle = 0;
        p = class(p, 'frogp');      
    case 1
        % if single argument of class agent, return it
        if (isa(varargin{1},'frogp'))
            p = varargin{1};
        else
            error('Wrong argument type')
        end 
    
    case 2
        % create object using specified values
        p.ID= varargin{1};
        p.angle = varargin{2};
        p = class(p,'frogp');
    otherwise
        error('Wrong number of input arguments')
end
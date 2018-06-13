function f = frogc(varargin)
% FROGC frogc class constructor. 
% This class creates a child object from the frogp class.
% f = frogc(descriptor, gap, supergap, ID, angle)
switch nargin
    case 0 
        % if no input arguments, create a default object
        f.gap = 0;
        f.supergap = 0;
        p = frogp;  %This calls the frogp constructor method at @frogp. It is a parent object for the frogc object. 
                    %This is stored as a field (.frogp) in the frogc structure when a child object is created (next command)   
        f = class(f, 'frogc',p);    %     
    case 1
        % if single argument of class frogc, return it
        if (isa(varargin{1},'frogc'))
            f = varargin{1}; 
        else
            error('Input argument is not a frogc object')
        end
    case 5
        % create object using specified values
        f.gap = varargin{2};
        f.supergap = varargin{3};
        p = frogp(varargin{4}, varargin{5});
        f = class(f,'frogc',p);
    otherwise
        error('Wrong number of input arguments')
end
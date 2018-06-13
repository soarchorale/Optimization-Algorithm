function display(s)
% DISPLAY(s) Display an frogp object

% display(s.frogp) If this is a child then I could display everything from its
% parent

stg = sprintf('\n ID: %d \n angle: %d ',...
   s.ID, s.angle);

disp(stg)
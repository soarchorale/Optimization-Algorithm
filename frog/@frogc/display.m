function display(s)
% DISPLAY(s) Display a frogc object

L=length(s); % enables to display object arrays (the array is an object itself)

for i=1:L
    
    display(s(i).frogp)
    stg = sprintf(' gap: %d\n supergap: %d\n',...
        s(i).gap,s(i).supergap);
    disp(stg)
    
end
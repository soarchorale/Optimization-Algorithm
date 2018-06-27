function [frogs] = make_frogs(dummy)
% initializing the set of vehicles

global N

frogs = [];                    

% creating and randomly reassigning the initial location of frogs
temp_angle=sort(rand(N,1)*360);
temp_frog = frogc;      %This calls the frogc constructor method in directory @frogc

for i = 1: N
    % gap: angular distance between two consecutive frogs
    % supergap: angular distance between two consecutive gaps
    temp_frog.ID = i;
    temp_frog.angle = temp_angle(i);
    frogs = [frogs; temp_frog]; %% column vector of frogs, ith column is frog 'i'
end
return
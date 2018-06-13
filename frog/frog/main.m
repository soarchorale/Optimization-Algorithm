%This program simulates the model of predation
%for a colony of frogs and a water-snake.
%The frogs are sitting on the rim of a circular pond.
%Alvaro Gil
%April 8, 2004

clear all

global N gaps supergaps
N = 200;                 %Number of frogs

N_k = 400;               %Simulation steps

%Allocates memory for variables
gaps=zeros(N,1);
supergaps=zeros(N,1);
anglesset = zeros(N,N_k);

frogs = make_frogs;   %Creates an array of class frog and defines initial distribution of frogs around the pond

% Now we simulate the frogs' hops on the pond rim
for i = 1:N_k
    %First, we compute the gaps between consecutive frog angles
    gaps = compgaps(frogs);
    %We compute the supergaps between consecutive gaps
    supergaps = compsupergaps(gaps);
    %This function determines frogs' hops and computes new angles for the frogs that hop
    %This function can be put in the frog directory either
    frogs = newangles(frogs);
    % Sort in ascending order the angles of frogsp object
    % It has to be in the frogc directory. It overloads the default sort command in MATLAB
    frogs = sort(frogs);
    % The angles for every simulation step and every frog are stored here
    anglesset(:,i) = everyangle(frogs);     %Calls the everyangle method in frogc
end

%Plots the final results
clf
%Initial dispersion
polar(anglesset(:,1)*pi/180,ones(size(anglesset(:,N_k))),'o'),hold on
%Final dispersion
polar(anglesset(:,N_k)*pi/180,ones(size(anglesset(:,N_k))),'r*'), hold off
title('Gregarious behavior of frogs')
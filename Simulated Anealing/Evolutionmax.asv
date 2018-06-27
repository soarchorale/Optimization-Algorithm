function [Xbestout Xcurrent] = Evolutionmax( initialtemperature ,coolingrate,...
    maxiterations,initialsolution,mintemperature)
%EVOLUTIONMAX Summary of this function goes here
%   Detailed explanation goes here
mainHandles = guidata(simulatedannealing);

%--------------------------Evolution-------------------------------------%


%   Eingabe : T0,Step1,Step2,Xcurrent,
%   Ausgabe : Xbest
%------------------------------------------------------------------------%
%                         init.data
%------------------------------------------------------------------------%
T0=initialtemperature;
T = T0;
Tmin=mintemperature;
N=1;
Nk=maxiterations;
a=coolingrate;
X0=initialsolution;
X0=rot90(X0);
m=size(X0);
Xcurrent_i=X0;
Xbest=X0;
bestFktwert = -objfkt(Xbest);
i=0;
p=0;
strstep1 =get(mainHandles.Step1,'String');
step1 = str2double(strstep1);
strstep2 =get(mainHandles.Step2,'String');
step2 = str2double(strstep2);
%------------------------------------------------------------------------%

while p < step2
        
    [Xbest_temp,Xcurrent_k] = Samplingmax (Xbest,Xcurrent_i,T,step1);
    Xcurrent_i = Xcurrent_k;
    
    bestFktwert = -objfkt(Xbest);
    bestFktwert_temp = -objfkt(Xbest_temp);
    
    if bestFktwert < bestFktwert_temp
        p = p + 1;
    else
        Xbest = Xbest_temp;
        set(mainHandles.best_result_Evolution, 'Data',rot90(Xbest))
        p = 0;
    end   
    
    i = i + 1;
    T = a*T;   % temperature update  
   
    Fkt(i)=objfkt(Xbest);   
    times = 1 : i;
    temp = plot(times, Fkt,'*');
    set(temp,'color','b');
    titledisp=sprintf('best Function value : %f',Fkt(i) );
    title(titledisp,'fontweight','bold');
    
    strtemp = sprintf('Temperatur : %.3f',T);
    set(mainHandles.dispemperatur_evolution, 'String',strtemp)
    strtemp = sprintf('Iterations : %.0f',i);
    set(mainHandles.dispiterations_evolution, 'String',strtemp)
    
    %mainHandles = guidata(simulatedannealing);  
    %set(mainHandles.best_result_Evolution, 'Data',rot90(Xbest))
    drawnow;
    
    if T<Tmin
        p = step2;
    end
  
end
   Xbestout=Xbest;   
 

end


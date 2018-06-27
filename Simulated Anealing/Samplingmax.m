function [Xbest_temp_out,Xcurrent_k] = Samplingmax (Xbest,Xcurrent_i,T,step)
%SAMPLINGMAX Summary of this function goes here
%   Detailed explanation goes here

%----------------------------------------------------------------------%
%k=0;            
u=0;                %unendlich Funktion wenn gr?sser als 1000
q=0;
Xbest_temp=Xbest;
Xcurrent_temp = Xcurrent_i;
step1=step;
%-----------------------------------------------------------------------%
while q < step1 

       Fc = -objfkt(Xcurrent_temp);
       m = size(Xcurrent_temp);
       randdiff = 0.1.*(rand(m)- 0.5);  %Neu Solution erzeugen
       Xneu = Xcurrent_temp+randdiff; 
       Fneu =-objfkt(Xneu);
       Diff = Fneu-Fc;
       
       if Diff < 0
           
            Xcurrent_temp = Xneu;
            
            if  -objfkt(Xbest_temp) >  -objfkt(Xcurrent_temp)
                
                Xbest_temp=Xcurrent_temp;
                q = 0;
                u = u +1;
            else
                q = q+1;
            end
            
       elseif exp(-Diff/T) > rand
           
           Xcurrent_temp = Xneu;
           
           q = q+1;
           
       else
           
           Xcurrent_temp=Xcurrent_temp;
       
       end
       
       if u > 1000 
           q = step1;
       end
       
end

Xbest_temp_out=Xbest_temp;
Xcurrent_k=Xcurrent_temp;
           

end


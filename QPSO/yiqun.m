clc;
clear;
% N = number_of_test_sample; 
N =150;
% n = number_of_attribute_of_test_sample; 
n = 4;
% K = number_of_cluster; 
K = 3;
% R = number_of_ants; 
R = 10;
% t_max = MaxIterations; 
t_max = 1000;
% X = test_sample_matrix;
X = [
 5.1 3.5 1.4 0.2  
4.9 3.0 1.4 0.2  
4.7 3.2 1.3 0.2  
4.6 3.1 1.5 0.2  
5.0 3.6 1.4 0.2  
5.4 3.9 1.7 0.4  
4.6 3.4 1.4 0.3  
5.0 3.4 1.5 0.2  
4.4 2.9 1.4 0.2  
4.9 3.1 1.5 0.1  
5.4 3.7 1.5 0.2  
4.8 3.4 1.6 0.2  
4.8 3.0 1.4 0.1  
4.3 3.0 1.1 0.1  
5.8 4.0 1.2 0.2  
5.7 4.4 1.5 0.4  
5.4 3.9 1.3 0.4  
5.1 3.5 1.4 0.3  
5.7 3.8 1.7 0.3  
5.1 3.8 1.5 0.3  
5.4 3.4 1.7 0.2  
5.1 3.7 1.5 0.4  
4.6 3.6 1.0 0.2  
5.1 3.3 1.7 0.5  
4.8 3.4 1.9 0.2  
5.0 3.0 1.6 0.2  
5.0 3.4 1.6 0.4  
5.2 3.5 1.5 0.2  
5.2 3.4 1.4 0.2  
4.7 3.2 1.6 0.2  
4.8 3.1 1.6 0.2  
5.4 3.4 1.5 0.4  
5.2 4.1 1.5 0.1  
5.5 4.2 1.4 0.2  
4.9 3.1 1.5 0.1  
5.0 3.2 1.2 0.2  
5.5 3.5 1.3 0.2  
4.9 3.1 1.5 0.1  
4.4 3.0 1.3 0.2  
5.1 3.4 1.5 0.2  
5.0 3.5 1.3 0.3  
4.5 2.3 1.3 0.3  
4.4 3.2 1.3 0.2  
5.0 3.5 1.6 0.6  
5.1 3.8 1.9 0.4  
4.8 3.0 1.4 0.3  
5.1 3.8 1.6 0.2  
4.6 3.2 1.4 0.2  
5.3 3.7 1.5 0.2  
5.0 3.3 1.4 0.2  
7.0 3.2 4.7 1.4  
6.4 3.2 4.5 1.5  
6.9 3.1 4.9 1.5  
5.5 2.3 4.0 1.3  
6.5 2.8 4.6 1.5  
5.7 2.8 4.5 1.3  
6.3 3.3 4.7 1.6  
4.9 2.4 3.3 1.0  
6.6 2.9 4.6 1.3  
5.2 2.7 3.9 1.4  
5.0 2.0 3.5 1.0  
5.9 3.0 4.2 1.5  
6.0 2.2 4.0 1.0  
6.1 2.9 4.7 1.4  
5.6 2.9 3.6 1.3  
6.7 3.1 4.4 1.4  
5.6 3.0 4.5 1.5  
5.8 2.7 4.1 1.0  
6.2 2.2 4.5 1.5  
5.6 2.5 3.9 1.1  
5.9 3.2 4.8 1.8  
6.1 2.8 4.0 1.3  
6.3 2.5 4.9 1.5  
6.1 2.8 4.7 1.2  
6.4 2.9 4.3 1.3  
6.6 3.0 4.4 1.4  
6.8 2.8 4.8 1.4  
6.7 3.0 5.0 1.7  
6.0 2.9 4.5 1.5  
5.7 2.6 3.5 1.0  
5.5 2.4 3.8 1.1  
5.5 2.4 3.7 1.0  
5.8 2.7 3.9 1.2  
6.0 2.7 5.1 1.6  
5.4 3.0 4.5 1.5  
6.0 3.4 4.5 1.6  
6.7 3.1 4.7 1.5  
6.3 2.3 4.4 1.3  
5.6 3.0 4.1 1.3  
5.5 2.5 4.0 1.3  
5.5 2.6 4.4 1.2  
6.1 3.0 4.6 1.4  
5.8 2.6 4.0 1.2  
5.0 2.3 3.3 1.0  
5.6 2.7 4.2 1.3  
5.7 3.0 4.2 1.2  
5.7 2.9 4.2 1.3  
6.2 2.9 4.3 1.3  
5.1 2.5 3.0 1.1  
5.7 2.8 4.1 1.3  
6.3 3.3 6.0 2.5  
5.8 2.7 5.1 1.9  
7.1 3.0 5.9 2.1  
6.3 2.9 5.6 1.8  
6.5 3.0 5.8 2.2  
7.6 3.0 6.6 2.1  
4.9 2.5 4.5 1.7  
7.3 2.9 6.3 1.8  
6.7 2.5 5.8 1.8  
7.2 3.6 6.1 2.5  
6.5 3.2 5.1 2.0  
6.4 2.7 5.3 1.9  
6.8 3.0 5.5 2.1  
5.7 2.5 5.0 2.0  
5.8 2.8 5.1 2.4  
6.4 3.2 5.3 2.3  
6.5 3.0 5.5 1.8  
7.7 3.8 6.7 2.2  
7.7 2.6 6.9 2.3  
6.0 2.2 5.0 1.5  
6.9 3.2 5.7 2.3  
5.6 2.8 4.9 2.0  
7.7 2.8 6.7 2.0  
6.3 2.7 4.9 1.8  
6.7 3.3 5.7 2.1  
7.2 3.2 6.0 1.8  
6.2 2.8 4.8 1.8  
6.1 3.0 4.9 1.8  
6.4 2.8 5.6 2.1  
7.2 3.0 5.8 1.6  
7.4 2.8 6.1 1.9  
7.9 3.8 6.4 2.0  
6.4 2.8 5.6 2.2  
6.3 2.8 5.1 1.5  
6.1 2.6 5.6 1.4  
7.7 3.0 6.1 2.3  
6.3 3.4 5.6 2.4  
6.4 3.1 5.5 1.8  
6.0 3.0 4.8 1.8  
6.9 3.1 5.4 2.1  
6.7 3.1 5.6 2.4  
6.9 3.1 5.1 2.3  
5.8 2.7 5.1 1.9  
6.8 3.2 5.9 2.3  
6.7 3.3 5.7 2.5  
6.7 3.0 5.2 2.3  
6.3 2.5 5.0 1.9  
6.5 3.0 5.2 2.0  
6.2 3.4 5.4 2.3  
5.9 3.0 5.1 1.8  
   ];

% INITIALIZATION 

% pheromone trails 
c = 10^-2;
tau = ones(N,K) * c;
%tau = [
%    0.014756 0.015274 0.009900;
%    0.015274 0.009900 0.014756;
%    0.015274 0.014756 0.009900;
%    0.009900 0.015274 0.014756;
%    0.014756 0.015274 0.009900;
%    0.009900 0.014756 0.015274;
%    0.009900 0.020131 0.009900;
%    0.015274 0.014756 0.009900;
%];
% probability  threshold q
q = 0.9;
% evaporation rate
rho = 0.1;
% fitness function
best_solution_function_value = inf;

t = 1; 
while ((t <= t_max))
   
% SEND R ANTS EACH WITH EMPTY SOLUTION STRING,S =============================
% solution string : every ant construction solution and fitness function


solution_string = zeros(R,N+1);

% COMPUTE R SOLUTION 

for i = 1 : R            
   % solution_string(1,1:N) = randint(1,N,[1,K]);
    r = rand(1,N);              %construct solution Si using pheromone trail
    for g = 1 : N
        if r(g) < q
            tau_max = max(tau(g,:));
            Cluster_number = find(tau(g,:)==tau_max);
            solution_string(i,g) = Cluster_number(1);    %%%%%%%%%%%%% 1--i
        else
            sum_p = sum(tau(g,:)); 
            p = tau(g,:) / sum_p; 
            for u = 2 : K 
                p(u) = p(u) + p(u-1); 
           end
           rr = rand; 
           %Cluster_number = K;
           for s = 1 : K 
               if (rr <= p(s)) 
                   Cluster_number = s;
                   solution_string(i,g) = Cluster_number;  %%%%%%%%%%%%%  1--i
                   break; 
               end 
           end
       end
   end
   
   % compute weights(weight) of all test samples and cluster centers(cluster_center)
   
   weight = zeros(N,K);
   for h = 1:N
       Cluster_index = solution_string(i,h);            %%%%%%%%%%%%%  1--i
       weight(h,Cluster_index) = 1;
   end
   
   cluster_center = zeros(K,n);
   for j = 1:K
       for v = 1:n
           sum_wx = sum(weight(:,j).*X(:,v));
           sum_w = sum(weight(:,j));
           if sum_w==0
             cluster_center(j,v) =0
              continue;
          else
           cluster_center(j,v) = sum_wx/sum_w;
       end
       end
   end
   
   % computer clustering metric and 
   % assign it as objective function value Fi of solution ,Si
   
  F = 0;
  for j= 1:K
      for ii = 1:N
          Temp=0;
          if solution_string(i,ii)==j;                 %%%%%%%%%%%%%  1--i
              for v = 1:n
                  Temp = ((abs(X(ii,v)-cluster_center(j,v))).^2)+Temp;
              end
              Temp = sqrt(Temp);
          end
          F = (Temp)+F;
      end
  end

   solution_string(i,end) = F;                        %%%%%%%%%%%%%  1--i
  
end %for i = 1 : R 

% select best L solutions out of R solutions using objective function values

% LOCAL SEARCH PROCEDURES====================================================

% fitness sort in ascending order
[fitness_ascend,solution_index] = sort(solution_string(:,end),1);
solution_ascend = [solution_string(solution_index,1:end-1) fitness_ascend];

% pls is local search threshold probability
pls = 0.05;
% perform local search on L solution
L = 2;

% local search procedures
solution_temp = zeros(L,N+1);
k = 1;
while(k <= L)
   solution_temp(k,:) = solution_ascend(k,:);
   rp = rand(1,N);
   for i = 1:N
       if rp(i) <= pls
           current_cluster_number = setdiff([1:K],solution_temp(k,i));
           change_cluster = randint(1,1,current_cluster_number);
           solution_temp(k,i) = change_cluster;
       end
   end
   
   % computer weights of all test samples and cluster centers
   
   solution_temp_weight = zeros(N,K);
   for h = 1:N
       solution_temp_cluster_index = solution_temp(k,h);            %%%%%%%%%%%%%  1--k
       solution_temp_weight(h,solution_temp_cluster_index) = 1;
   end
   
   solution_temp_cluster_center = zeros(K,n);
   for j = 1:K
       for v = 1:n
           solution_temp_sum_wx = sum(solution_temp_weight(:,j).*X(:,v));
           solution_temp_sum_w = sum(solution_temp_weight(:,j));
           if solution_temp_sum_w==0
             solution_temp_cluster_center(j,v) =0;
              continue;
          else
           solution_temp_cluster_center(j,v) = solution_temp_sum_wx/solution_temp_sum_w;
       end
       end
   end
   
   % computer solution temp clustering metric and 
   % assign it as objective function value Ft of solution ,St
   
  solution_temp_F = 0;
  for j= 1:K
      for ii = 1:N
          st_Temp=0;
          if solution_temp(k,ii)==j;                                %%%%%%%%%%%%%  1--k
              for v = 1:n
                  st_Temp = ((abs(X(ii,v)-solution_temp_cluster_center(j,v))).^2)+st_Temp;
              end
              st_Temp = sqrt(st_Temp);
          end
          solution_temp_F = (st_Temp)+solution_temp_F;
      end
  end
  
  solution_temp(k,end) = solution_temp_F;                           %%%%%%%%%%%%%  1--k
  
  % if Ft<Fl then Fl=Ft and Sl=St
  if solution_temp(k,end) <= solution_ascend(k,end)                  %%%%%%%%%%%%%  1--k
      solution_ascend(k,:) = solution_temp(k,:);                     %%%%%%%%%%%%%  1--k
  end
  
  if solution_ascend(k,end)<=best_solution_function_value
      best_solution = solution_ascend(k,:);
  end

   k = k+1;
end   %end while(local search)


% UPDATE PHEROMONE TRAIL MATRIX=============================================
% Update pheromone trail matrix using best L solution
% for i = 1 : N
%     %for j = 1 : L
%         tau(i,best_solution(1,i)) = (1 - rho) * tau(i,best_solution(1,i)) + rho / (sum(best_solution(1,end))); 
%         %end
% end
% 
% t = t+1;
% end %while(main)
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

tau_F = 0;
for j = 1:L    
   tau_F = tau_F + solution_ascend(j,end);
end
for i = 1 : N        
   tau(i,best_solution(1,i)) = (1 - rho) * tau(i,best_solution(1,i)) + 1/ tau_F; 

%use 1/tau_F or rho/tau_F, neither of them is good
end 
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
t=t+1;
end  
   
clc; 
t 
best_solution = solution_ascend(1,1:end-1) 
best_solution_function_value =  solution_ascend(1,end)



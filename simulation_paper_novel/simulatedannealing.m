function s = simulatedannealing(population,initial_temperature,threshold)
% SIMULATEDANNEALING
% 核心算法

global iterations;

% 设置初始温度
temperature = initial_temperature;
temperature=1000;
Bound=[0  10; 0  0.1;    0.1  1;  -0.1  0.1;  2  10; 0 0.1]


% 初始化迭代次数
iterations = 1;

% 目标函数
p_population=population;
% 采用Lundy-Mee方法，设置终止温度和冷却系数
ksi=0.01;
deta=0.01;
a=exp(1);
citynumber=length(population);
answernumber=factorial(citynumber-1);
terminal_temperature=ksi/((log2(answernumber-1))/log2(a)-(log2(deta))/log2(a));
temperatureratio=(temperature-terminal_temperature)/(terminal_temperature*temperature*threshold);

while temperature > terminal_temperature
while iterations < threshold
    for i=1:threshold
        c_population=population+0.001*(2*rand(1)-1)*(Bound(:,2)-Bound(:,1)) + Bound(:,1);
        p_fvalue=fun_epoxy_sum_diff(p_population);
        c_fvalue=fun_epoxy_sum_diff(c_population);
        diff=c_fvalue- p_fvalue;
    if p_fvalue < c_fvalue
          if rand(1) < exp(-diff/(temperature))
        population=c_population;
          else
              population=p_populaiton;
          end
        iterations = iterations + 1;
    end
    end
end
temperature=temperature/(1+temperatureratio*temperature);
end


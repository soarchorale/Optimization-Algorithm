function s = simulatedannealing( inputcities,initial_temperature,...
    threshold,numberofcitiestoswap )
% SIMULATEDANNEALING
% 核心算法

global iterations;

% 设置初始温度
temperature = initial_temperature;

% 随着目标值的优化，不断缩小邻域的范围
initial_cities_to_swap = numberofcitiestoswap;

% 初始化迭代次数
iterations = 1;

% 目标函数
previous_distance = distance(inputcities);

% 采用Lundy-Mee方法，设置终止温度和冷却系数
ksi=0.01;
deta=0.01;
a=exp(1);
citynumber=length(inputcities);
answernumber=factorial(citynumber-1);
terminal_temperature=ksi/((log2(answernumber-1))/log2(a)-(log2(deta))/log2(a));
temperatureratio=(temperature-terminal_temperature)/(terminal_temperature*temperature*threshold);

while temperature > terminal_temperature
while iterations < threshold
    temp_cities = swapcities(inputcities,numberofcitiestoswap);
    current_distance = distance(temp_cities);
    diff = abs(current_distance - previous_distance);
    if current_distance < previous_distance
        inputcities = temp_cities;
        if rem(iterations,100) == 0
                plotcities(inputcities);% 迭代100次，画一次图
        end
        numberofcitiestoswap = round(numberofcitiestoswap...
            *exp(-diff/(iterations*temperature)));% 随着目标值的优化，不断缩小邻域的范围
        if numberofcitiestoswap == 0
            numberofcitiestoswap = 1;
        end
        previous_distance = current_distance;
        iterations = iterations + 1;
    else
        if rand(1) < exp(-diff/(temperature))%以一定概率接受
            inputcities = temp_cities;
            if rem(iterations,100) == 0解
                plotcities(inputcities);% 迭代100次，画一次图
            end
            numberofcitiestoswap = round(numberofcitiestoswap...
                *exp(-diff/(iterations*temperature)));% 随着目标值的优化，不断缩小邻域的范围
            if numberofcitiestoswap == 0
                numberofcitiestoswap = 1;
            end
            previous_distance = current_distance;
            iterations = iterations + 1;
        end
    end
end
temperature=temperature/(1+temperatureratio*temperature);
end


function s = simulatedannealing( inputcities,initial_temperature,...
    threshold,numberofcitiestoswap )
% SIMULATEDANNEALING
% �����㷨

global iterations;

% ���ó�ʼ�¶�
temperature = initial_temperature;

% ����Ŀ��ֵ���Ż���������С����ķ�Χ
initial_cities_to_swap = numberofcitiestoswap;

% ��ʼ����������
iterations = 1;

% Ŀ�꺯��
previous_distance = distance(inputcities);

% ����Lundy-Mee������������ֹ�¶Ⱥ���ȴϵ��
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
                plotcities(inputcities);% ����100�Σ���һ��ͼ
        end
        numberofcitiestoswap = round(numberofcitiestoswap...
            *exp(-diff/(iterations*temperature)));% ����Ŀ��ֵ���Ż���������С����ķ�Χ
        if numberofcitiestoswap == 0
            numberofcitiestoswap = 1;
        end
        previous_distance = current_distance;
        iterations = iterations + 1;
    else
        if rand(1) < exp(-diff/(temperature))%��һ�����ʽ���
            inputcities = temp_cities;
            if rem(iterations,100) == 0��
                plotcities(inputcities);% ����100�Σ���һ��ͼ
            end
            numberofcitiestoswap = round(numberofcitiestoswap...
                *exp(-diff/(iterations*temperature)));% ����Ŀ��ֵ���Ż���������С����ķ�Χ
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


function s = swapcities( inputcities,n )
% SWAPCITIES
% �任����N��
s = inputcities;

for i = 1 : n
    city_1 = round(length(inputcities)*rand(1));
    if city_1 < 1 
        city_1 = 1;
    end
    city_2 = round(length(inputcities)*rand(1));
    if city_2 < 1
        city_2 = 1;
    end
    temp = s(:,city_1);
    s(:,city_1) = s(:,city_2);
    s(:,city_2) = temp;
end


clear;
cities = [33492,52044,94042,40346,99043,22775,30449,62746,30088,18504,74708,50648,15600,28057,69683,94350,79255,93403,95895,35643,59294,51099,72234,17,91577,38938,64950,31127,82816,50815
    87217,41194,60895,53793,43908,46164,96689,52449,69829,66547,23930,65323,95791,60602,84333,90409,49501,99750,49017,65703,92229,19693,9764,65903,57253,74767,54717,97147,5774,48748
];%����
initial_temperature=2000;%InitailTemperature(cities,1000);%ȷ����ʼ�¶�
numberofcitiestoswap=2;
threshold=100000;
simulatedannealing(cities,initial_temperature,threshold,numberofcitiestoswap);
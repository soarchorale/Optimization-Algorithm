clear all
epl33s=1.67e-9
tan_ct_e=0.0473
k_t=0.29
tan_ct_k= - 0.01
c33_D=3.252e+10
tan_ct_c=0.167
t=1.1e-3
rou=4750
tan_ct_m=tan_ct_c
A=10e-3^2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:500
    ff(i)=1e+6+ i*1000 ;   % 1M Hz
    f=1e+6+ i*1000;
M=pi*f*t * sqrt(rou/c33_D) *(1- 3* tan_ct_m^2 /8);

N=  (pi*f*t *tan_ct_m/2)* sqrt(rou/c33_D) *(1- 5* tan_ct_m^2 /16);

T= (tanh(N)* sec(M)^2*(1-tan_ct_k^2) - 2* tan_ct_k* tan(M) *sech(N)^2) *(M - N* tan_ct_e);


U= ( tan(M)* sech(N)^2*(1-tan_ct_k^2) + 2* tan_ct_k*tanh(N)* sec(M)^2) *(N + M* tan_ct_e);

F=( tanh(N)* sec(M)^2*(1-tan_ct_k^2) - 2* tan_ct_k*tan(M)* sech(N)^2) *(N + M* tan_ct_e);

G=(tan(M)* sech(N)^2*(1-tan_ct_k^2) + 2* tan_ct_k* tanh(N) *sec(M)^2) *(M - N* tan_ct_e);

S= (M^2 + N^2)* (1+ tan_ct_e^2) * ( 1+ tan(M)^2 * tanh(N)^2);

R_f= t*tan_ct_e /(2*pi*f * epl33s *A *(1+ tan_ct_e^2)) + t * k_t^2 *(T-U)/(2*pi*f * epl33s *A * S);

X_f= - t /(2*pi*f * epl33s *A *(1+ tan_ct_e^2)) + t * k_t^2 *(F+G)/(2*pi*f * epl33s *A * S);

Z_f(i)= sqrt (R_f^2 + X_f^2 );

phase_f(i)= atan (X_f / R_f) * 180/pi;

end

figure(1)
plot(ff,Z_f)
figure(2)
plot(ff,phase_f)

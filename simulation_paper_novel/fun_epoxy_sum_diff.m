
function [sum_diff_Z]=  fun_epoxy_sum_diff(epl33s, tan_ct_e, k_t,tan_ct_k,c33_D, tan_ct_c )

[Z_cal,phase_cal,ff]=  fun_epoxy(epl33s, tan_ct_e, k_t,tan_ct_k,c33_D, tan_ct_c );



%%%%≤‚¡ø÷µ%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
epl33s=5.556e-9;
tan_ct_e=0.08;
k_t=0.602;
tan_ct_k= - 0.0129;
c33_D=6.926e+10;
tan_ct_c=0.022;

[Z_m,phase_m,ff]=  fun_epoxy(epl33s, tan_ct_e, k_t,tan_ct_k,c33_D, tan_ct_c );
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sum_diff_Z=0;
ff_num=length(ff);
for j=1:ff_num
    sum_diff_Z = sum_diff_Z + (Z_cal(j) - Z_m(j) )^2;
end
end

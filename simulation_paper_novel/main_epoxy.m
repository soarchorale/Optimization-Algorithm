clear all


epl33s=5.556e-9
tan_ct_e=0.08
k_t=0.602
tan_ct_k= - 0.0129
c33_D=6.926e+10
tan_ct_c=0.022

[Z_f,phase_f,ff]=  fun_epoxy(epl33s, tan_ct_e, k_t,tan_ct_k,c33_D, tan_ct_c );
figure(1)
plot(ff,log(Z_f))
figure(2)
plot(ff,phase_f)
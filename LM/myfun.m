function val = myfun( x )
    a_lm = x(1); b_lm = x(2);
    data_1=[0.25 0.5 1 1.5 2 3 4 6 8];
    obs_1=[19.21 18.15 15.36 14.10 12.89 9.32 7.45 5.24 3.01];
    val = norm( a_lm*exp(-b_lm*data_1)-obs_1 );
end


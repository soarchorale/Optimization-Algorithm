function SecondDerivX = SecondDerivatives( myFx,X )
N = length(X);
for i=1:N  
  for j=1:N
    % calculate second derivative?
    if i == j
      f0 = feval(myFx, X);
      xt = X(i);
      hx = 0.01 * (1 + abs(xt));
      X(i) = xt + hx;
      fp = feval(myFx, X);
      X(i) = xt - hx;
      fm = feval(myFx, X);
      X(i) = xt;
      y = (fp - 2 * f0 + fm) / hx ^ 2;
    else
      xt = X(i);
      yt = X(j);
      hx = 0.01 * (1 + abs(xt));
      hy = 0.01 * (1 + abs(yt));
      % calculate fpp;
      X(i) = xt + hx;
      X(j) = yt + hy;
      fpp = feval(myFx, X);
      % calculate fmm;
      X(i) = xt - hx;
      X(j) = yt - hy;
      fmm = feval(myFx, X);
      % calculate fpm;
      X(i) = xt + hx;
      X(j) = yt - hy;
      fpm = feval(myFx, X);
      % calculate fmp
      X(i) = xt - hx;
      X(j) = yt + hy;
      fmp = feval(myFx, X);
      X(i) = xt;
      X(j) = yt;
      y = (fpp - fmp - fpm + fmm) / (4 * hx * hy);
    end  
    SecondDerivX(i,j) = y;
  end
end


function [alpha leftstd rightstd] = estimateaggdparam(vec)


gam   = 0.2:0.001:10;
r_gam = ((gamma(2./gam)).^2)./(gamma(1./gam).*gamma(3./gam));

if (isempty(vec(vec<0)))
    disp('*** is empty left side ***');
    leftstd = eps;
else
    leftstd            = sqrt(mean((vec(vec<0)).^2));
end

if (isempty(vec(vec>0)))
    disp('*** is empty right side ***');
    rightstd = eps;
else
    rightstd           = sqrt(mean((vec(vec>0)).^2));
end

gammahat           = leftstd/rightstd;
rhat               = (mean(abs(vec)))^2/mean((vec).^2);
rhatnorm           = (rhat*(gammahat^3 +1)*(gammahat+1))/((gammahat^2 +1)^2);
[min_difference, array_position] = min((r_gam - rhatnorm).^2);
alpha              = gam(array_position);



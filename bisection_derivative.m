function [c, k, n, calcs] = bisection_derivative(f, df, a, b, l)
%bisection_derivative The bisection method using derivatives.

global calcs;
calcs = 0;

n = 1;
while (1/2)^n > l / (b - a)
    n = n + 1;
end

k = 1;

for k = 1:n
    x(k) = (a(k) + b(k)) / 2;
    d = df(x(k));
    if (d == 0 )
        break
    elseif (d > 0)
        a(k + 1) = a(k);
        b(k + 1) = x(k);
    else
        a(k + 1) = x(k);
        b(k + 1) = b(k);
    end
end

c = x(k);

end

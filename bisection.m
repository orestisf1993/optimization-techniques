function [c, k, n, calcs] = bisection(f, a, b, e, l)
%bisection The bisection method.

global calcs;
calcs = 0;

k = 1;

n = 1;
while (1/2)^n > l / (b - a)
    n = n + 1;
end

a = [a zeros(1, n)];
b = [b zeros(1, n)];

iter = 0;

while b(k) - a(k) >= l
    iter = iter + 1;
    c = (a(k) + b(k))/2;
    x1 = c - e;
    x2 = c + e;
    if f(x1) < f(x2)
        a(k + 1) = a(k);
        b(k + 1) = x2;
    else
        a(k + 1) = x1;
        b(k + 1) = b(k);
    end
    k = k + 1;
end
c = (a(k) + b(k))/2;
k = k - 1;
end


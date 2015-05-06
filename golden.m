function [resa, k] = golden(f, a, b, l)
%golden The golden section method.

gamma = 0.618;
k = 1;

while b(k) - a(k) >= l
    x1(k) = a(k) + (1 - gamma) * (b(k) - a(k));
    x2(k) = a(k) + gamma * (b(k) - a(k));
    if f(x1(k)) > f(x2(k))
        a(k+1) = x1(k);
        b(k+1) = b(k);
        x1(k + 1) = x2(k);
        x2(k + 1) = a(k+1) + gamma * (b(k+1) - a(k+1));
    else
        a(k+1) = a(k);
        b(k+1) = x2(k);
        x1(k+1) = a(k+1) + (1-gamma) * (b(k+1) - a(k+1));
        x2(k+1) = x1(k);
    end
    k = k + 1;
end
resa = a(k-1);
resb = b(k-1);


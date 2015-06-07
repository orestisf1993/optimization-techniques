function [ x ] = barrier(fun, g, B, start_x, a)
%barrier barrier method

k = 2;
m = length(g);
x = start_x;
r = a * f(x(1,1), x(2,1)) / B(g, x(1,1), x(2,1));

while true    
    phi = @(x, y, r) (fun(x,y) + r * B(g, x, y));
    to_min = @(x) phi(x(1), x(2), r);
    x(:, k) = fminsearch(to_min, start_x);

    if (k > 100 || abs((f(x(1,k), x(2,k)) - f(x(1,k-1), x(2,k-1)))/f(x(1,k), x(2,k))) < 0.001)
        return
    end
    r = 0.9 * r;
    k = k + 1;
end

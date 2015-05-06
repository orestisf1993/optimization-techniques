function X=run_bi(method,f, a, b, e, l)
tic
i = 1;
if e == -1
    values = 1/10000000 : 1/10000000 : 0.49 * l; % e
elseif l == -1
    values = 1/10000000 : 1/10000000 : 0.1;       % l
else
    return;
end
k = zeros(1, length(values));
n = zeros(1, length(values));
calcs = zeros(1, length(values));
parfor i = 1: length(values)
    if e == -1
        [c, tmpk, tmpn, tmpcalcs] = method(f, a, b, values(i), l);
    else
        [c, tmpk, tmpn, tmpcalcs] = method(f, a, b, e, values(i));
    end
    k(i) = tmpk;
    n(i) = tmpn;
    calcs(i) = tmpcalcs;
end
figure;
plot(values, k)
figure;
plot(values, n)
figure;
plot(values, calcs)
toc
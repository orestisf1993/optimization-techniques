function [ k ] = valid_plot_values(gamma, fun)

[k,x] = fun(gamma);

if (~(all(abs(x(:,end) - [-1/2;-1/2]) <= 1e-8)))
    k = nan;
end

end


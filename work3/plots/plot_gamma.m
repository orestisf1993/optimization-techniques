function [] = plot_gamma(x, y, filename)

if ~exist('filename', 'var') || isempty(filename)
    filename = 'a';
end

g = gradf(x, y);
to_min = @(gamma) (f(x - gamma * g(1), y - gamma * g(2)));
clf;
fig = figure('visible','off');
ezplot(to_min, [0 2], fig)
print(filename, '-dpng', '-r300');
clf; close all;

end
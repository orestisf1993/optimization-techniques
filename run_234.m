function []=run_234(method, f, a, b, filename)
tic

l = 5e-07 : 5e-07 : 0.1;       % l
x = 'l';
const = 'ε';

calcs = zeros(1, length(l));
n = zeros(1, length(l));

parfor i = 1: length(l)
    [~, ~, tmpn, tmpcalcs] = method(f, a, b, l(i));     %#ok<*PFBNS>
    if tmpn ~= tmpcalcs
        error('wrong n - calcs!')
    end
    calcs(i) = tmpcalcs;
    n(i) = tmpn;
end

% figure;
% plot(l, k)
% figure;
% plot(l, n)
figure('visible','off');
plot(l, calcs)
hold;

% Create ylabel
ylabel({'Function calculations'},'FontSize',11);

% Create xlabel
xlabel(x,'FontSize',11);

% s = sprintf('Number of function calculations for varying %s and constant %s = %g', x, const, const_value);
% title(s);

legend('Actual calculations', 'Location','NorthWest');

ylim([max(min(calcs) - 2, 0), max(calcs) + 2]);
xlim([0, l(end)]);

filename = sprintf('%s_%s', filename, x);
print(filename, '-dpng', '-r300'); % Save as PNG with 300 DPI
cmd = sprintf('convert %s.png -trim %s.png', filename, filename); % trim with convert
system(cmd);

toc
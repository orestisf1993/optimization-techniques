function []=run_1(method, f, a, b, e, l, filename)
tic
if e == -1
    values = 1e-08 : 1e-8 : 0.49 * l; % e
    x = 'ε';
    const = 'l';
    const_value = l;
elseif l == -1
    values = 2.01 * e : 5e-07 : 0.1;       % l
    x = 'l';
    const = 'ε';
    const_value = e;
else
    return;
end

calcs = zeros(1, length(values));
n = zeros(1, length(values));

parfor i = 1: length(values)
    if e == -1
        [~, ~, tmpk, tmpn, tmpcalcs] = method(f, a, b, values(i), l); %#ok<*PFBNS>
    else
        [~, ~, tmpk, tmpn, tmpcalcs] = method(f, a, b, e, values(i));
    end
    if 2 * tmpk ~= tmpcalcs
        error('wrong k - calcs!')
    end
    calcs(i) = tmpcalcs;
    n(i) = tmpn;
end

n = n * 2;

% figure;
% plot(values, k)
% figure;
% plot(values, n)
figure('visible','off');
plot(values, calcs)
hold;
plot(values, n)

% Create ylabel
ylabel({'Function calculations'},'FontSize',11);

% Create xlabel
xlabel(x,'FontSize',11);

s = sprintf('Number of function calculations for varying %s and constant %s = %g', x, const, const_value);
title(s);

legend1 = sprintf('Actual calculations: %s', mat2str(unique(calcs)));
legend2 = sprintf('Theoritical calculations: %s', mat2str(unique(n)));

legend(legend1, legend2, 'Location','NorthWest');

ylim([max(min(calcs) - 2, 0), max(calcs) + 2]);
xlim([0, values(end)]);

filename = sprintf('%s_%s', filename, x);
print(filename, '-dpng', '-r300'); % Save as PNG with 300 DPI
cmd = sprintf('convert %s.png -trim %s.png', filename, filename); % trim with convert
system(cmd);

toc
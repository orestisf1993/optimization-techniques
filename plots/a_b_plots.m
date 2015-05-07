function [] = a_b_plots(f, method, astart, bstart, e, l, filename)

[a, b] = method(f, astart, bstart, e, l);
k = 1:length(a);

figure('visible','off');
plot(k,a);
hold
plot(k,b);
xmin = fminbnd(f, astart, bstart);
hline(xmin, 'r', 'Actual min');


ylim([astart, bstart]);
xlim([1, 20]);

% Create ylabel
ylabel({'a, b'},'FontSize',11);

% Create xlabel
xlabel('k','FontSize',11);

legend('a_k', 'b_k', 'Location','NorthEast');
title('[a_k, b_k] edges according to k values');

filename = sprintf('%s_ab_%g_%g', filename, e, l);
filename = strrep(filename, '.', ''); % delete dots in filename
print(filename, '-dpng', '-r300'); % Save as PNG with 300 DPI
cmd = sprintf('convert %s.png -trim %s.png', filename, filename); % trim with convert
system(cmd);


end
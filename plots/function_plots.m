function function_plots(f, X, tit, filename)

% Create figure
figure1 = figure;

xmin = fminbnd(f, X(1), X(2));
ymin = f(xmin);

% Create plot
fplot(f,X);

% Create ylabel
ylabel({'f(x)'},'FontSize',11);

% Create xlabel
xlabel({'x'},'FontSize',11);

% Create title
title(tit);

set(gca, 'XTick', sort([xmin, get(gca, 'XTick')]));

strmin = ['min = ',num2str(ymin)];
text(xmin, ymin, strmin, 'HorizontalAlignment', 'left');

print(filename, '-dpng', '-r300'); % Save as PNG with 300 DPI
cmd = sprintf('convert %s.png -trim %s.png', filename, filename); % trim with convert
system(cmd);
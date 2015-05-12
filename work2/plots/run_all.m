tic
clear all

e = 0.001;
l = 2.01 * e : 5e-07 : 0.1;
% l = 2.01 * e : 5e-03 : 0.1;
x = 'l';

calcs1 = zeros(1, length(l));
calcs2 = zeros(1, length(l));
calcs3 = zeros(1, length(l));
calcs4 = zeros(1, length(l));

parfor i = 1: length(l)
    [~, ~, ~, tmpcalcs1] = bisection(@f1, 1, 6, e,l(i));
    [~, ~, ~, tmpcalcs2] = golden(@f1, 1, 6, l(i));
    [~, ~, ~, tmpcalcs3] = fibonacci_search(@f1, 1, 6, l(i));
    [~, ~, ~, tmpcalcs4] = bisection_derivative(@f1, 1, 6, l(i));
    calcs1(i) = tmpcalcs1 * 2;
    calcs2(i) = tmpcalcs2;
    calcs3(i) = tmpcalcs3;
    calcs4(i) = tmpcalcs4;
end

% figure('visible','off');
figure
plot(l, calcs1)
hold;
plot(l, calcs2)
plot(l, calcs3)
plot(l, calcs4)


% Create ylabel
ylabel({'Function calculations'},'FontSize',11);

% Create xlabel
xlabel(x,'FontSize',11);

% s = sprintf('Number of function calculations for varying %s and constant %s = %g', x, const, const_value);
% title(s);

legend('bisection', 'golden', 'fibonacci', 'bisection der',  'Location', 'NorthEast');

ylim([0, 45]);
xlim([0, l(end)]);

filename = 'all';
filename = sprintf('%s_%s', filename, x);
print(filename, '-dpng', '-r300'); % Save as PNG with 300 DPI
cmd = sprintf('convert %s.png -trim %s.png', filename, filename); % trim with convert
system(cmd);

toc
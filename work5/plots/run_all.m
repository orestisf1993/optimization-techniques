% Script that runs all the plots and code needed for the work4 report
%%  ----------------------- Initialization -------------------------------------

close all;
clear all;

%%  ----------------------- Calculate needed values ----------------------------

% calculate needed values for plots
[Xfl,Yfl] = meshgrid(linspace(3,30,20), linspace(-25,-5,20));
[Xgl,Ygl] = meshgrid(linspace(-10,-1,20), linspace(-10,-1,20));
[X,Y] = meshgrid(-2:.2:2, -2:.2:2);
Zf = f(X, Y);
Zg = g(X, Y);
Zfl = f(Xfl, Yfl);
Zgl = g(Xgl, Ygl);
Gnormf = normgradf(X, Y);
Gnormg = normgradg(X, Y);
Gnormfl = normgradf(Xfl, Yfl);
Gnormgl = normgradg(Xgl, Ygl);

%%  ----------------------- Function plots -------------------------------------

mkdir functions
cd functions

% f plots
clf;close all;
fig = figure('visible','off'); % create not visible figure

% mesh plot
mesh(X, Y, Zf);
ylabel('y');
xlabel('x');
title('f mesh plot without limits');
print(fig, 'f_mesh_plot', '-depsc', '-r1200');
% matlab2tikz('000f_mesh_plot.tikz', 'showInfo', false, 'checkForUpdates', false, 'height', '\figureheight', 'width', '\figurewidth');

% mesh plot
hold off;
mesh(Xfl, Yfl, Zfl);
ylabel('y');
xlabel('x');
xlim([3 30]);
ylim([-25 -5]);
title('f mesh plot with limits');
print(fig, 'f_mesh_plot_limited', '-depsc', '-r1200');

hold off;
contour(X, Y, Zf);
ylabel('y');
xlabel('x');
title('f contour plot without limits');
hold on;
colorbar;
print(fig, 'f_contourf_plot', '-depsc', '-r1200');

hold off;
contour(Xfl, Yfl, Zfl);
ylabel('y');
xlabel('x');
xlim([3 30]);
ylim([-25 -5]);
title('f contour plot with limits');
hold on;
colorbar;
print(fig, 'f_contourf_plot_limited', '-depsc', '-r1200');


% gradf plots
% mesh plot
fig = figure('visible','off');
axes1 = axes('Parent',fig);
mesh(X, Y, Gnormf);
ylabel('y', 'interpreter','latex');
xlabel('x', 'interpreter','latex');
title('$\parallel \nabla f \parallel$ without limits','interpreter','latex');
colorbar;
print(fig, 'gradf_mesh_plot', '-depsc', '-r1200');

fig = figure('visible','off');
axes1 = axes('Parent',fig);
mesh(Xfl, Yfl, Gnormfl);
ylabel('y', 'interpreter','latex');
xlabel('x', 'interpreter','latex');
xlim([3 30]);
ylim([-25 -5]);
title('$\parallel \nabla f \parallel$ with limits','interpreter','latex');
colorbar;
print(fig, 'gradf_mesh_plot_limited', '-depsc', '-r1200');

% g plots
clf;close all;
fig = figure('visible','off'); % create not visible figure

% mesh plot
mesh(X, Y, Zg);
ylabel('y');
xlabel('x');
title('g mesh plot without limits');
print(fig, 'g_mesh_plot', '-depsc', '-r1200');

% mesh plot
hold off;
mesh(Xgl, Ygl, Zgl);
ylabel('y');
xlabel('x');
xlim([-10 -1]);
ylim([-10 -1]);
title('g mesh plot with limits');
print(fig, 'g_mesh_plot_limited', '-depsc', '-r1200');

hold off;
contour(X, Y, Zg);
ylabel('y');
xlabel('x');
title('g contour plot without limits');
hold on;
colorbar;
print(fig, 'g_contourf_plot', '-depsc', '-r1200');

hold off;
contour(Xgl, Ygl, Zgl);
ylabel('y');
xlabel('x');
xlim([-10 -1]);
ylim([-10 -1]);
title('g contour plot with limits');
hold on;
colorbar;
print(fig, 'g_contourf_plot_limited', '-depsc', '-r1200');


% gradg plots
% mesh plot
fig = figure('visible','off');
axes1 = axes('Parent',fig);
mesh(X, Y, Gnormg);
ylabel('y', 'interpreter','latex');
xlabel('x', 'interpreter','latex');
title('$\parallel \nabla g \parallel$ without limits','interpreter','latex');
colorbar;
print(fig, 'gradg_mesh_plot', '-depsc', '-r1200');

fig = figure('visible','off');
axes1 = axes('Parent',fig);
mesh(Xgl, Ygl, Gnormgl);
ylabel('y', 'interpreter','latex');
xlabel('x', 'interpreter','latex');
xlim([-10 -1]);
ylim([-10 -1]);
title('$\parallel \nabla g \parallel$ with limits','interpreter','latex');
colorbar;
print(fig, 'gradg_mesh_plot_limited', '-depsc', '-r1200');

cd ..
clf;
close all;
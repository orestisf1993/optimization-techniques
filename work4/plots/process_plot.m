function [] = process_plot(x,title_str, a, b)
%process_plot 

if ~exist('a', 'var')
    a = [-20;-12];
end
if ~exist('b', 'var')
    b = [10;15];
end

% take first points only
% x = x(:,1:min(length(x), 100));

downx = min([a(1)/8 1.1*min(x(1,:))]);
upx = max([b(1)/8 1.1*max(x(1,:))]);
downy = min([a(2)/8 1.1*min(x(2,:))]);
upy = max([b(2)/8 1.1*max(x(2,:))]);
down = min(downx, downy);
down = max(-100, down);
up = max(upx, upy);
up = min(100, up);
[X,Y] = meshgrid(linspace(down,up,50), linspace(down,up,50));
Z = f(X, Y);

contour(X, Y, Z);
hold on;
contour(X, Y, Z, 0.05:0.1:0.45 , 'linecolor', 'k', 'linestyle', ':')
ylabel('y');
xlabel('x');
if exist('title_str', 'var')
    title(title_str);
end
% plot(x(1, :), x(2, :), 'r*');
plot(x(1, :), x(2, :),'--g*',...
    'LineWidth',0.4,...
    'MarkerSize',1,...
    'MarkerEdgeColor','b',...
    'MarkerFaceColor',[0.5,0.5,0.5]);
% plot(x(1, :), x(2, :), 'k');
colorbar;
hold off;

end

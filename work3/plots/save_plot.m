function [] = save_plot(hFig, filename)
%save_plot 
% as taken from http://stackoverflow.com/questions/7561999/how-to-set-the-plot-in-matlab-to-a-specific-size/7576598#7576598

% centimeters units
X = 21.0;                  % A3 paper size
Y = 29.7;                  % A3 paper size
xMargin = 1;               % left/right margins from page borders
yMargin = 1;               % bottom/top margins from page borders
xSize = X - 2*xMargin;     % figure size on paper (widht & hieght)
ySize = Y - 2*yMargin;     % figure size on paper (widht & hieght)

% figure size displayed on screen (50% scaled, but same aspect ratio)
set(hFig, 'Units','centimeters', 'Position',[0 0 xSize ySize]/2)
movegui(hFig, 'center')

% figure size printed on paper
set(hFig, 'PaperUnits','centimeters')
set(hFig, 'PaperSize',[X Y])
set(hFig, 'PaperPosition',[xMargin yMargin xSize ySize])
set(hFig, 'PaperOrientation','portrait')

print(filename, '-dpng', '-r300');

end


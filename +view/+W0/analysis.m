function analysis
load('export/CacheAnalysisW0.mat');

W0LIM		= [1,80];
RLIM		= [1E0,1E13];
MLIM		= [1E0,1E13];
THETALIM	= [0,80];

% styles
C = lib.color.lines(1);
STYLE.core		= {'color',C{1},'LineStyle', '-','DisplayName','core'};
STYLE.plateau	= {'color',C{1},'LineStyle', '-.','DisplayName','plateau'};
STYLE.halo		= {'color',C{1},'LineStyle', '--','DisplayName','halo'};
STYLE.surface	= {'color','k','LineWidth',2,'DisplayName','surface'};


% axes
AX.radius = model.tov.rar.figure.ax_semilogy(...
	'xlabel','$W_0$',...
	'ylabel','$r/r_c$',...
	'axes', {...
		'XLim',		W0LIM, ...
		'YLim',		RLIM,...
		'YTick',	10.^(0:3:12) ...
	}...
);

AX.mass = model.tov.rar.figure.ax_semilogy(...
	'xlabel', '$W_0$',...
	'ylabel', '$M(r)/M_c$',...
	'axes',	{...
		'XLim',		W0LIM, ...
		'YLim',		MLIM,...
		'YTick',	10.^(0:3:12) ...
	}...
);

AX.degeneracy = model.tov.rar.figure.ax(...
	'xlabel','$W_0$',...
	'ylabel','$\theta_0 - \theta(r)$',...
	'axes',{...
		'XLim',		W0LIM, ...
		'YLim',		THETALIM,...
		'YTick',	0:10:70 ...
	}...
);

% figure
ax = [AX.degeneracy;AX.mass;AX.radius];
fh = module.sapthesis.figure_grid(ax,'axHeight',6,'figure',{'FileName','analysis'});
figure(fh);

% radius
axes(AX.radius);
% h(4) = lib.view.plot.table2D(T,@(t) t.W0, @(t) t.rc/t.rc,STYLE.core{:});
h(3) = lib.view.plot.table2D(T,@(t) t.W0, @(t) t.rp/t.rc,STYLE.plateau{:});
h(2) = lib.view.plot.table2D(T,@(t) t.W0, @(t) t.rh/t.rc,STYLE.halo{:});
h(1) = lib.view.plot.table2D(T,@(t) t.W0, @(t) t.rs/t.rc,STYLE.surface{:});
lib.view.plot.legend(h,'Location','northwest');

% mass
axes(AX.mass);
% h(4) = lib.view.plot.table2D(T,@(t) t.W0, @(t) t.Mc/t.Mc,STYLE.core{:});
h(3) = lib.view.plot.table2D(T,@(t) t.W0, @(t) t.Mp/t.Mc,STYLE.plateau{:});
h(2) = lib.view.plot.table2D(T,@(t) t.W0, @(t) t.Mh/t.Mc,STYLE.halo{:});
h(1) = lib.view.plot.table2D(T,@(t) t.W0, @(t) t.Ms/t.Mc,STYLE.surface{:});
lib.view.plot.legend(h,'Location','northwest');

% degeneracy
axes(AX.degeneracy);
h(4) = lib.view.plot.table2D(T,@(t) t.W0, @(t) t.THETA0 - t.THETAc,STYLE.core{:});
h(3) = lib.view.plot.table2D(T,@(t) t.W0, @(t) t.THETA0 - t.THETAp,STYLE.plateau{:});
h(2) = lib.view.plot.table2D(T,@(t) t.W0, @(t) t.THETA0 - t.THETAh,STYLE.halo{:});
h(1) = lib.view.plot.table2D(T,@(t) t.W0, @(t) t.THETA0 - t.THETAs,STYLE.surface{:});
lib.view.plot.legend(h,'Location','northwest');

% save
lib.view.file.figure(fh,'export/W0');
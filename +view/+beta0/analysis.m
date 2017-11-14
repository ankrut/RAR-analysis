function analysis
T = load('export/CacheAnalysisBeta0.mat');

BETA0LIM	= [1E-6,1E2];
RLIM		= [1E0,1E10];
MLIM		= [1E0,1E9];
DTHETALIM	= [-5,55];

BETA0TICK	= 10.^(-5:2:1);

% styles
C = lib.color.lines(1);
STYLE.core		= {'color',C{1},'LineStyle', '-','DisplayName','core'};
STYLE.plateau	= {'color',C{1},'LineStyle', '-.','DisplayName','plateau'};
STYLE.halo		= {'color',C{1},'LineStyle', '--','DisplayName','halo'};
STYLE.surface	= {'color','k','LineWidth',2,'DisplayName','surface'};

% axes model
AXMODEL.radius = {...
	'xlabel','$\beta_0$',...
	'ylabel','$r/r_c$',...
	'axes', {...
		'XLim',		BETA0LIM, ...
		'YLim',		RLIM,...
		'XTick',	BETA0TICK,...
		'YTick',	10.^(0:2:10) ...
	}...
};

AXMODEL.mass = {...
	'xlabel', '$\beta_0$',...
	'ylabel', '$M(r)/M_c$',...
	'axes',	{...
		'XLim',		BETA0LIM, ...
		'YLim',		MLIM,...
		'XTick',	BETA0TICK,...
		'YTick',	10.^(0:2:8) ...
	}...
};

AXMODEL.degeneracy = {...
	'xlabel','$\beta_0$',...
	'ylabel','$\theta_0 - \theta(r)$',...
	'axes',{...
		'XLim',		BETA0LIM, ...
		'YLim',		DTHETALIM,...
		'XTick',	BETA0TICK,...
		'YTick',	0:10:50 ...
	}...
};

% create axes grid
for ii=1:3
	ax(:,ii) = [
		model.tov.rar.figure.ax_semilogx(AXMODEL.degeneracy{:})
		model.tov.rar.figure.ax_loglog(AXMODEL.mass{:})
		model.tov.rar.figure.ax_loglog(AXMODEL.radius{:})
	];
end

% figure
fh = module.sapthesis.figure_grid(ax,'axHeight','equal','figure',{'FileName','analysis'});
figure(fh);

% radius
axes(ax(3,1));
title('weak')
h(3) = lib.view.plot.table2D(T.weak,@(t) t.beta0, @(t) t.rp/t.rc,STYLE.plateau{:});
h(2) = lib.view.plot.table2D(T.weak,@(t) t.beta0, @(t) t.rh/t.rc,STYLE.halo{:});
h(1) = lib.view.plot.table2D(T.weak,@(t) t.beta0, @(t) t.rs/t.rc,STYLE.surface{:});
% lib.view.plot.legend(h,'Location','northwest');

% mass
axes(ax(2,1));
h(3) = lib.view.plot.table2D(T.weak,@(t) t.beta0, @(t) t.Mp/t.Mc,STYLE.plateau{:});
h(2) = lib.view.plot.table2D(T.weak,@(t) t.beta0, @(t) t.Mh/t.Mc,STYLE.halo{:});
h(1) = lib.view.plot.table2D(T.weak,@(t) t.beta0, @(t) t.Ms/t.Mc,STYLE.surface{:});
% lib.view.plot.legend(h,'Location','northwest');

% degeneracy
axes(ax(1,1));
h(4) = lib.view.plot.table2D(T.weak,@(t) t.beta0, @(t) t.THETA0 - t.THETAc,STYLE.core{:});
h(3) = lib.view.plot.table2D(T.weak,@(t) t.beta0, @(t) t.THETA0 - t.THETAp,STYLE.plateau{:});
h(2) = lib.view.plot.table2D(T.weak,@(t) t.beta0, @(t) t.THETA0 - t.THETAh,STYLE.halo{:});
h(1) = lib.view.plot.table2D(T.weak,@(t) t.beta0, @(t) t.THETA0 - t.THETAs,STYLE.surface{:});
% lib.view.plot.legend(h,'Location','southwest');




% radius
axes(ax(3,2));
title('intermediate')
h(3) = lib.view.plot.table2D(T.inter,@(t) t.beta0, @(t) t.rp/t.rc,STYLE.plateau{:});
h(2) = lib.view.plot.table2D(T.inter,@(t) t.beta0, @(t) t.rh/t.rc,STYLE.halo{:});
h(1) = lib.view.plot.table2D(T.inter,@(t) t.beta0, @(t) t.rs/t.rc,STYLE.surface{:});
% lib.view.plot.legend(h,'Location','northwest');

% mass
axes(ax(2,2));
h(3) = lib.view.plot.table2D(T.inter,@(t) t.beta0, @(t) t.Mp/t.Mc,STYLE.plateau{:});
h(2) = lib.view.plot.table2D(T.inter,@(t) t.beta0, @(t) t.Mh/t.Mc,STYLE.halo{:});
h(1) = lib.view.plot.table2D(T.inter,@(t) t.beta0, @(t) t.Ms/t.Mc,STYLE.surface{:});
% lib.view.plot.legend(h,'Location','northwest');

% degeneracy
axes(ax(1,2));
h(4) = lib.view.plot.table2D(T.inter,@(t) t.beta0, @(t) t.THETA0 - t.THETAc,STYLE.core{:});
h(3) = lib.view.plot.table2D(T.inter,@(t) t.beta0, @(t) t.THETA0 - t.THETAp,STYLE.plateau{:});
h(2) = lib.view.plot.table2D(T.inter,@(t) t.beta0, @(t) t.THETA0 - t.THETAh,STYLE.halo{:});
h(1) = lib.view.plot.table2D(T.inter,@(t) t.beta0, @(t) t.THETA0 - t.THETAs,STYLE.surface{:});
% lib.view.plot.legend(h,'Location','southwest');




% radius
axes(ax(3,3));
title('strong')
h(3) = lib.view.plot.table2D(T.strong,@(t) t.beta0, @(t) t.rp/t.rc,STYLE.plateau{:});
h(2) = lib.view.plot.table2D(T.strong,@(t) t.beta0, @(t) t.rh/t.rc,STYLE.halo{:});
h(1) = lib.view.plot.table2D(T.strong,@(t) t.beta0, @(t) t.rs/t.rc,STYLE.surface{:});
% lib.view.plot.legend(h,'Location','northwest');

% mass
axes(ax(2,3));
h(3) = lib.view.plot.table2D(T.strong,@(t) t.beta0, @(t) t.Mp/t.Mc,STYLE.plateau{:});
h(2) = lib.view.plot.table2D(T.strong,@(t) t.beta0, @(t) t.Mh/t.Mc,STYLE.halo{:});
h(1) = lib.view.plot.table2D(T.strong,@(t) t.beta0, @(t) t.Ms/t.Mc,STYLE.surface{:});
% lib.view.plot.legend(h,'Location','northwest');

% degeneracy
axes(ax(1,3));
h(4) = lib.view.plot.table2D(T.strong,@(t) t.beta0, @(t) t.THETA0 - t.THETAc,STYLE.core{:});
h(3) = lib.view.plot.table2D(T.strong,@(t) t.beta0, @(t) t.THETA0 - t.THETAp,STYLE.plateau{:});
h(2) = lib.view.plot.table2D(T.strong,@(t) t.beta0, @(t) t.THETA0 - t.THETAh,STYLE.halo{:});
h(1) = lib.view.plot.table2D(T.strong,@(t) t.beta0, @(t) t.THETA0 - t.THETAs,STYLE.surface{:});
lib.view.plot.legend(h,'Location','northeast');

% save
lib.view.file.figure(fh,'export/beta0');
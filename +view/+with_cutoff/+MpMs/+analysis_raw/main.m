function main
T		= load('export/CacheWithCutoffAnalysisMpMs.mat');
STYLE	= lib.require(@configs.style_analysis);
fh		= view.with_cutoff.MpMs.analysis_raw.figure();

ax.radius		= fh.UserData.axes(3,1);
ax.mass			= fh.UserData.axes(2,1);
ax.degeneracy	= fh.UserData.axes(1,1);
ax.W0			= fh.UserData.axes(3,2);
ax.beta0		= fh.UserData.axes(2,2);
ax.rho0			= fh.UserData.axes(1,2);

figure(fh);

% THIN (low density)

% radius
axes(ax.radius(1));
lib.view.plot.table2D(T.cuspy,@(t) t.theta0, @(t) t.rc,STYLE.core{:});
lib.view.plot.table2D(T.cuspy,@(t) t.theta0, @(t) t.rp,STYLE.plateau{:});
lib.view.plot.table2D(T.cuspy,@(t) t.theta0, @(t) t.rh,STYLE.halo{:});
lib.view.plot.table2D(T.cuspy,@(t) t.theta0, @(t) t.rs,STYLE.surface{:});


% mass
axes(ax.mass(1));
lib.view.plot.table2D(T.cuspy,@(t) t.theta0, @(t) t.Mc,STYLE.core{:});
lib.view.plot.table2D(T.cuspy,@(t) t.theta0, @(t) t.Mp,STYLE.plateau{:});
lib.view.plot.table2D(T.cuspy,@(t) t.theta0, @(t) t.Mh,STYLE.halo{:});
lib.view.plot.table2D(T.cuspy,@(t) t.theta0, @(t) t.Ms,STYLE.surface{:});

% degeneracy
axes(ax.degeneracy(1));
lib.view.plot.table2D(T.cuspy,@(t) t.theta0, @(t) t.THETA0 - t.THETAc,STYLE.core{:});
lib.view.plot.table2D(T.cuspy,@(t) t.theta0, @(t) t.THETA0 - t.THETAp,STYLE.plateau{:});
lib.view.plot.table2D(T.cuspy,@(t) t.theta0, @(t) t.THETA0 - t.THETAh,STYLE.halo{:});
h(5) = lib.view.plot.table2D(T.cuspy,@(t) t.theta0, @(t) t.THETA0 - t.THETAs,STYLE.surface{:});

% density
axes(ax.rho0);
lib.view.plot.table2D(T.cuspy,@(t) t.theta0, @(t) t.rho0,STYLE.center{:});
h(2) = lib.view.plot.table2D(T.cuspy,@(t) t.theta0, @(t) t.rhoc,STYLE.core{:});
h(3) = lib.view.plot.table2D(T.cuspy,@(t) t.theta0, @(t) t.rhop,STYLE.plateau{:});
h(4) = lib.view.plot.table2D(T.cuspy,@(t) t.theta0, @(t) t.rhoh,STYLE.halo{:});

% beta0
axes(ax.beta0);
lib.view.plot.table2D(T.cuspy,@(t) t.theta0, @(t) t.beta0,STYLE.center{:});


% W0
axes(ax.W0);
h(1) = lib.view.plot.table2D(T.cuspy,@(t) t.theta0, @(t) t.W0,STYLE.center{:});


% legend
axes(ax.degeneracy(1));
lib.view.plot.legend(h,'Location','northwest');


% save
lib.view.latex.figure(...
	'path',		'export/with-cutoff/MpMs-analysis-raw/',...
	'figure',	fh,...
	'label',	'fig:analysis:with-cutoff:MpMs:raw',...
	'caption',	fileread('+view/+with_cutoff/+MpMs/+analysis_raw/caption.txt') ...
);
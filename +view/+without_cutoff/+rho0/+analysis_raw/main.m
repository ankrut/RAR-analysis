function main
T		= load('export/CacheWithoutCutoffAnalysisRho0.mat');
STYLE	= lib.require(@configs.style_analysis);
fh		= view.without_cutoff.rho0.analysis_raw.figure();

ax.radius		= fh.UserData.axes(3,:);
ax.mass			= fh.UserData.axes(2,:);
ax.degeneracy	= fh.UserData.axes(1,:);
ax.beta0		= fh.UserData.axes(2,2);
ax.rho0			= fh.UserData.axes(1,2);

figure(fh);

% THIN (low density)

% radius
axes(ax.radius(1)); clear h;
h(2) = lib.view.plot.table2D(T.thin,@(t) t.theta0, @(t) t.rc,STYLE.core{:});
h(2) = lib.view.plot.table2D(T.thin,@(t) t.theta0, @(t) t.rp,STYLE.plateau{:});
h(1) = lib.view.plot.table2D(T.thin,@(t) t.theta0, @(t) t.rh,STYLE.halo{:});
% title('low temperature');

% mass
axes(ax.mass(1)); clear h;
h(2) = lib.view.plot.table2D(T.thin,@(t) t.theta0, @(t) t.Mc,STYLE.core{:});
h(2) = lib.view.plot.table2D(T.thin,@(t) t.theta0, @(t) t.Mp,STYLE.plateau{:});
h(1) = lib.view.plot.table2D(T.thin,@(t) t.theta0, @(t) t.Mh,STYLE.halo{:});

% degeneracy
axes(ax.degeneracy(1)); clear h;
h(3) = lib.view.plot.table2D(T.thin,@(t) t.theta0, @(t) t.THETA0 - t.THETAc,STYLE.core{:});
h(2) = lib.view.plot.table2D(T.thin,@(t) t.theta0, @(t) t.THETA0 - t.THETAp,STYLE.plateau{:});
h(1) = lib.view.plot.table2D(T.thin,@(t) t.theta0, @(t) t.THETA0 - t.THETAh,STYLE.halo{:});


% radius
axes(ax.radius(1)); clear h;
h(3) = lib.view.plot.table2D(T.thin,@(t) t.theta0, @(t) t.rc,STYLE.core{:});
h(2) = lib.view.plot.table2D(T.thin,@(t) t.theta0, @(t) t.rp,STYLE.plateau{:});
h(1) = lib.view.plot.table2D(T.thin,@(t) t.theta0, @(t) t.rh,STYLE.halo{:});
% title('low temperature');

% mass
axes(ax.mass(1)); clear h;
h(3) = lib.view.plot.table2D(T.thin,@(t) t.theta0, @(t) t.Mc,STYLE.core{:});
h(2) = lib.view.plot.table2D(T.thin,@(t) t.theta0, @(t) t.Mp,STYLE.plateau{:});
h(1) = lib.view.plot.table2D(T.thin,@(t) t.theta0, @(t) t.Mh,STYLE.halo{:});

% degeneracy
axes(ax.degeneracy(1)); clear h;
h(3) = lib.view.plot.table2D(T.thin,@(t) t.theta0, @(t) t.THETA0 - t.THETAc,STYLE.core{:});
h(2) = lib.view.plot.table2D(T.thin,@(t) t.theta0, @(t) t.THETA0 - t.THETAp,STYLE.plateau{:});
h(1) = lib.view.plot.table2D(T.thin,@(t) t.theta0, @(t) t.THETA0 - t.THETAh,STYLE.halo{:});


% density
axes(ax.rho0); clear h;
h(1) = lib.view.plot.table2D(T.thin,@(t) t.theta0, @(t) t.rho0,STYLE.center{:});
h(2) = lib.view.plot.table2D(T.thin,@(t) t.theta0, @(t) t.rhoc,STYLE.core{:});
h(3) = lib.view.plot.table2D(T.thin,@(t) t.theta0, @(t) t.rhop,STYLE.plateau{:});
h(4) = lib.view.plot.table2D(T.thin,@(t) t.theta0, @(t) t.rhoh,STYLE.halo{:});

% beta0
axes(ax.beta0);
lib.view.plot.table2D(T.thin,@(t) t.theta0, @(t) t.beta0,STYLE.center{:});

% legend
axes(ax.degeneracy(1));
lib.view.plot.legend(h,'Location','east');

% save
lib.view.latex.figure(...
	'path',		'export/without-cutoff/rho0-analysis-raw/',...
	'figure',	fh,...
	'label',	'fig:analysis:without-cutoff:central-density:raw',...
	'caption',	fileread('+view/+without_cutoff/+rho0/+analysis_raw/caption.txt') ...
);
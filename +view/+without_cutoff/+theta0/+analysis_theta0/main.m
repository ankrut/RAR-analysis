function main
T		= load('export/CacheAnalysisTheta0Low.mat');
STYLE	= lib.require(@configs.style_analysis);
fh		= view.without_cutoff.theta0.analysis_theta0.figure();

ax.radius		= fh.UserData.axes(3,:);
ax.mass			= fh.UserData.axes(2,:);
ax.degeneracy	= fh.UserData.axes(1,:);

figure(fh);

% LOW TEMPERATURE

% radius
axes(ax.radius(1)); clear h;
h(2) = lib.view.plot.table2D(T.low,@(t) t.theta0, @(t) t.rp/t.rc,STYLE.plateau{:});
h(1) = lib.view.plot.table2D(T.low,@(t) t.theta0, @(t) t.rh/t.rc,STYLE.halo{:});
% lib.view.plot.legend(h,'Location','northwest');
title('cold');

% mass
axes(ax.mass(1)); clear h;
h(2) = lib.view.plot.table2D(T.low,@(t) t.theta0, @(t) t.Mp/t.Mc,STYLE.plateau{:});
h(1) = lib.view.plot.table2D(T.low,@(t) t.theta0, @(t) t.Mh/t.Mc,STYLE.halo{:});
% lib.view.plot.legend(h,'Location','northwest');

% degeneracy
axes(ax.degeneracy(1)); clear h;
h(3) = lib.view.plot.table2D(T.low,@(t) t.theta0, @(t) t.THETA0 - t.THETAc,STYLE.core{:});
h(2) = lib.view.plot.table2D(T.low,@(t) t.theta0, @(t) t.THETA0 - t.THETAp,STYLE.plateau{:});
h(1) = lib.view.plot.table2D(T.low,@(t) t.theta0, @(t) t.THETA0 - t.THETAh,STYLE.halo{:});
lib.view.plot.legend(h,'Location','northwest');

% TRANSITION

% radius
axes(ax.radius(2)); clear h;
h(2) = lib.view.plot.table2D(T.trans,@(t) t.theta0, @(t) t.rp/t.rc,STYLE.plateau{:});
h(1) = lib.view.plot.table2D(T.trans,@(t) t.theta0, @(t) t.rh/t.rc,STYLE.halo{:});
% lib.view.plot.legend(h,'Location','northwest');
title('moderate');

% mass
axes(ax.mass(2)); clear h;
h(2) = lib.view.plot.table2D(T.trans,@(t) t.theta0, @(t) t.Mp/t.Mc,STYLE.plateau{:});
h(1) = lib.view.plot.table2D(T.trans,@(t) t.theta0, @(t) t.Mh/t.Mc,STYLE.halo{:});
% lib.view.plot.legend(h,'Location','northwest');

% degeneracy
axes(ax.degeneracy(2)); clear h;
h(3) = lib.view.plot.table2D(T.trans,@(t) t.theta0, @(t) t.THETA0 - t.THETAc,STYLE.core{:});
h(2) = lib.view.plot.table2D(T.trans,@(t) t.theta0, @(t) t.THETA0 - t.THETAp,STYLE.plateau{:});
h(1) = lib.view.plot.table2D(T.trans,@(t) t.theta0, @(t) t.THETA0 - t.THETAh,STYLE.halo{:});
% lib.view.plot.legend(h,'Location','northwest');


% HIGH TEMPERATURE

% radius
axes(ax.radius(3)); clear h;
h(2) = lib.view.plot.table2D(T.high,@(t) t.theta0, @(t) t.rp/t.rc,STYLE.plateau{:});
h(1) = lib.view.plot.table2D(T.high,@(t) t.theta0, @(t) t.rh/t.rc,STYLE.halo{:});
% lib.view.plot.legend(h,'Location','northwest');
title('hot');

% mass
axes(ax.mass(3)); clear h;
h(2) = lib.view.plot.table2D(T.high,@(t) t.theta0, @(t) t.Mp/t.Mc,STYLE.plateau{:});
h(1) = lib.view.plot.table2D(T.high,@(t) t.theta0, @(t) t.Mh/t.Mc,STYLE.halo{:});
% lib.view.plot.legend(h,'Location','northwest');

% degeneracy
axes(ax.degeneracy(3)); clear h;
h(3) = lib.view.plot.table2D(T.high,@(t) t.theta0, @(t) t.THETA0 - t.THETAc,STYLE.core{:});
h(2) = lib.view.plot.table2D(T.high,@(t) t.theta0, @(t) t.THETA0 - t.THETAp,STYLE.plateau{:});
h(1) = lib.view.plot.table2D(T.high,@(t) t.theta0, @(t) t.THETA0 - t.THETAh,STYLE.halo{:});
% lib.view.plot.legend(h,'Location','northwest');

% save
lib.view.latex.figure(...
	'path',		'export/without-cutoff/theta0-analysis/',...
	'figure',	fh,...
	'label',	'fig:analysis:without-cutoff:central-degeneracy',...
	'caption',	fileread('+view/+without_cutoff/+theta0/+analysis_theta0/caption.txt') ...
);
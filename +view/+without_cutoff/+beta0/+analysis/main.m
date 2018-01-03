function main
T		= load('export/CacheWithoutCutoffAnalysisBeta0.mat');
STYLE	= lib.require(@configs.style_analysis);
fh		= view.without_cutoff.beta0.analysis.figure();

ax.radius		= fh.UserData.axes(3,:);
ax.mass			= fh.UserData.axes(2,:);
ax.degeneracy	= fh.UserData.axes(1,:);

figure(fh);

% DILUTED

% radius
axes(ax.radius(1)); clear h;
h(2) = lib.view.plot.table2D(T.diluted,@(t) t.beta0, @(t) t.rp/t.rc,STYLE.plateau{:});
h(1) = lib.view.plot.table2D(T.diluted,@(t) t.beta0, @(t) t.rh/t.rc,STYLE.halo{:});
lib.view.plot.legend(h,'Location','northwest');
title('diluted');

% mass
axes(ax.mass(1)); clear h;
h(2) = lib.view.plot.table2D(T.diluted,@(t) t.beta0, @(t) t.Mp/t.Mc,STYLE.plateau{:});
h(1) = lib.view.plot.table2D(T.diluted,@(t) t.beta0, @(t) t.Mh/t.Mc,STYLE.halo{:});
lib.view.plot.legend(h,'Location','northwest');

% degeneracy
axes(ax.degeneracy(1)); clear h;
h(3) = lib.view.plot.table2D(T.diluted,@(t) t.beta0, @(t) t.THETA0 - t.THETAc,STYLE.core{:});
h(2) = lib.view.plot.table2D(T.diluted,@(t) t.beta0, @(t) t.THETA0 - t.THETAp,STYLE.plateau{:});
h(1) = lib.view.plot.table2D(T.diluted,@(t) t.beta0, @(t) t.THETA0 - t.THETAh,STYLE.halo{:});
lib.view.plot.legend(h,'Location','northwest');


% TRANSITION

% radius
axes(ax.radius(2)); clear h;
h(2) = lib.view.plot.table2D(T.trans,@(t) t.beta0, @(t) t.rp/t.rc,STYLE.plateau{:});
h(1) = lib.view.plot.table2D(T.trans,@(t) t.beta0, @(t) t.rh/t.rc,STYLE.halo{:});
% lib.view.plot.legend(h,'Location','northwest');
title('transition');

% mass
axes(ax.mass(2)); clear h;
h(2) = lib.view.plot.table2D(T.trans,@(t) t.beta0, @(t) t.Mp/t.Mc,STYLE.plateau{:});
h(1) = lib.view.plot.table2D(T.trans,@(t) t.beta0, @(t) t.Mh/t.Mc,STYLE.halo{:});
% lib.view.plot.legend(h,'Location','northwest');

% degeneracy
axes(ax.degeneracy(2)); clear h;
h(3) = lib.view.plot.table2D(T.trans,@(t) t.beta0, @(t) t.THETA0 - t.THETAc,STYLE.core{:});
h(2) = lib.view.plot.table2D(T.trans,@(t) t.beta0, @(t) t.THETA0 - t.THETAp,STYLE.plateau{:});
h(1) = lib.view.plot.table2D(T.trans,@(t) t.beta0, @(t) t.THETA0 - t.THETAh,STYLE.halo{:});
% lib.view.plot.legend(h,'Location','northwest');


% DEGENERATE

% radius
axes(ax.radius(3)); clear h;
h(2) = lib.view.plot.table2D(T.degenerate,@(t) t.beta0, @(t) t.rp/t.rc,STYLE.plateau{:});
h(1) = lib.view.plot.table2D(T.degenerate,@(t) t.beta0, @(t) t.rh/t.rc,STYLE.halo{:});
% lib.view.plot.legend(h,'Location','northwest');
title('degenerate');

% mass
axes(ax.mass(3)); clear h;
h(2) = lib.view.plot.table2D(T.degenerate,@(t) t.beta0, @(t) t.Mp/t.Mc,STYLE.plateau{:});
h(1) = lib.view.plot.table2D(T.degenerate,@(t) t.beta0, @(t) t.Mh/t.Mc,STYLE.halo{:});
% lib.view.plot.legend(h,'Location','northwest');

% degeneracy
axes(ax.degeneracy(3)); clear h;
h(3) = lib.view.plot.table2D(T.degenerate,@(t) t.beta0, @(t) t.THETA0 - t.THETAc,STYLE.core{:});
h(2) = lib.view.plot.table2D(T.degenerate,@(t) t.beta0, @(t) t.THETA0 - t.THETAp,STYLE.plateau{:});
h(1) = lib.view.plot.table2D(T.degenerate,@(t) t.beta0, @(t) t.THETA0 - t.THETAh,STYLE.halo{:});
% lib.view.plot.legend(h,'Location','northwest');

% save
lib.view.latex.figure(...
	'path',		'export/without-cutoff/beta0-analysis/',...
	'figure',	fh,...
	'label',	'fig:analysis:without-cutoff:central-temperature',...
	'caption',	fileread('+view/+without_cutoff/+beta0/+analysis/caption.txt') ...
);
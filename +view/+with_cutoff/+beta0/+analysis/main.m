function main
T		= load('export/CacheAnalysisBeta0.mat');
STYLE	= lib.require(@configs.style_analysis);
fh		= view.with_cutoff.beta0.analysis.figure();

ax.density		= fh.UserData.axes(3,:);
ax.mass			= fh.UserData.axes(2,:);
ax.degeneracy	= fh.UserData.axes(1,:);

% show figure
figure(fh);

% radius
axes(ax.density(1));
title('weak')
h(3) = lib.view.plot.table2D(T.weak,@(t) t.beta0, @(t) t.rp/t.rc,STYLE.plateau{:});
h(2) = lib.view.plot.table2D(T.weak,@(t) t.beta0, @(t) t.rh/t.rc,STYLE.halo{:});
h(1) = lib.view.plot.table2D(T.weak,@(t) t.beta0, @(t) t.rs/t.rc,STYLE.surface{:});

% mass
axes(ax.mass(1));
h(3) = lib.view.plot.table2D(T.weak,@(t) t.beta0, @(t) t.Mp/t.Mc,STYLE.plateau{:});
h(2) = lib.view.plot.table2D(T.weak,@(t) t.beta0, @(t) t.Mh/t.Mc,STYLE.halo{:});
h(1) = lib.view.plot.table2D(T.weak,@(t) t.beta0, @(t) t.Ms/t.Mc,STYLE.surface{:});

% degeneracy
axes(ax.degeneracy(1));
h(4) = lib.view.plot.table2D(T.weak,@(t) t.beta0, @(t) t.THETA0 - t.THETAc,STYLE.core{:});
h(3) = lib.view.plot.table2D(T.weak,@(t) t.beta0, @(t) t.THETA0 - t.THETAp,STYLE.plateau{:});
h(2) = lib.view.plot.table2D(T.weak,@(t) t.beta0, @(t) t.THETA0 - t.THETAh,STYLE.halo{:});
h(1) = lib.view.plot.table2D(T.weak,@(t) t.beta0, @(t) t.THETA0 - t.THETAs,STYLE.surface{:});




% radius
axes(ax.density(2));
title('intermediate')
h(3) = lib.view.plot.table2D(T.inter,@(t) t.beta0, @(t) t.rp/t.rc,STYLE.plateau{:});
h(2) = lib.view.plot.table2D(T.inter,@(t) t.beta0, @(t) t.rh/t.rc,STYLE.halo{:});
h(1) = lib.view.plot.table2D(T.inter,@(t) t.beta0, @(t) t.rs/t.rc,STYLE.surface{:});

% mass
axes(ax.mass(2));
h(3) = lib.view.plot.table2D(T.inter,@(t) t.beta0, @(t) t.Mp/t.Mc,STYLE.plateau{:});
h(2) = lib.view.plot.table2D(T.inter,@(t) t.beta0, @(t) t.Mh/t.Mc,STYLE.halo{:});
h(1) = lib.view.plot.table2D(T.inter,@(t) t.beta0, @(t) t.Ms/t.Mc,STYLE.surface{:});

% degeneracy
axes(ax.degeneracy(2));
h(4) = lib.view.plot.table2D(T.inter,@(t) t.beta0, @(t) t.THETA0 - t.THETAc,STYLE.core{:});
h(3) = lib.view.plot.table2D(T.inter,@(t) t.beta0, @(t) t.THETA0 - t.THETAp,STYLE.plateau{:});
h(2) = lib.view.plot.table2D(T.inter,@(t) t.beta0, @(t) t.THETA0 - t.THETAh,STYLE.halo{:});
h(1) = lib.view.plot.table2D(T.inter,@(t) t.beta0, @(t) t.THETA0 - t.THETAs,STYLE.surface{:});




% radius
axes(ax.density(3));
title('strong')
h(3) = lib.view.plot.table2D(T.strong,@(t) t.beta0, @(t) t.rp/t.rc,STYLE.plateau{:});
h(2) = lib.view.plot.table2D(T.strong,@(t) t.beta0, @(t) t.rh/t.rc,STYLE.halo{:});
h(1) = lib.view.plot.table2D(T.strong,@(t) t.beta0, @(t) t.rs/t.rc,STYLE.surface{:});

% mass
axes(ax.mass(3));
h(3) = lib.view.plot.table2D(T.strong,@(t) t.beta0, @(t) t.Mp/t.Mc,STYLE.plateau{:});
h(2) = lib.view.plot.table2D(T.strong,@(t) t.beta0, @(t) t.Mh/t.Mc,STYLE.halo{:});
h(1) = lib.view.plot.table2D(T.strong,@(t) t.beta0, @(t) t.Ms/t.Mc,STYLE.surface{:});

% degeneracy
axes(ax.degeneracy(3));
h(4) = lib.view.plot.table2D(T.strong,@(t) t.beta0, @(t) t.THETA0 - t.THETAc,STYLE.core{:});
h(3) = lib.view.plot.table2D(T.strong,@(t) t.beta0, @(t) t.THETA0 - t.THETAp,STYLE.plateau{:});
h(2) = lib.view.plot.table2D(T.strong,@(t) t.beta0, @(t) t.THETA0 - t.THETAh,STYLE.halo{:});
h(1) = lib.view.plot.table2D(T.strong,@(t) t.beta0, @(t) t.THETA0 - t.THETAs,STYLE.surface{:});
lib.view.plot.legend(h,'Location','northeast');

% save
lib.view.file.figure(fh,'export/beta0');
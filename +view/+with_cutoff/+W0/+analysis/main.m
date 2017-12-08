function main
load('export/CacheAnalysisW0.mat');
STYLE	= lib.require(@configs.style_analysis);
fh		= view.W0.analysis.figure();

% show figure
figure(fh);

% radius
axes(fh.UserData.axes(3));
h(3) = lib.view.plot.table2D(T,@(t) t.W0, @(t) t.rp/t.rc,STYLE.plateau{:});
h(2) = lib.view.plot.table2D(T,@(t) t.W0, @(t) t.rh/t.rc,STYLE.halo{:});
h(1) = lib.view.plot.table2D(T,@(t) t.W0, @(t) t.rs/t.rc,STYLE.surface{:});

% mass
axes(fh.UserData.axes(2));
h(3) = lib.view.plot.table2D(T,@(t) t.W0, @(t) t.Mp/t.Mc,STYLE.plateau{:});
h(2) = lib.view.plot.table2D(T,@(t) t.W0, @(t) t.Mh/t.Mc,STYLE.halo{:});
h(1) = lib.view.plot.table2D(T,@(t) t.W0, @(t) t.Ms/t.Mc,STYLE.surface{:});

% degeneracy
axes(fh.UserData.axes(1));
h(4) = lib.view.plot.table2D(T,@(t) t.W0, @(t) t.THETA0 - t.THETAc,STYLE.core{:});
h(3) = lib.view.plot.table2D(T,@(t) t.W0, @(t) t.THETA0 - t.THETAp,STYLE.plateau{:});
h(2) = lib.view.plot.table2D(T,@(t) t.W0, @(t) t.THETA0 - t.THETAh,STYLE.halo{:});
h(1) = lib.view.plot.table2D(T,@(t) t.W0, @(t) t.THETA0 - t.THETAs,STYLE.surface{:});
lib.view.plot.legend(h,'Location','northwest');

% save
lib.view.file.figure(fh,'export/W0');
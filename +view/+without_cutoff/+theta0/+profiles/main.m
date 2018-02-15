function main
P			= load('export/CacheProfileTheta0Low.mat');
STYLE		= lib.require(@configs.style_profiles);
ANCH		= lib.require(@lib.model.tov.rar.anchor);
SCALE		= lib.require(@lib.model.tov.rar.scale);
AXIS.raw	= lib.require(@lib.model.tov.rar.axes.raw);
AXIS.center	= lib.require(@lib.model.tov.rar.axes.center);
AXIS.core	= lib.require(@lib.model.tov.rar.axes.core);
AXIS.plat	= lib.require(@lib.model.tov.rar.axes.plateau);
AXIS.halo	= lib.require(@lib.model.tov.rar.axes.halo);
fh			= view.without_cutoff.theta0.profiles.figure();

% define fully degenerate core and pointlike vacuum solution
opts = struct('xmax', 1E20, 'tau', 1E-16, 'rtau', 1E-8);
pFDG = lib.model.tov.core.profile('fermi_energy', 1 + 1E-6*50).calc(opts);
pFDG.data.density(end) = realmin;

pPL = lib.model.elementary.pointlike.profile(ANCH.surface.map(pFDG,AXIS.raw.mass));
pPL.set('radius',logspace(log10(pFDG.data.radius(end)),log10(pFDG.data.radius(end)) + 10));

% set axis for pointlike solution (core focus)
MAP.pl = lib.require(@lib.model.tov.pointlike.map);
AXIS.pointlike.core.radius		= lib.module.ProfileAxis('map', MAP.pl.radius,		'scale', @(obj) SCALE.core.radius.map(pFDG));
AXIS.pointlike.core.velocity	= lib.module.ProfileAxis('map', MAP.pl.velocity,	'scale', @(obj) SCALE.core.velocity.map(pFDG));
AXIS.pointlike.core.mass		= lib.module.ProfileAxis('map', MAP.pl.mass,		'scale', @(obj) SCALE.core.mass.map(pFDG));

% show figure
figure(fh);

% density
axes(fh.UserData.axes(4,1));
hg.fgdgroup = hggroup(STYLE.fdggroup{:});
vline(1,ANCH.velocity_core.map(pFDG,AXIS.center.density),'Parent',hg.fgdgroup);

lib.view.plot.curve2D(...
	'data', pFDG,...
	'x',	AXIS.core.radius,...
	'y',	AXIS.center.density,...
	'plot', [STYLE.fdg,{'Parent',hg.fgdgroup}]...
);

hg.cored = hggroup(STYLE.fdgroup{:});
P.cored.forEach(@(p) lib.view.plot.curve2D(...
	'data', p,...
	'x',	AXIS.core.radius,...
	'y',	AXIS.center.density,...
	'plot',	[STYLE.fd,{'Parent',hg.cored}] ...
));

% velocity
axes(fh.UserData.axes(3,1));
vline(1,1);

hg.fgdgroup = hggroup(STYLE.fdggroup{:});
lib.view.plot.curve2D(...
	'data', pPL,...
	'x',	AXIS.pointlike.core.radius,...
	'y',	AXIS.pointlike.core.velocity,...
	'plot', [STYLE.fdg,{'Parent',hg.fgdgroup}] ...
);

lib.view.plot.curve2D(...
	'data', pFDG,...
	'x',	AXIS.core.radius,...
	'y',	AXIS.core.velocity,...
	'plot',	[STYLE.fdg,{'Parent',hg.fgdgroup}]...
);

hg.cored = hggroup(STYLE.fdgroup{:});
P.cored.forEach(@(p) lib.view.plot.curve2D(...
	'data', p,...
	'x',	AXIS.core.radius,...
	'y',	AXIS.core.velocity,...
	'plot',	[STYLE.fd,{'Parent',hg.cored}]...
));

% mass
axes(fh.UserData.axes(2,1));
vline(1,1);

hg.fgdgroup = hggroup(STYLE.fdggroup{:});
lib.view.plot.curve2D(...
	'data', pPL,...
	'x',	AXIS.pointlike.core.radius,...
	'y',	AXIS.pointlike.core.mass,...
	'plot',	[STYLE.fdg,{'Parent',hg.fgdgroup}]...
);
lib.view.plot.curve2D(...
	'data', pFDG,...
	'x',	AXIS.core.radius,...
	'y',	AXIS.core.mass,...
	'plot',	[STYLE.fdg,{'Parent',hg.fgdgroup}]...
);

hg.cored = hggroup(STYLE.fdgroup{:});
P.cored.forEach(@(p) lib.view.plot.curve2D(...
	'data', p,...
	'x',	AXIS.core.radius,...
	'y',	AXIS.core.mass,...
	'plot',	[STYLE.fd,{'Parent',hg.cored}]...
));

% degeneracy
axes(fh.UserData.axes(1,1));
hg.cored = hggroup(STYLE.fdgroup{:});
P.cored.forEach(@(p) lib.view.plot.curve2D(...
	'data', p,...
	'x',	AXIS.core.radius,...
	'y',	AXIS.center.degeneracy,...
	'plot',	[STYLE.fd,{'Parent',hg.cored}]...
));






% density
axes(fh.UserData.axes(4,2));
vline(1,1);

hg.is = hggroup(STYLE.isgroup{:});
plot([realmin,ANCH.center.map(P.is,AXIS.plat.radius)],[1,1]*ANCH.center.map(P.is,AXIS.plat.density),STYLE.is{:},'Parent',hg.is);
lib.view.plot.curve2D(...
	'data', P.is,...
	'x',	AXIS.plat.radius,...
	'y',	AXIS.plat.density,...
	'plot',	[STYLE.is,{'Parent',hg.is}]...
);

hg.trans = hggroup(STYLE.transgroup{:});
P.trans.forEach(@(p)lib.view.plot.curve2D(...
	'data', p,...
	'x',	AXIS.plat.radius,...
	'y',	AXIS.plat.density,...
	'plot',	[STYLE.trans,{'Parent',hg.trans}]...
));

hg.cored = hggroup(STYLE.fdgroup{:});
P.cored.forEach(@(p)lib.view.plot.curve2D(...
	'data', p,...
	'x',	AXIS.plat.radius,...
	'y',	AXIS.plat.density,...
	'plot',	[STYLE.fd,{'Parent',hg.cored}]...
));

% velocity
axes(fh.UserData.axes(3,2));
vline(1,1);

hg.is = hggroup(STYLE.isgroup{:});
lib.view.plot.curve2D(...
	'data', P.is,...
	'x',	AXIS.plat.radius,...
	'y',	AXIS.plat.velocity,...
	'plot', [STYLE.is,{'Parent',hg.is}]...
);

hg.trans = hggroup(STYLE.transgroup{:});
P.trans.forEach(@(p)lib.view.plot.curve2D(...
	'data', p,...
	'x',	AXIS.plat.radius,...
	'y',	AXIS.plat.velocity,...
	'plot',	[STYLE.trans,{'Parent',hg.trans}]...
));

hg.cored = hggroup(STYLE.fdgroup{:});
P.cored.forEach(@(p) lib.view.plot.curve2D(...
	'data', p,...
	'x',	AXIS.plat.radius,...
	'y',	AXIS.plat.velocity,...
	'plot',	[STYLE.fd,{'Parent',hg.cored}]...
));

% mass
axes(fh.UserData.axes(2,2));
vline(1,1);

hg.is = hggroup(STYLE.isgroup{:});
lib.view.plot.curve2D(...
	'data', P.is,...
	'x',	AXIS.plat.radius,...
	'y',	AXIS.plat.mass,...
	'plot',	[STYLE.is,{'Parent',hg.is}]...
);

hg.trans = hggroup(STYLE.transgroup{:});
P.trans.forEach(@(p)lib.view.plot.curve2D(...
	'data', p,...
	'x',	AXIS.plat.radius,...
	'y',	AXIS.plat.mass,...
	'plot',	[STYLE.trans,{'Parent',hg.trans}]...
));

hg.cored = hggroup(STYLE.fdgroup{:});
P.cored.forEach(@(p) lib.view.plot.curve2D(...
	'data', p,...
	'x',	AXIS.plat.radius,...
	'y',	AXIS.plat.mass,...
	'plot',	[STYLE.fd,{'Parent',hg.cored}]...
));

% degeneracy
axes(fh.UserData.axes(1,2));
vline(1,1);

hg.is = hggroup(STYLE.isgroup{:});
plot([realmin,ANCH.center.map(P.is,AXIS.plat.radius)],[1,1]*ANCH.center.map(P.is,AXIS.plat.degeneracy),STYLE.is{:},'Parent',hg.is);
lib.view.plot.curve2D(...
	'data', P.is,...
	'x',	AXIS.plat.radius,...
	'y',	AXIS.plat.degeneracy,...
	'plot',	[STYLE.is,{'Parent',hg.is}]...
);

hg.trans = hggroup(STYLE.transgroup{:});
P.trans.forEach(@(p)lib.view.plot.curve2D(...
	'data', p,...
	'x',	AXIS.plat.radius,...
	'y',	AXIS.plat.degeneracy,...
	'plot',	[STYLE.trans,{'Parent',hg.trans}]...
));

hg.cored = hggroup(STYLE.fdgroup{:});
P.cored.forEach(@(p) lib.view.plot.curve2D(...
	'data', p,...
	'x',	AXIS.plat.radius,...
	'y',	AXIS.plat.degeneracy,...
	'plot',	[STYLE.fd,{'Parent',hg.cored}]...
));




% density
axes(fh.UserData.axes(4,3));
vline(1,1);

hg.is = hggroup(STYLE.isgroup{:});
plot([realmin,ANCH.center.map(P.is,AXIS.core.radius)],[1,1]*ANCH.center.map(P.is,AXIS.core.density),STYLE.is{:},'Parent',hg.is);
lib.view.plot.curve2D(...
	'data', P.is,...
	'x',	AXIS.core.radius,...
	'y',	AXIS.core.density,...
	'plot',	[STYLE.is,{'Parent',hg.is}]...
);

hg.cored = hggroup(STYLE.fdgroup{:});
P.cored.forEach(@(p)lib.view.plot.curve2D(...
	'data', p,...
	'x',	AXIS.halo.radius,...
	'y',	AXIS.halo.density,...
	'plot',	[STYLE.fd,{'Parent',hg.cored}]...
));

% velocity
axes(fh.UserData.axes(3,3));
vline(1,1);

lib.view.plot.curve2D(...
	'data', P.is,...
	'x',	AXIS.core.radius,...
	'y',	AXIS.core.velocity,...
	'plot',	[STYLE.is,STYLE.isgroup]...
);

hg.cored = hggroup(STYLE.fdgroup{:});
P.cored.forEach(@(p) lib.view.plot.curve2D(...
	'data', p,...
	'x',	AXIS.halo.radius,...
	'y',	AXIS.halo.velocity,...
	'plot',	[STYLE.fd,{'Parent',hg.cored}]...
));

% mass
axes(fh.UserData.axes(2,3));
vline(1,1);
lib.view.plot.curve2D(...
	'data', P.is,...
	'x',	AXIS.core.radius,...
	'y',	AXIS.core.mass,...
	'plot',	[STYLE.is,STYLE.isgroup]...
);

hg.cored = hggroup(STYLE.fdgroup{:});
P.cored.forEach(@(p) lib.view.plot.curve2D(...
	'data', p,...
	'x',	AXIS.halo.radius,...
	'y',	AXIS.halo.mass,...
	'plot',	[STYLE.fd,{'Parent',hg.cored}]...
));

% degeneracy
axes(fh.UserData.axes(1,3));
vline(1,1);

hg.is = hggroup(STYLE.isgroup{:});
plot([realmin,ANCH.center.map(P.is,AXIS.core.radius)],[1,1]*ANCH.center.map(P.is,AXIS.core.degeneracy),STYLE.is{:},'Parent',hg.is);
lib.view.plot.curve2D(...
	'data',	P.is,...
	'x',	AXIS.core.radius,...
	'y',	AXIS.core.degeneracy,...
	'plot',	[STYLE.is,{'Parent',hg.is}]...
);

hg.cored = hggroup(STYLE.fdgroup{:});
P.cored.forEach(@(p) lib.view.plot.curve2D(...
	'data', p,...
	'x',	AXIS.halo.radius,...
	'y',	AXIS.halo.degeneracy,...
	'plot',	[STYLE.fd,{'Parent',hg.cored}]...
));



% lib.view.file.figure(fh,'export/theta0-low');

function vline(x,y,varargin)
lib.view.plot.vline(x,'Color', [1 1 1]*0.7, 'LineStyle',':',varargin{:});
plot(x,y,'Marker','o', 'MarkerFaceColor', 'w', 'MarkerEdgeColor','w','MarkerSize',10);
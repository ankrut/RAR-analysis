function profiles_intermediate
P			= load('export/CacheProfileBeta0.mat');
P = P.cuspy;
AXIS.center	= lib.require(@model.tov.rar.axes.center);
AXIS.core	= lib.require(@model.tov.rar.axes.core);
AXIS.plateau= lib.require(@model.tov.rar.axes.plateau);

AR			= AXIS.core.radius;
ARHO		= AXIS.center.density;
AV			= AXIS.core.velocity;
AM			= AXIS.core.mass;


AX.radius = struct(...
	'format',		'$%s/%s$',...
	'mapmodel',		AR.mapmodel,...
	'scalemodel',	AR.scalemodel ...
);

AX.density = struct(...
	'format',		'$%s/%s$',...
	'mapmodel',		ARHO.mapmodel,...
	'scalemodel',	ARHO.scalemodel ...
);

AX.velocity = struct(...
	'format',		'$%s/%s$',...
	'mapmodel',		AV.mapmodel,...
	'scalemodel',	AV.scalemodel ...
);

AX.mass = struct(...
	'format',		'$%s/%s$',...
	'mapmodel',		AM.mapmodel,...
	'scalemodel',	AM.scalemodel ...
);

C = lib.color.lines(5);

STYLE.fd.color		= 'k';
STYLE.low.color		= [1 1 1]*0.5;
STYLE.trans.color	= C{5};
STYLE.deficit.color	= C{4};
STYLE.high.color	= C{2};


% makeup
for ii = 1:P.low.length
	P.low.data{ii}.data.density(end) = realmin;
end
for ii = 1:P.trans.length
	P.trans.data{ii}.data.density(end) = realmin;
end
for ii = 1:P.deficit.length
	P.deficit.data{ii}.data.density(end) = realmin;
end
for ii = 1:P.high.length
	P.high.data{ii}.data.density(end) = realmin;
end


function plot_density(p,varargin)
	lib.view.plot.curve2D(p,AR,ARHO,varargin{:});
end

function plot_velocity(p,varargin)
	lib.view.plot.curve2D(p,AR,AV,varargin{:});
end

function plot_mass(p,varargin)
	lib.view.plot.curve2D(p,AR,AM,varargin{:});
end


% set axes models
RLIM = [1E-2,1E6];
XTICK = 10.^(-1:2:5);

AXMODEL.radius = {...
	'xlabel',AX.radius,...
	'ylabel',AX.density,...
	'axes', { ...
		'XLim',			RLIM,...
		'YLim',			[1E-21,1E1],...
		'XTick',		XTICK,...
		'YTick',		10.^(-20:4:0),...
		'YMinorTick',	'off' ...
	} ...
};

AXMODEL.velocity = {...
	'xlabel',AX.radius,...
	'ylabel',AX.velocity,...
	'axes', { ...
		'XLim',			RLIM,...
		'YLim',			[2E-3,3E0],...
		'XTick',		XTICK,...
		'YTick',		10.^(-2:1:0),...
		'YMinorTick',	'off' ...
	} ...
};

AXMODEL.mass = {...
	'xlabel',AX.radius,...
	'ylabel',AX.mass,...
	'axes', { ...
		'XLim',			RLIM,...
		'YLim',			[1E-5,1E7],...
		'XTick',		XTICK,...
		'YTick',		10.^(-4:2:6),...
		'YMinorTick',	'off' ...
	} ...
};

for ii=1:3
	ax(3,ii) = model.tov.rar.figure.ax_loglog(AXMODEL.radius{:});
	ax(2,ii) = model.tov.rar.figure.ax_loglog(AXMODEL.velocity{:});
	ax(1,ii) = model.tov.rar.figure.ax_loglog(AXMODEL.mass{:});
end

% show figure
fh = module.sapthesis.figure_grid(ax,'axHeight','equal','figure',{'FileName','profiles'});
figure(fh);


% mass
axes(fh.UserData.axes(1,1));
P.low.forEach(@(p) plot_mass(p,'color',STYLE.low.color));
P.low.pick(1).forEach(@(p) plot_mass(p,'color',STYLE.fd.color));

axes(fh.UserData.axes(1,2));
P.deficit.forEach(@(p) plot_mass(p,'color',STYLE.deficit.color));
P.trans.forEach(@(p) plot_mass(p,'color',STYLE.trans.color));
P.low.pick(1).forEach(@(p) plot_mass(p,'color',STYLE.fd.color));

axes(fh.UserData.axes(1,3));
P.high.forEach(@(p) plot_mass(p,'color',STYLE.high.color));
P.low.pick(1).forEach(@(p) plot_mass(p,'color',STYLE.fd.color));


% velocity
axes(fh.UserData.axes(2,1));
P.low.forEach(@(p) plot_velocity(p,'color',STYLE.low.color));
P.low.pick(1).forEach(@(p) plot_velocity(p,'color',STYLE.fd.color));

axes(fh.UserData.axes(2,2));
P.deficit.forEach(@(p) plot_velocity(p,'color',STYLE.deficit.color));
P.trans.forEach(@(p) plot_velocity(p,'color',STYLE.trans.color));
P.low.pick(1).forEach(@(p) plot_velocity(p,'color',STYLE.fd.color));

axes(fh.UserData.axes(2,3));
P.high.forEach(@(p) plot_velocity(p,'color',STYLE.high.color));
P.low.pick(1).forEach(@(p) plot_velocity(p,'color',STYLE.fd.color));


% density
axes(fh.UserData.axes(3,1));
P.low.forEach(@(p) plot_density(p,'color',STYLE.low.color));
P.low.pick(1).forEach(@(p) plot_density(p,'color',STYLE.fd.color));
title('low temperature')

axes(fh.UserData.axes(3,2));
P.deficit.forEach(@(p) plot_density(p,'color',STYLE.deficit.color));
P.trans.forEach(@(p) plot_density(p,'color',STYLE.trans.color));
P.low.pick(1).forEach(@(p) plot_density(p,'color',STYLE.fd.color));
title('transition')

axes(fh.UserData.axes(3,3));
P.high.forEach(@(p) plot_density(p,'color',STYLE.high.color));
P.low.pick(1).forEach(@(p) plot_density(p,'color',STYLE.fd.color));
title('high temperature')


% save pdf
lib.view.file.figure(fh,'export/beta0-intermediate');
end
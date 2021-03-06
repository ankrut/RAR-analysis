function fh = figure
AXIS	= lib.require(@lib.model.tov.rar.axes.plateau);

AR			= AXIS.radius;
ARHO		= AXIS.density;
AV			= AXIS.velocity;
AM			= AXIS.mass;

AX.radius = {...
	'XLim',		[1E-6,1E4],...
	'XTick',	10.^(-5:2:3),...
	'XScale',	'log' ...
};

AX.density = {...
	'YLim',		[1E-8,1E16],...
	'YTick',	10.^(-10:4:16),...
	'YScale',	'log',...
	'YMinorTick', 'off' ...
};

AX.velocity = {...
	'YLim',		[2E-1,2E3],...
	'YTick',	10.^(0:1:3),...
	'YScale',	'log'...
	'YMinorTick', 'off' ...
};

AX.mass = {...
	'YLim',		[1E-4,1E10],...
	'YTick',	10.^(-3:3:9),...
	'YScale',	'log'...
	'YMinorTick', 'off' ...
};

for ii=1:2
	ax(3,ii) = lib.module.figure.axes('x',AR, 'y',ARHO,	'axes',[AX.radius,AX.density]);
	ax(2,ii) = lib.module.figure.axes('x',AR, 'y',AV,	'axes',[AX.radius,AX.velocity]);
	ax(1,ii) = lib.module.figure.axes('x',AR, 'y',AM,	'axes',[AX.radius,AX.mass]);
end

fh = lib.module.sapthesis.figure_grid(ax,'axHeight',6);

% link all x axes
linkaxes(ax,'x')

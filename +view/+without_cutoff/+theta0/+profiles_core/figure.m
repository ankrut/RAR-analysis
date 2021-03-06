function fh = figure
AXIS	= lib.require(@lib.model.tov.rar.axes.core);

AR			= AXIS.radius;
ARHO		= AXIS.density;
AV			= AXIS.velocity;
AM			= AXIS.mass;


AX.radius = {...
	'XLim',		[1E-2,1E8],...
	'XTick',	10.^(-1:7),...
	'XScale',	'log' ...
};

AX.density = {...
	'YLim',		[1E-21,1E2],...
	'YTick',	10.^(-20:4:0),...
	'YScale',	'log',...
	'YMinorTick', 'off' ...
};

AX.velocity = {...
	'YLim',		[2E-4,2E0],...
	'YTick',	10.^(-4:1:0),...
	'YScale',	'log'...
	'YMinorTick', 'off' ...
};

AX.mass = {...
	'YLim',		[1E-4,1E8],...
	'YTick',	10.^(-3:3:6),...
	'YScale',	'log'...
	'YMinorTick', 'off' ...
};

for ii=1:1
	ax(3,ii) = lib.module.figure.axes('x',AR, 'y',ARHO,	'axes',[AX.radius,AX.density]);
	ax(2,ii) = lib.module.figure.axes('x',AR, 'y',AV,	'axes',[AX.radius,AX.velocity]);
	ax(1,ii) = lib.module.figure.axes('x',AR, 'y',AM,	'axes',[AX.radius,AX.mass]);
end

fh = lib.module.sapthesis.figure_grid(ax,'axHeight',6,'figure',{'FileName','profiles-core'});

% link all x axes
linkaxes(ax,'x')

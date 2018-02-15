function fh = figure()
W0LIM		= [1,80];
RLIM		= [1E0,1E13];
MLIM		= [1E0,1E13];
THETALIM	= [0,80];

% axes
AX.radius = lib.module.figure.axes(...
	'x','$W_0$',...
	'y','$r/r_c$',...
	'axes', {...
		'XLim',		W0LIM, ...
		'YLim',		RLIM,...
		'YTick',	10.^(0:3:12),...
		'YScale',	'log' ...
	}...
);

AX.mass = lib.module.figure.axes(...
	'x', '$W_0$',...
	'y', '$M(r)/M_c$',...
	'axes',	{...
		'XLim',		W0LIM, ...
		'YLim',		MLIM,...
		'YTick',	10.^(0:3:12),...
		'YScale',	'log' ...
	}...
);

AX.degeneracy = lib.module.figure.axes(...
	'x','$W_0$',...
	'y','$\theta_0 - \theta(r)$',...
	'axes',{...
		'XLim',		W0LIM, ...
		'YLim',		THETALIM,...
		'YTick',	0:10:70 ...
	}...
);

% figure
ax = [AX.degeneracy;AX.mass;AX.radius];
fh = lib.module.sapthesis.figure_grid(ax,'axHeight',4.5);
function fh = figure()
THETA0LIM	= [-15,50];
RLIM		= [1E0,1E10];
MLIM		= [1E0,1E9];
DTHETALIM	= [0,40];


% axes
AX.radius = model.tov.rar.figure.ax(...
	'xlabel','$\theta_0$',...
	'ylabel','$r/r_c$',...
	'axes', {...
		'XLim',		THETA0LIM, ...
		'YLim',		RLIM,...
		'YTick',	10.^(0:2:10),...
		'YScale',	'log' ...
	}...
);

AX.mass = model.tov.rar.figure.ax(...
	'xlabel', '$\theta_0$',...
	'ylabel', '$M(r)/M_c$',...
	'axes',	{...
		'XLim',		THETA0LIM, ...
		'YLim',		MLIM,...
		'YTick',	10.^(0:2:8),...
		'YScale',	'log' ...
	}...
);

AX.degeneracy = model.tov.rar.figure.ax(...
	'xlabel','$\theta_0$',...
	'ylabel','$\theta_0 - \theta(r)$',...
	'axes',{...
		'XLim',		THETA0LIM, ...
		'YLim',		DTHETALIM,...
		'YTick',	0:5:35 ...
	}...
);

% figure
ax = [AX.degeneracy;AX.mass;AX.radius];
fh = module.sapthesis.figure_grid(ax,'axHeight',4.5,'figure',{'FileName','analysis'});
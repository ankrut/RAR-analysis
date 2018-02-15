function fh = figure
AXIS.theta0 = {...
	'XLim',		[-15,50],...
	'XTick',	-10:10:70,...
};

AXIS.rho0 = {...
	'YLim',		[1E-18,5E2],...
	'YTick',	10.^(-17:3:2),...
	'YScale',	'log',...
	'YAxisLocation', 'right' ...
};

AXIS.beta0 = {...
	'YLim',		[1E-9,5E-1],...
	'YTick',	10.^(-8:2:-1),...
	'YScale',	'log',...
	'YAxisLocation', 'right' ...
};

AXIS.radius = {...
	'YLim',		[1E0,1E10],...
	'YTick',	10.^(0:2:10),...
	'YScale',	'log' ...
};

AXIS.mass = {...
	'YLim',		[1E-6,1E6],...
	'YTick',	10.^(-5:2:5),...
	'YScale',	'log' ...
};

AXIS.degeneracy = {...
	'YLim',		[-5,85],...
	'YTick',	-15:15:80 ...
};

% axes
AX.radius = {...
	'xlabel','$\theta_0$',...
	'ylabel','$r/R$',...
	'axes', {...
		AXIS.theta0{:},...
		AXIS.radius{:} ...
	}...
};

AX.mass = {...
	'x', '$\theta_0$',...
	'y', '$M(r)/M$',...
	'axes',	{...
		AXIS.theta0{:},...
		AXIS.mass{:} ...
	}...
};

AX.degeneracy = {...
	'x','$\theta_0$',...
	'y','$\theta_0 - \theta(r)$',...
	'axes',{...
		AXIS.theta0{:},...
		AXIS.degeneracy{:} ...
	}...
};

AX.rho0 = {...
	'x','$\theta_0$',...
	'y','$\rho_0/\rho$',...
	'axes',{...
		AXIS.theta0{:},...
		AXIS.rho0{:} ...
	}...
};

AX.beta0 = {...
	'x','$\theta_0$',...
	'y','$\beta_0$',...
	'axes',{...
		AXIS.theta0{:},...
		AXIS.beta0{:} ...
	}...
};



ax(1:3,1) = [
	lib.module.figure.axes(AX.degeneracy{:})
	lib.module.figure.axes(AX.mass{:})
	lib.module.figure.axes(AX.radius{:})
];


ax(1:2,2) = [
	lib.module.figure.axes(AX.rho0{:})
	lib.module.figure.axes(AX.beta0{:})
];

% hide labels manual
set([ax(2:3,1);ax(2,2)],'XTickLabel',[]);
set([ax(2:3,1);ax(2,2)],'XLabel',[]);

fh = lib.module.sapthesis.figure_grid(ax,...
	'axHeight',		4,...
	'padding',		struct('top', 0.6, 'left', 1.5, 'right', 1.5, 'bottom', 1.5),...
	'showLabels',	'manual' ...
);
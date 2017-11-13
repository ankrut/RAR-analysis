function varargout = theta0(varargin)
Q = module.struct(...
	'nlinfit', {},...
	varargin{:} ...
);

% destructure (necessary parameter)
vm				= Q.model;		% model struct
list			= Q.list;		% response list (module.ProfileResponseList)
nlinfitCascade	= Q.nlinfit;	% set gosect options cascade

% -----------------------------------------------------------------------

% set iteration print function
sPrec	= '%1.12e';
sStrong = ['<strong>' sPrec '</strong>'];
sFormat = strjoin({sPrec,sPrec,sStrong,sPrec,'%1.3e\n'},'\t');
fLog	= @(SOL) fprintf(sFormat,list.data{1}.map(SOL),SOL.data.beta0,SOL.data.theta0,SOL.data.W0,list.chi2(SOL));

% set vector function
fVector = @(vm) [
	vm.param.theta0
];

% set update function
fUpdate = @(b,vm) struct(...
	'param', struct(...
		'beta0',	vm.param.beta0,...
		'theta0',	b(1),...
		'W0',		vm.param.W0...
	),...
	'options',	vm.options ...
);


[varargout{1:nargout}] = model.tov.rar.nlinfit.theta0(vm,list,...
	'fVector',		fVector,...
	'fUpdate',		fUpdate,...
	'fLog',			fLog,...
	nlinfitCascade{:} ...
);
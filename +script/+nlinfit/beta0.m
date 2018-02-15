function varargout = beta0(varargin)
Q = lib.module.struct(...
	'nlinfit', {},...
	varargin{:} ...
);

% destructure (necessary parameter)
vm				= Q.model;		% model struct
list			= Q.list;		% response list (lib.module.ProfileResponseList)
nlinfitCascade	= Q.nlinfit;	% set gosect options cascade

% -----------------------------------------------------------------------

% set iteration print function
sPrec	= '%1.12e';
sStrong = ['<strong>' sPrec '</strong>'];
sFormat = strjoin({sPrec,sStrong,sPrec,sPrec,'%1.3e\n'},'\t');
fLog	= @(SOL) fprintf(sFormat,list.data{1}.map(SOL),SOL.data.beta0,SOL.data.theta0,SOL.data.W0,list.chi2(SOL));

% set vector function
fVector = @(vm) [
	log(vm.param.beta0)
];

% set update function
fUpdate = @(b,vm) struct(...
	'param', struct(...
		'beta0',	exp(b(1)),...
		'theta0',	vm.param.theta0,...
		'W0',		vm.param.W0 ...
	),...
	'options',	vm.options ...
);


[varargout{1:nargout}] = lib.model.tov.rar.nlinfit.beta0(vm,list,...
	'fVector',		fVector,...
	'fUpdate',		fUpdate,...
	'fLog',			fLog,...
	nlinfitCascade{:} ...
);
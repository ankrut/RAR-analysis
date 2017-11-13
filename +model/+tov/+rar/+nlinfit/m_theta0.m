function varargout = m_theta0(vm,list,varargin)
% set iteration print function
sPrec	= '%1.12e';
sStrong = ['<strong>' sPrec '</strong>'];
sFormat = strjoin({sStrong,sPrec,sStrong,sPrec,'%1.3e\n'},'\t');
fLog	= @(SOL) fprintf(sFormat,SOL.data.m,SOL.data.beta0,SOL.data.theta0,SOL.data.W0,list.chi2(SOL));

% set vector function
fVector = @(vm) [
	log(vm.param.m)
	vm.param.theta0
];



% set update function
fUpdate = @(b,vm) struct(...
	'param', struct(...
		'm',		exp(b(1)),...
		'beta0',	vm.param.beta0,...
		'theta0',	b(2),...
		'W0',		vm.param.W0 ...
	),...
	'options',	vm.options ...
);

% set model function
fModel = @(SOL) struct(...
	'param', struct(...
		'm',		SOL.data.m,...
		'beta0',	SOL.data.beta0,...
		'theta0',	SOL.data.theta0,...
		'W0',		SOL.data.W0 ...
	),...
	'options',	vm.options ...
);

% seach for solution
[varargout{1:nargout}] = model.tov.rar.nlinfit(vm,list,...
	'fVector',		fVector,...
	'fUpdate',		fUpdate,...
	'fModel',		fModel,...
	'fLog',			fLog,...
	varargin{:} ...
);
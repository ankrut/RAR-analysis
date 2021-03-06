function varargout = beta0(varargin)
Q = lib.module.struct(...
	'gosect', {},...
	varargin{:} ...
);

% destructure (necessary parameter)
vm				= Q.model;		% model struct
list			= Q.list;		% response list (lib.module.ProfileResponseList)
gosectCascade	= Q.gosect;		% set gosect options cascade

if isa(list,'lib.module.ProfileResponse')
	list = lib.module.ProfileResponseList(list);
end

% set search interval
if isfield(Q,'interval')
	Xint = Q.interval;
elseif isfield(Q,'dbeta0')
	Xint(1) = vm.param.beta0 - Q.dbeta0;
	Xint(2) = vm.param.beta0 + Q.dbeta0;
elseif isfield(Q,'qbeta0')
	Xint(1) = vm.param.beta0*(1 - Q.qbeta0);
	Xint(2) = vm.param.beta0*(1 + Q.qbeta0);
end

% -----------------------------------------------------------------------

% set iteration print function
sPrec	= '%1.12e';
sStrong = ['<strong>' sPrec '</strong>'];
sFormat = strjoin({sPrec,sStrong,sPrec,sPrec,'%1.3e\n'},'\t');
fLog	= @(SOL) fprintf(sFormat,list.data{1}.map(SOL),SOL.data.beta0,SOL.data.theta0,SOL.data.W0,list.chi2(SOL));

% set chi2 function
fResponse = @(SOL) list.chi2(SOL);

% set update function
fUpdate = @(x,vm) struct(...
	'param', struct(...
		'beta0',	exp(x),...
		'theta0',	vm.param.theta0,...
		'W0',		vm.param.W0 ...
	),...
	'options', vm.options ...
);

% search for solution
[varargout{1:nargout}] = lib.model.tov.rar.gosect(vm,list,...
	'Xint',			log(Xint),...
	'fResponse',	fResponse,...
	'fUpdate',		fUpdate,...
	'fLog',			fLog,...
	gosectCascade{:} ...
);

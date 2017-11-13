function varargout = findSolution(varargin)
Q = module.struct(...
	'nlinfit',	{},...
	'gosect',	{},...
	varargin{:}...
); 

% destructure (Q.query, Q.model, Q.searchCfg)
q		= module.struct(Q.query{:});
vm		= Q.model;
list	= module.array(fieldnames(q)).map(@(key) ...
			module.ProfileResponse(Q.searchCfg.ResponseList.(key),q.(key)) ...
		  ).pipe(@module.ProfileResponseList);
fChi2	= @(SOL) list.chi2(SOL);
TAU		= Q.searchCfg.tau;

% set nlinfit options (for autofind)
opts				= statset('nlinfit');
opts.FunValCheck	= 'off';
opts.MaxIter		= 50;
opts.TolX			= 1E-12;

fSolution = {};

fSolution{end+1} = @(vm) script.nlinfit.theta0(...
	'model',	vm,...
	'list',		list,...
	'nlinfit',	{'options', opts, Q.nlinfit{:}} ...
);

fSolution{end+1} = @(vm) script.gosect.theta0(...
	'model',	vm,...
	'list',		list,...
	'dtheta0',	15,...
	'gosect',	Q.gosect ...
);

[varargout{1:nargout}] = script.findSolution(vm,fSolution,fChi2,TAU);

function varargout = findSolution(varargin)
Q = lib.module.struct(varargin{:}); 

% destructure (Q.query, Q.model, Q.searchCfg)
q		= lib.module.struct(Q.query{:});
vm		= Q.model;
list	= lib.module.array(fieldnames(q)).map(@(key) ...
			lib.module.ProfileResponse(Q.searchCfg.ResponseList.(key),q.(key)) ...
		  ).pipe(@lib.module.ProfileResponseList);
fChi2	= @(SOL) list.chi2(SOL);
TAU		= Q.searchCfg.tau;

% set nlinfit options (for autofind)
opts				= statset('nlinfit');
opts.FunValCheck	= 'off';
opts.MaxIter		= 50;
opts.TolX			= 1E-12;

fSolution = {};

fSolution{end+1} = @(vm) script.nlinfit.W0(...
	'model',	vm,...
	'list',		list,...
	'nlinfit',	{'options', opts} ...
);

fSolution{end+1} = @(vm) script.gosect.W0(...
	'model',	vm,...
	'list',		list,...
	'dW0',		15 ...
);

[varargout{1:nargout}] = script.findSolution(vm,fSolution,fChi2,TAU);


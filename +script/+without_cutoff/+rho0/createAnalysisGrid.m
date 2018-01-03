function createAnalysisGrid
searchCfg = lib.require(@configs.solutionSearchConfig);

% set seed model struct
opts		= struct('xmax', 1E20, 'tau', 1E-16, 'rtau', 1E-4);
param.seed	= struct('beta0', 1E0, 'W0', 200);
vm.seed		= struct('param', param.seed, 'options', opts);

% set grid (theta0)
X = linspace(-20,50,100);

% calc profiles
T.thin			= module.array();
resp			= module.ProfileResponse(searchCfg.ResponseList.rho0,1E-7);
fSolution{1}	= @(vm,list) script.nlinfit.beta0('model',vm, 'list', list);

for x = X
	vm.seed.param.theta0 = x;
	
	[~,vm.seed] = module.find(...
		'query',		resp,...
		'model',		vm.seed,...
		'fSolution',	fSolution ...
	);

	T.thin.push(vm.seed);
end

lib.save('export/TblWithoutCutoffAnalysisRho0.mat',T);
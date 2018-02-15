function createAnalysisGrid
searchCfg = lib.require(@configs.solutionSearchConfig);

% set seed model struct
opts		= struct('xmax', 1E20, 'tau', 1E-16, 'rtau', 1E-4);
param.seed	= struct('beta0', 1.64e-03, 'W0', 200);
vm.seed		= struct('param', param.seed, 'options', opts);

% set grid (theta0)
X = linspace(-15,50,100);

% calc profiles
T.thin			= lib.module.array();
resp			= lib.module.ProfileResponse(searchCfg.ResponseList.rhop,1E-14);
fSolution{1}	= @(vm,list) script.nlinfit.beta0('model',vm, 'list', list);

for x = X
	vm.seed.param.theta0 = x;
	
	[~,vm.seed] = lib.module.find(...
		'query',		resp,...
		'model',		vm.seed,...
		'fSolution',	fSolution ...
	);

	T.thin.push(vm.seed);
end

lib.save('export/TblWithoutCutoffAnalysisRhop.mat',T);
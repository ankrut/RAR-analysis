function createAnalysisGrid
searchCfg = lib.require(@configs.solutionSearchConfig);

% set seed model struct
opts		= struct('xmax', 1E20, 'tau', 1E-16, 'rtau', 1E-4);
param.seed	= struct('W0', 200);
vm.seed		= struct('param', param.seed, 'options', opts);

% set golden section search options
goOpts		= struct('tau',1E-12,'rtau',1E-8,'MaxIter',50);

% set grid
X = logspace(-9,2,100);

% calc profiles
vm.seed.param.theta0 = -20;

% find plateau-halo merging point A
[~,vm.A] = script.gosect.beta0(...
	'model',	vm.seed,...
	'list',		lib.module.ProfileResponse(searchCfg.ResponseList.rhorp,'min'),...
	'interval',	[1E-1,1E0],...
	'gosect',	{'options',goOpts} ...
);

[~,vm.B] = script.gosect.beta0(...
	'model',	vm.seed,...
	'list',		lib.module.ProfileResponse(searchCfg.ResponseList.rhorp,'min'),...
	'interval',	[1E0,1E1],...
	'gosect',	{'options',goOpts} ...
);

Xa = logspace(-9,log10(vm.A.param.beta0),80);
Xb = logspace(log10(vm.A.param.beta0),log10(vm.B.param.beta0),10);
Xc = logspace(log10(vm.B.param.beta0),2,20);
T.diluted = script.with_cutoff.beta0.createGrid(vm.seed,[Xa,Xb(2:end),Xc(2:end)]).map(@(vm) lib.model.tov.rar.profile('model',vm));

vm.seed.param.theta0 = 10;
T.trans = script.with_cutoff.beta0.createGrid(vm.seed,X).map(@(vm) lib.model.tov.rar.profile('model',vm));

vm.seed.param.theta0 = 30;
T.degenerate = script.with_cutoff.beta0.createGrid(vm.seed,X).map(@(vm) lib.model.tov.rar.profile('model',vm));

lib.save('export/TblWithoutCutoffAnalysisBeta0.mat',T);
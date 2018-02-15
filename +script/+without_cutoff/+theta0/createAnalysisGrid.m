function createAnalysisGrid
searchCfg = lib.require(@configs.solutionSearchConfig);

% set seed model struct
opts		= struct('xmax', 1E20, 'tau', 1E-16, 'rtau', 1E-4);
param.seed	= struct('W0', 200);
vm.seed		= struct('param', param.seed, 'options', opts);

% set golden section search options
goOpts		= struct('tau',1E-12,'rtau',1E-8,'MaxIter',50);

% set grid
X = linspace(-15,80,100);

% calc profiles
vm.seed.param.beta0 = 1E-6;
T.low = script.with_cutoff.theta0.createGrid(vm.seed,X).map(@(vm) lib.model.tov.rar.profile('model',vm));

vm.seed.param.beta0 = 1E-2;
T.trans = script.with_cutoff.theta0.createGrid(vm.seed,X).map(@(vm) lib.model.tov.rar.profile('model',vm));

vm.seed.param.beta0 = 1E0;

% find plateau-halo merging point
[~,vm.high] = script.gosect.theta0(...
	'model',	vm.seed,...
	'list',		lib.module.ProfileResponse(searchCfg.ResponseList.rhorp,'min'),...
	'interval',	[5,15],...
	'gosect',	{'options',goOpts} ...
);

Xa = linspace(-15,vm.high.param.theta0,10);
Xb = linspace(vm.high.param.theta0,80,90);
T.high = script.with_cutoff.theta0.createGrid(vm.seed,[Xa,Xb(2:end)]).map(@(vm) lib.model.tov.rar.profile('model',vm));

lib.save('export/TblAnalysisTheta0Low.mat',T);
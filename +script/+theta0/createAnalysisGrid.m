function createAnalysisGrid
searchCfg	= lib.require(@configs.solutionSearchConfig);

% set seed model struct
opts		= struct('xmin', 1E-7, 'xmax', 1E20, 'tau', 1E-16, 'rtau', 1E-4);
param.seed	= struct('beta0', 1E-6, 'W0', 36);
vm.seed		= struct('param', param.seed, 'options', opts);

% nlinfit options cascade
nlOpts				= statset('nlinfit');
nlOpts.FunValCheck	= 'off';
nlOpts.MaxIter		= 50;
nlOpts.TolX			= 1E-12;
nlOpts.DerivStep	= 1E-9;

% set golden section search options
goOpts				= struct('tau',1E-12,'rtau',1E-8,'MaxIter',50);

% find cored-cuspy transition point
% (minimum surface radius for cored regime)
[p.trans,vm.trans] = script.gosect.theta0(...
	'model',	vm.seed,...
	'list',		module.ProfileResponse(searchCfg.ResponseList.rsorc,'min'),...
	'interval',	[18,19],...
	'gosect',	{'options',goOpts} ...
);

% find cuspy-deficit transition point
[p.trans2,vm.trans2] = script.gosect.theta0(...
'model',	vm.seed,...
'list',		module.ProfileResponse(@(SOL) searchCfg.ResponseList.rsorp(SOL),'min'),...
'interval',	[19.5,20.5],...
'gosect',	{'options',goOpts} ...
);

% find deficit-disrupt transition point
[p.trans3,vm.trans3] = script.gosect.theta0(...
'model',	vm.seed,...
'list',		module.ProfileResponse(@(SOL) 1E10 - searchCfg.ResponseList.rsorc(SOL),'min'),...
'interval',	[20,20.5],...
'gosect',	{'options',goOpts} ...
);


% gives the solution with the largest surface rudius with a cuspy halo
% (for beta0 = 1E-6 and theta0 = 20
xMax = vm.trans3.param.theta0;

% split grid
Xa = linspace(-15,vm.trans.param.theta0,75);
Xb = xMax - logspace(-7,log10(xMax - vm.trans.param.theta0),35);
Xc = xMax + logspace(-7,log10(25 - xMax),35);
Xd = linspace(26,50,75);
X = [Xa flip(Xb) xMax Xc Xd];

% calc profiles
P = script.theta0.createGrid(vm.seed,X).map(@(vm) model.tov.rar.profile('model',vm));

save('export/TblAnalysisTheta0.mat','P');
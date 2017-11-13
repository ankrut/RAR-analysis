function createProfileGrid
searchCfg = lib.require(@configs.solutionSearchConfig);

opts			= struct('xmin', 1E-7, 'xmax', 1E20, 'tau', 1E-16, 'rtau', 1E-4);

% cored
param.cored		= struct('beta0', 1E-6, 'theta0', 20, 'W0', 76.406558904368140);
vm.cored		= struct('param', param.cored, 'options', opts);

TblProfilesW0.cored = script.createGrid(...
	'key',			'rsorp',...
	'grid',			logspace(10,log10(37.245910669912789),51),...
	'model',		vm.cored,...
	'searchCfg',	searchCfg,...
	'fSearch',		@script.W0.findSolution,...
	'fEstimate',	@script.W0.estimateModelStruct ...
);

% cuspy
param.cuspy		= struct('beta0', 1E-6, 'theta0', 20, 'W0', 35.790981099387963);
vm.cuspy		= struct('param', param.cuspy, 'options', opts);

TblProfilesW0.cuspy = script.createGrid(...
	'key',			'rsorc',...
	'grid',			logspace(log10(4.485430020901418e+08),log10(2.510823654154145e+04),51),...
	'model',		vm.cuspy,...
	'searchCfg',	searchCfg,...
	'fSearch',		@script.W0.findSolution ...
);

% deficit
param.deficit	= struct('beta0', 1E-6, 'theta0', 20, 'W0', 35.790981099387963);
vm.deficit		= struct('param', param.deficit, 'options', opts);

TblProfilesW0.deficit = script.W0.createGrid(vm.deficit,linspace(35.790981099387963,35.790979949063676,21));

% disrupted
param.disrupt	= struct('beta0', 1E-6, 'theta0', 20, 'W0', 17.673226550495922);
vm.disrupt		= struct('param', param.deficit, 'options', opts);

TblProfilesW0.disrupt = script.W0.createGrid(vm.disrupt,35.790979949063676 - logspace(-6.5,log10(35.790979949063676 - 17.673226550495922),21));

lib.save('export/TblProfileW0.mat',TblProfilesW0);	



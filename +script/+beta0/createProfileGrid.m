function createProfileGrid
TblProfileBeta0 = load('export/TblProfileBeta0.mat');

% TblProfileBeta0.cored	= cored();
TblProfileBeta0.cuspy	= cuspy();
% TblProfileBeta0.deficit	= deficit();

lib.save('export/TblProfileBeta0.mat',TblProfileBeta0)

function T = cored
searchCfg	= lib.require(@configs.solutionSearchConfig);

% set seed model struct
opts		= struct('xmax', 1E20, 'tau', 1E-16, 'rtau', 1E-4);
param.seed	= struct('theta0', 20, 'W0', 50);
vm.seed		= struct('param', param.seed, 'options', opts);

% nlinfit options cascade
nlOpts				= statset('nlinfit');
nlOpts.FunValCheck	= 'off';
nlOpts.MaxIter		= 50;
nlOpts.TolX			= 1E-12;

% set golden section search options
goOpts			= struct('tau',1E-12,'rtau',1E-8,'MaxIter',50);

% find transition point (rp/rc minima)
[p.trans,vm.trans] = script.gosect.beta0(...
	'model',	vm.seed,...
	'list',		module.ProfileResponse(@(SOL) searchCfg.ResponseList.rporc(SOL),'min'),...
	'interval',	[8,20]*1E-2,...
	'gosect',	{'options',goOpts} ...
);

% set low temperature limit
vm.low		= lib.struct.setfield(vm.seed,'param/beta0',1E-7);
p.low		= model.tov.rar.profile('model',vm.low);

% set high temperature limit
vm.high		= lib.struct.setfield(vm.seed,'param/beta0',1E2);
p.high		= model.tov.rar.profile('model',vm.high);

% low
gridA	= searchCfg.ResponseList.rhop_rho0(p.trans);
gridB	= searchCfg.ResponseList.rhop_rho0(p.low); 

T.low = script.createGrid(...
	'key',			'rhop_rho0',...
	'grid',			logspace(log10(gridA),log10(gridB),21),...
	'model',		vm.trans,...
	'searchCfg',	searchCfg,...
	'fSearch',		@script.beta0.findSolution,...
	'fEstimate',	@script.beta0.estimateModelStruct,...
	'search',		{'nlinfit', {'options' nlOpts}} ...
);

% high
gridA	= searchCfg.ResponseList.rhop_rho0(p.high);
gridB	= searchCfg.ResponseList.rhop_rho0(p.trans);

T.high = script.createGrid(...
	'key',			'rhop_rho0',...
	'grid',			logspace(log10(gridA),log10(gridB),21),...
	'model',		vm.high,...
	'searchCfg',	searchCfg,...
	'fSearch',		@script.beta0.findSolution,...
	'fEstimate',	@script.beta0.estimateModelStruct,...
	'search',		{'nlinfit', {'options' nlOpts}} ...
);


function T = cuspy
searchCfg	= lib.require(@configs.solutionSearchConfig);

% set seed model struct
opts		= struct('xmax', 1E20, 'tau', 1E-16, 'rtau', 1E-4);
param.seed	= struct('theta0', 20, 'W0', 28);
vm.seed		= struct('param', param.seed, 'options', opts);

% nlinfit options cascade
nlOpts				= statset('nlinfit');
nlOpts.FunValCheck	= 'off';
nlOpts.MaxIter		= 50;
nlOpts.TolX			= 1E-12;
nlOpts.DerivStep	= 1E-9;

% set golden section search options
goOpts				= struct('tau',1E-12,'rtau',1E-8,'MaxIter',50);


% set low temperature limit
vm.low	= lib.struct.setfield(vm.seed,'param/beta0',1E-7);
p.low	= model.tov.rar.profile('model',vm.low);

% set high temperature limit
vm.high	= lib.struct.setfield(vm.seed,'param/beta0',1E3);
p.high	= model.tov.rar.profile('model',vm.high);

% find cored-cuspy transition point
% (minimum surface radius for cored regime)
[p.trans,vm.trans] = script.gosect.beta0(...
	'model',	vm.seed,...
	'list',		module.ProfileResponse(searchCfg.ResponseList.rsorc,'min'),...
	'interval',	[7,12]*1E-2,...
	'gosect',	{'options',goOpts} ...
);

% find cuspy-deficit transition point
[p.trans2,vm.trans2] = script.gosect.beta0(...
	'model',	vm.seed,...
	'list',		module.ProfileResponse(searchCfg.ResponseList.rsorp,'min'),...
	'interval',	[3,8]*1E-2,...
	'gosect',	{'options',goOpts} ...
);

% find deficit-disrupt transition point
[p.trans3,vm.trans3] = script.gosect.beta0(...
	'model',	vm.seed,...
	'list',		module.ProfileResponse(@(SOL) 1/searchCfg.ResponseList.rsorc(SOL),'min'),...
	'interval',	[3,7]*1E-2,...
	'gosect',	{'options',goOpts} ...
);



% high temperature
gridA	= searchCfg.ResponseList.rsorc(p.high);
gridB	= searchCfg.ResponseList.rsorc(p.trans);

T.high = script.createGrid(...
	'key',			'rsorc',...
	'grid',			logspace(log10(gridA),log10(gridB),31),...
	'model',		vm.high,...
	'searchCfg',	searchCfg,...
	'fSearch',		@script.beta0.findSolution,...
	'search',		{'nlinfit', {'options', nlOpts}} ...
);

% transition (cuspy halo emerge)
gridA	= searchCfg.ResponseList.rsorc(p.trans);
gridB	= searchCfg.ResponseList.rsorc(p.trans2);
T.trans = script.createGrid(...
	'key',			'rsorc',...
	'grid',			logspace(log10(gridA),log10(gridB),51),...
	'model',		vm.trans,...
	'searchCfg',	searchCfg,...
	'fSearch',		@script.beta0.findSolution ...
);

% transition (halo deficit)
gridA	= searchCfg.ResponseList.rsorc(p.trans2);
gridB	= searchCfg.ResponseList.rsorc(p.trans3);
T.deficit = script.createGrid(...
	'key',			'rsorc',...
	'grid',			logspace(log10(gridA),log10(gridB),21),...
	'model',		vm.trans2,...
	'searchCfg',	searchCfg,...
	'fSearch',		@script.beta0.findSolution ...
);


% low tempereature
gridA	= searchCfg.ResponseList.rsorc(p.trans3);
gridB	= searchCfg.ResponseList.rsorc(p.low);

grid = logspace(log10(gridA),log10(gridB),21);

T.low = script.createGrid(...
	'key',			'rsorc',...
	'grid',			grid(1),...
	'model',		vm.trans3,...
	'searchCfg',	searchCfg,...
	'fSearch',		@script.beta0.findSolution,...
	'search',		{'nlinfit', {'options', nlOpts}} ...
).append(script.createGrid(...
	'key',			'rsorc',...
	'grid',			grid(2:end-1),...
	'model',		lib.struct.setfield(vm.trans3,'param/beta0',vm.trans3.param.beta0*(1 - 1E-4)),...
	'searchCfg',	searchCfg,...
	'fSearch',		@script.beta0.findSolution,...
	'search',		{'nlinfit', {'options', nlOpts}} ...
)).append(script.createGrid(...
	'key',			'rsorc',...
	'grid',			grid(end),...
	'model',		lib.struct.setfield(vm.trans3,'param/beta0',1E-4),...
	'searchCfg',	searchCfg,...
	'fSearch',		@script.beta0.findSolution,...
	'search',		{'nlinfit', {'options', nlOpts}} ...
));

function T = deficit
% set seed model struct
opts		= struct('xmax', 1E20, 'tau', 1E-16, 'rtau', 1E-4);
param.seed	= struct('theta0', 20, 'W0', 22);
vm.seed		= struct('param', param.seed, 'options', opts);

% set beta0 grid
X = logspace(-6,2,61);

% calc profiles
T = script.beta0.createGrid(vm.seed,X).map(@(vm) model.tov.rar.profile('model',vm));
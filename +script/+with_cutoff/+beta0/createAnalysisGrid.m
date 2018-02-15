function createAnalysisGrid
% set seed model struct
opts		= struct('xmax', 1E20, 'tau', 1E-16, 'rtau', 1E-4);
param.seed	= struct('theta0', 20);
vm.seed		= struct('param', param.seed, 'options', opts);
vm.weak		= lib.struct.setfield(vm.seed,'param/W0', 50);
vm.inter	= lib.struct.setfield(vm.seed,'param/W0', 28);
vm.strong	= lib.struct.setfield(vm.seed,'param/W0', 22);

% calc profiles
% T = load('export/TblAnalysisBeta0.mat'); % uncomment for update
T.weak		= getWeak(vm.weak);
T.inter		= getIntermediate(vm.inter);
T.strong	= getStrong(vm.strong);

% save
lib.save('export/TblAnalysisBeta0.mat',T);


function T = getWeak(vmSeed)
X = logspace(-6,2,60);
T = script.with_cutoff.beta0.createGrid(vmSeed,X).map(@(vm) lib.model.tov.rar.profile('model',vm));


function T = getIntermediate(vmSeed)
TBL			= load('export/TblProfileBeta0.mat');

TBL.cuspy.low.sort(@(t) t.model.param.beta0);
TBL.cuspy.deficit.sort(@(t) t.model.param.beta0);
TBL.cuspy.trans.sort(@(t) t.model.param.beta0);

vm.low		= TBL.cuspy.low.data{4}.model;
vm.trans	= TBL.cuspy.trans.data{1}.model;

X1 = logspace(-6,log10(vm.low.param.beta0),21);
X2 = TBL.cuspy.low.accumulate(@(t) t.model.param.beta0);
X3 = TBL.cuspy.deficit.accumulate(@(t) t.model.param.beta0);
X4 = TBL.cuspy.trans.accumulate(@(t) t.model.param.beta0);
X5 = logspace(log10(vm.trans.param.beta0),3,21);

X = [X1 X2(5:end) X3(2:end) X4(2:end) X5(2:end)];
T = script.with_cutoff.beta0.createGrid(vmSeed,X).map(@(vm) lib.model.tov.rar.profile('model',vm));


function T = getStrong(vmSeed)
searchCfg	= lib.require(@configs.solutionSearchConfig);

% set golden section search options
goOpts		= struct('tau',1E-12,'rtau',1E-8,'MaxIter',50);

% find cored-cuspy transition point
% (minimum surface radius for cored regime)
[~,vm] = script.gosect.beta0(...
	'model',	vmSeed,...
	'list',		lib.module.ProfileResponse(@(SOL) searchCfg.ResponseList.rh(SOL)/searchCfg.ResponseList.rc(SOL),'min'),...
	'interval',	[7,10]*1E-1,...
	'gosect',	{'options',goOpts} ...
);

X1 = logspace(-6,-3,5);
X2 = logspace(-3,log10(vm.param.beta0),21);
X3 = logspace(log10(vm.param.beta0),2,31);

X = [X1 X2(2:end) X3(2:end)];
T = script.with_cutoff.beta0.createGrid(vmSeed,X).map(@(vm) lib.model.tov.rar.profile('model',vm));
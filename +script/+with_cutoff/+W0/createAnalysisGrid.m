function createAnalysisGrid
GridPoints	= load('export/TblGridPointsW0.mat');

% gives the solution with the largest surface rudius with a cuspy halo
% (for beta0 = 1E-6 and theta0 = 20
W0max	= GridPoints.trans3.model.param.W0;

% set model parameter
opts	= struct('xmax', 1E20, 'tau', 1E-16, 'rtau', 1E-4);
param	= struct('beta0', 1E-6, 'theta0', 20);
vm		= struct('param', param, 'options', opts);

% split grid at W0max
W0a = logspace(0,log10(30),75);
W0b = W0max - logspace(-7,log10(W0max - 31),35);
W0c = W0max + logspace(-7,log10(39 - W0max),35);
W0d = logspace(log10(40),log10(80),75);
W0 = [W0a flip(W0b) W0max W0c W0d];

% calc profiles
P = script.with_cutoff.W0.createGrid(vm,W0).map(@(vm) lib.model.tov.rar.profile('model',vm));

save('export/TblAnalysisW0.mat','P');
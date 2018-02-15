% function createAnalysisGrid
T			= lib.module.array();
searchCfg	= lib.require(@configs.solutionSearchConfig);

% set seed model struct
opts		= struct('xmax', 1E20, 'tau', 1E-16, 'rtau', 1E-4);
param.seed	= struct('beta0', 1.278824985011325e-06, 'theta0', 1.143923654657185e+01, 'W0', 2.166255345147945e+01);
vm.seed		= struct('param', param.seed, 'options', opts);


% define constraints
resp		= [
	lib.module.ProfileResponse(searchCfg.ResponseList.rho0,1E-7)
	lib.module.ProfileResponse(searchCfg.ResponseList.rhop,1E-17)
	lib.module.ProfileResponse(searchCfg.ResponseList.rhorp,1)
];

% find lower bound (becomes the seed)
[~,vm.low] = lib.module.find(...
	'query',		resp,...
	'model',		vm.seed,...
	'fSolution',	{@(vm,list)  lib.model.tov.rar.nlinfit.beta0_theta0_W0(vm,list)} ...
);

% set grid (W0)
X = linspace(80,vm.low.param.W0,100);

% find solutions
param.seed	= struct('beta0', 5.431504615089040e-07, 'theta0', 2.394682829719866e+01, 'W0', 80);
vm.seed		= struct('param', param.seed, 'options', opts);

for x = X
	vm.seed.param.W0 = x;
	
	if T.length > 2
		vm.seed = script.with_cutoff.RHO0RHOp.polyfitModelStruct(x,@(t) t.param.W0,vm.seed,lib.module.array(T.data{end-2:end}));
		vm.seed.param
	end
	
	[~,vm.seed] = lib.module.find(...
		'query',		resp(1:2),...
		'model',		vm.seed,...
		'fSolution',	{@(vm,list) lib.model.tov.rar.nlinfit.beta0_theta0(vm,list)} ...
	);
		
	T.push(vm.seed);
end

lib.save('export/TblWithCutoffAnalysisRHO0RHOp.mat',struct('RHO0RHOp', T.reverse()));
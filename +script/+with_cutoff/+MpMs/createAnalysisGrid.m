% function createAnalysisGrid
searchCfg = lib.require(@configs.solutionSearchConfig);

% set seed model struct
opts		= struct('xmax', 1E20, 'tau', 1E-16, 'rtau', 1E-4);
param.seed	= struct('beta0', 3.428651417200964e-10, 'theta0', -10.194949494949491, 'W0', 29.418131269761403);
vm.seed		= struct('param', param.seed, 'options', opts);

% set grid (beta0)
X1 = linspace(-10,38,100);
X2 = linspace(38,40,20);
X = [X1 X2(2:end)];

% calc profiles
T.cuspy			= lib.module.array();
resp			= [
	lib.module.ProfileResponse(searchCfg.ResponseList.Mp,4E-3)
	lib.module.ProfileResponse(searchCfg.ResponseList.Ms,1E2)
];

% vm.seed = T.cuspy.data{end};
% X = X(T.cuspy.length+1:end);

for x = X
	vm.seed.param.theta0 = x;
	if T.cuspy.length > 2
		vm.seed = script.with_cutoff.MpMs.polyfitModelStruct(x,@(t) t.param.theta0,vm.seed,lib.module.array(T.cuspy.data{end-2:end}));
		vm.seed.param
	end
	


	try
		% finally find both
		[~,vm.seed] = lib.module.find(...
			'query',		resp,...
			'model',		vm.seed,...
			'fSolution',	{@(vm,list) lib.model.tov.rar.nlinfit.beta0_W0(vm,list)} ...
		);
	catch
		% find only right plateau mass first
		[~,vm.seed] = lib.module.find(...
			'query',		resp(1),...
			'model',		vm.seed,...
			'fSolution',	{
				@(vm,list) script.gosect.beta0('qbeta0', 5E-1, 'model', vm, 'list', list)
				@(vm,list) script.nlinfit.beta0('model', vm, 'list', list)
			} ...
		);

		% then find right surface mass only
		[~,vm.seed] = lib.module.find(...
			'query',		resp(2),...
			'model',		vm.seed,...
			'fSolution',	{
				@(vm,list) script.gosect.W0('dW0', 1E-1, 'model', vm, 'list', list)
				@(vm,list) script.gosect.W0('dW0', 1, 'model', vm, 'list', list)
				@(vm,list) script.gosect.W0('dW0', 10, 'model', vm, 'list', list)
				@(vm,list) script.nlinfit.W0('model', vm, 'list', list)
			} ...
		);
	
		% finally find both
		[~,vm.seed] = lib.module.find(...
			'query',		resp,...
			'model',		vm.seed,...
			'fSolution',	{@(vm,list) lib.model.tov.rar.nlinfit.beta0_W0(vm,list)} ...
		);
	end
		
	T.cuspy.push(vm.seed);
end

lib.save('export/TblWithCutoffAnalysisMpMs.mat',T);
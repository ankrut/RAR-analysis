function createProfileGrid

% set seed model struct
opts		= struct('xmax', 1E20, 'tau', 1E-16, 'rtau', 1E-4);
param.seed	= struct('beta0', 1E-6, 'W0', 200);
vm.seed		= struct('param', param.seed, 'options', opts);

% nlinfit options cascade
nlOpts				= statset('nlinfit');
nlOpts.FunValCheck	= 'off';
nlOpts.MaxIter		= 50;


% low temperature and diluted core (is profile)
vm.is = lib.struct.setfield(vm.seed,'param/theta0',-20);
TblProfileTheta0Low.is = model.tov.rar.profile('model',vm.is);


% low temperature and core transitions
vm.trans = lib.struct.setfield(vm.seed,'param/theta0',15);
grid = linspace(log10(2.759241261414426e-09),log10(1.799464590755103e-06),21); % for theta0 = 15 -- -5
TblProfileTheta0Low.trans = script.createGrid(...
	'key',			'log_rhoh_rho0',...
	'grid',			grid,...
	'model',		vm.trans,...
	'fSearch',		@script.theta0.findSolution,...
	'search',		{'nlinfit', {'options', nlOpts}} ...
);

% low temperature and degenerate core
vm.cored = lib.struct.setfield(vm.seed,'param/theta0',15);
grid = linspace(log10(2.759241261414426e-09),log10(5.810139731030533e-21),21); % for theta0 = 15 -- 50
TblProfileTheta0Low.cored = script.createGrid(...
	'key',			'log_rhoh_rho0',...
	'grid',			grid,...
	'model',		vm.cored,...
	'fSearch',		@script.theta0.findSolution,...
	'search',		{'nlinfit', {'options', nlOpts}} ...
);

lib.save('export/TblProfileTheta0Low.mat',TblProfileTheta0Low)


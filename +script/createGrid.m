function T = createGrid(varargin)
Q = module.struct(...
	'search',	{},...
	'list',		module.array(),...
	varargin{:} ...
);

% destructure
T			= Q.list;
key			= Q.key;
xgrid		= Q.grid;
vm			= Q.model;
fSearch		= Q.fSearch;
fx			= @(t) t.query.(key);

for ii=1:numel(xgrid)
	x = xgrid(ii);
	
	fprintf('\n--- [%d/%d : %5E] -------------------------\n',ii,numel(xgrid),x);
	
	if T.filter(@(t) lib.isequal(log(fx(t)),log(x),5)).length > 0
		continue
	end

	if T.length > 2 && isfield(Q,'fEstimate')
		vm = Q.fEstimate(x,fx,vm,T,3);
	end

	try [~,vm,chi2] = fSearch(...
			'query',		{key, x},...
			'model',		vm, ...
			'searchCfg',	Q.searchCfg,...
			Q.search{:} ...
		);
	
		
		T.push(struct(...
			'query',		module.struct(key, x),...
			'model',		vm,...
			'chi2',			chi2 ...
		));
	catch
		fprintf('NO SOLUTION FOUND :(\n');
	end
end
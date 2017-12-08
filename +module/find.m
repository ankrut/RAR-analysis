function [SOL,varargout] = find(varargin)
Q = module.struct(...
	'tau',		1E-6,...
	varargin{:}...
); 

% destructure (Q.query, Q.model, Q.searchCfg)
switch class(Q.query)
	case 'cell'
	q	 = module.struct(Q.query{:});
	list = convertQueryToResponselist(q,Q.ResponseList);
	
	case 'struct'
	q	 = Q.query;
	list = convertQueryToResponselist(q,Q.ResponseList);
	
	case 'module.ProfileResponse'
	list = module.ProfileResponseList(Q.query);
	
	case 'moduleProfileResponseList'
	list = Q.query;
	
	otherwise
	error('unknown query type');
end

vm		= Q.model;
fChi2	= @(SOL) list.chi2(SOL);

nn			= numel(Q.fSolution);
chi2(1:nn)	= nan;

for ii = 1:nn
	if isnan(min(chi2)) || min(chi2) > Q.tau
		try
			fprintf('\n');
			[SOL(ii),VM(ii)] = Q.fSolution{ii}(vm,list);
			chi2(ii)		 = fChi2(SOL(ii));
		end
	end
end

if isnan(min(chi2))
	error('no solution found')
end

% select best solution
kk				= chi2 == min(chi2);
SOL				= SOL(kk);
varargout{1}	= VM(kk);
varargout{2}	= chi2(kk);

function list = convertQueryToResponselist(q,ResponseList)
list = module.array(fieldnames(q)).map(@(key) ...
	createResponse(ResponseList.(key),q.(key)) ...
).pipe(@module.ProfileResponseList);

function elm = createResponse(response,prediction)
if numel(prediction) == 1
	elm = module.ProfileResponse(response,prediction);
else
	elm = module.ProfileResponse(response(prediction(1:end-1)),prediction(end));
end
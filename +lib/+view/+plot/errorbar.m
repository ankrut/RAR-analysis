function varargout = errorbar(varargin)
Q = module.struct(...
	'errorbar', {},...
	varargin{:}...
);

if isfield(Q,'profile')
	switch class(Q.x)
		case {'module.ProfileMapping','module.ProfileAxis'}
		X = Q.x.map(Q.profile);
		
		case 'function_handle'
		X = Q.x(Q.profile);
		
		case 'double'
		X = Q.x;
	end
	
	
	switch class(Q.y)
		case {'module.ProfileMapping','module.ProfileAxis'}
		Y = Q.y.map(Q.profile);
		
		case 'function_handle'
		Y = Q.y(Q.profile);
		
		case 'double'
		Y = Q.y;
	end
	
	switch class(Q.dy)
		case {'module.ProfileMapping','module.ProfileAxis'}
		DY = Q.dy.map(Q.profile);
		
		case 'function_handle'
		DY = Q.dy(Q.profile);
		
		case 'double'
		DY = Q.dy;
	end
end

[varargout{1:nargout}] = errorbar(X,Y,DY,Q.errorbar{:});
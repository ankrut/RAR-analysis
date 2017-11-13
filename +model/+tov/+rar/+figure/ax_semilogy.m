function ax = ax_semilogy(varargin)
Q = module.struct(varargin{:});

AX = {
	'YScale',			'log',...
};

if isfield(Q,'axes')
	Q.axes = [Q.axes(:);AX(:)];
else
	Q.axes = AX;
end

ax = lib.struct.pipe(Q,@model.tov.rar.figure.ax);
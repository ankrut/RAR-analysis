function ax = ax_semilogx(varargin)
Q = module.struct(varargin{:});

AX = {
	'XScale',			'log',...
};

if isfield(Q,'axes')
	Q.axes = [Q.axes(:);AX(:)];
else
	Q.axes = AX;
end

ax = lib.struct.pipe(Q,@model.tov.rar.figure.ax);
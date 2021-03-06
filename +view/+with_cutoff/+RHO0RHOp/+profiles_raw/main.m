function main
P			= load('export/CacheWithCutoffProfilesRHO0RHOp.mat');
STYLE		= lib.require(@configs.style_profiles);
AXIS.raw	= lib.require(@lib.model.tov.rar.axes.raw);
fh			= view.with_cutoff.RHO0RHOp.profiles_raw.figure();

% makeup
for ii = 1:P.RHO0RHOp.length
	P.RHO0RHOp.data{ii}.data.density(end) = realmin;
end

% show figure
figure(fh);

% density
axes(fh.UserData.axes(3,1));

hg.cuspy = hggroup(STYLE.fdgroup{:});
P.RHO0RHOp.forEach(@(p) lib.view.plot.curve2D(...
	'data', p,...
	'x',	AXIS.raw.radius,...
	'y',	AXIS.raw.density,...
	'plot',	[STYLE.fd,{'Parent',hg.cuspy}] ...
));


% velocity
axes(fh.UserData.axes(2,1));

hg.cuspy = hggroup(STYLE.fdgroup{:});
P.RHO0RHOp.forEach(@(p) lib.view.plot.curve2D(...
	'data', p,...
	'x',	AXIS.raw.radius,...
	'y',	AXIS.raw.velocity,...
	'plot',	[STYLE.fd,{'Parent',hg.cuspy}]...
));


% mass
axes(fh.UserData.axes(1,1));

hg.cuspy = hggroup(STYLE.fdgroup{:});
P.RHO0RHOp.forEach(@(p) lib.view.plot.curve2D(...
	'data', p,...
	'x',	AXIS.raw.radius,...
	'y',	AXIS.raw.mass,...
	'plot',	[STYLE.fd,{'Parent',hg.cuspy}]...
));

% legend
% axes(fh.UserData.axes(1,1));
% lib.view.plot.legend([],'location','northwest');

% save
lib.view.latex.figure(...
	'path',		'export/with-cutoff/RHO0RHOp-profiles-raw/',...
	'figure',	fh,...
	'label',	'fig:profiles:without-cutoff:RHO0RHOp:raw',...
	'caption',	fileread('+view/+with_cutoff/+RHO0RHOp/+profiles_raw/caption.txt') ...
);

function vline(x,y,varargin)
lib.view.plot.vline(x,'Color', [1 1 1]*0.7, 'LineStyle',':',varargin{:});
plot(x,y,'Marker','o', 'MarkerFaceColor', 'w', 'MarkerEdgeColor','w','MarkerSize',10);
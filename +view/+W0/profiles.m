function profiles
P			= load('export/CacheProfileW0.mat');
AXIS.center	= lib.require(@model.tov.rar.axes.center);
AXIS.core	= lib.require(@model.tov.rar.axes.core);

AR			= AXIS.core.radius;
ARHO		= AXIS.center.density;
AV			= AXIS.core.velocity;
AM			= AXIS.core.mass;


AX.radius = struct(...
	'format',		'$%s/%s$',...
	'mapmodel',		AR.mapmodel,...
	'scalemodel',	AR.scalemodel ...
);

AX.density = struct(...
	'format',		'$%s/%s$',...
	'mapmodel',		ARHO.mapmodel,...
	'scalemodel',	ARHO.scalemodel ...
);

AX.velocity = struct(...
	'format',		'$%s/%s$',...
	'mapmodel',		AV.mapmodel,...
	'scalemodel',	AV.scalemodel ...
);

AX.mass = struct(...
	'format',		'$%s/%s$',...
	'mapmodel',		AM.mapmodel,...
	'scalemodel',	AM.scalemodel ...
);

C = lib.color.lines(5);

STYLE.fd.color		= 'k';
STYLE.cored.color	= [1 1 1]*0.5;
STYLE.cuspy.color	= C{5};
STYLE.deficit.color = C{4};
STYLE.disrupt.color = C{2};


% makeup
for ii = 1:P.cored.length
	P.cored.data{ii}.data.density(end) = realmin;
end
for ii = 1:P.cuspy.length
	P.cuspy.data{ii}.data.density(end) = realmin;
end
for ii = 1:P.deficit.length
	P.deficit.data{ii}.data.density(end) = realmin;
end
for ii = 1:P.disrupt.length
	P.disrupt.data{ii}.data.density(end) = realmin;
end


function plot_density(p,varargin)
	lib.view.plot.curve2D(p,AR,ARHO,varargin{:});
end

function plot_velocity(p,varargin)
	lib.view.plot.curve2D(p,AR,AV,varargin{:});
end

function plot_mass(p,varargin)
	lib.view.plot.curve2D(p,AR,AM,varargin{:});
end


for ii=1:3
	ax(3,ii) = model.tov.rar.figure.ax_loglog('xlabel',AX.radius,'ylabel',AX.density);
	ax(2,ii) = model.tov.rar.figure.ax_loglog('xlabel',AX.radius,'ylabel',AX.velocity);
	ax(1,ii) = model.tov.rar.figure.ax_loglog('xlabel',AX.radius,'ylabel',AX.mass);
end

fh = module.sapthesis.figure_grid(ax,'axHeight','equal','figure',{'FileName','profiles'});
figure(fh);



axes(fh.UserData.axes(1,1));
xlim([1E-5,1E10])
ylim([1E-4,1E10])
set(gca,'XTick',10.^(-4:4:9));
set(gca,'YTick',10.^(-3:3:9));
set(gca,'YMinorTick','off');
P.cored.forEach(@(p) plot_mass(p,'color',STYLE.cored.color));
P.cored.pick(1).forEach(@(p) plot_mass(p,'color',STYLE.fd.color));

axes(fh.UserData.axes(1,2));
ylim([1E-4,1E10])
set(gca,'XTick',10.^(-4:4:9));
set(gca,'YTick',10.^(-3:3:9));
set(gca,'YMinorTick','off');
P.cuspy.forEach(@(p) plot_mass(p,'color',STYLE.cuspy.color));
P.cored.pick(1).forEach(@(p) plot_mass(p,'color',STYLE.fd.color));

axes(fh.UserData.axes(1,3));
ylim([1E-4,1E10])
set(gca,'XTick',10.^(-4:4:9));
set(gca,'YTick',10.^(-3:3:9));
set(gca,'YMinorTick','off');
P.deficit.forEach(@(p) plot_mass(p,'color',STYLE.deficit.color));
P.disrupt.forEach(@(p) plot_mass(p,'color',STYLE.disrupt.color));
P.cored.pick(11).forEach(@(p) plot_mass(p,'color',STYLE.fd.color));



axes(fh.UserData.axes(2,1));
ylim([2E-5,2])
set(gca,'XTick',10.^(-4:4:9));
set(gca,'YTick',10.^(-5:1:0));
set(gca,'YMinorTick','off');
P.cored.forEach(@(p) plot_velocity(p,'color',STYLE.cored.color));
P.cored.pick(1).forEach(@(p) plot_velocity(p,'color',STYLE.fd.color));

axes(fh.UserData.axes(2,2));
ylim([2E-5,2])
set(gca,'XTick',10.^(-4:4:9));
set(gca,'YTick',10.^(-5:1:0));
set(gca,'YMinorTick','off');
P.cuspy.forEach(@(p) plot_velocity(p,'color',STYLE.cuspy.color));
P.cored.pick(1).forEach(@(p) plot_velocity(p,'color',STYLE.fd.color));

axes(fh.UserData.axes(2,3));
ylim([2E-5,2])
set(gca,'XTick',10.^(-4:4:9));
set(gca,'YTick',10.^(-5:1:0));
set(gca,'YMinorTick','off');
P.deficit.forEach(@(p) plot_velocity(p,'color',STYLE.deficit.color));
P.disrupt.forEach(@(p) plot_velocity(p,'color',STYLE.disrupt.color));
P.cored.pick(1).forEach(@(p) plot_velocity(p,'color',STYLE.fd.color));



axes(fh.UserData.axes(3,1));
ylim([1E-30,1E1])
set(gca,'XTick',10.^(-4:4:9));
set(gca,'YTick',10.^(-28:7:0));
set(gca,'YMinorTick','off');
P.cored.forEach(@(p) plot_density(p,'color',STYLE.cored.color));
P.cored.pick(1).forEach(@(p) plot_density(p,'color',STYLE.fd.color));
% text(0.95,0.95,'cored','HorizontalAlignment','right','VerticalAlignment','top','Units','normalized')
title('cored')

axes(fh.UserData.axes(3,2));
ylim([1E-30,1E1])
set(gca,'XTick',10.^(-4:4:9));
set(gca,'YTick',10.^(-28:7:0));
set(gca,'YMinorTick','off');
P.cuspy.forEach(@(p) plot_density(p,'color',STYLE.cuspy.color));
P.cored.pick(1).forEach(@(p) plot_density(p,'color',STYLE.fd.color));
% text(0.95,0.95,'cuspy','HorizontalAlignment','right','VerticalAlignment','top','Units','normalized')
title('cuspy')

axes(fh.UserData.axes(3,3));
ylim([1E-30,1E1])
set(gca,'XTick',10.^(-4:4:9));
set(gca,'YTick',10.^(-28:7:0));
set(gca,'YMinorTick','off');
P.deficit.forEach(@(p) plot_density(p,'color',STYLE.deficit.color));
P.disrupt.forEach(@(p) plot_density(p,'color',STYLE.disrupt.color));
P.cored.pick(1).forEach(@(p) plot_density(p,'color',STYLE.fd.color));
% text(0.95,0.95,'deficit','HorizontalAlignment','right','VerticalAlignment','top','Units','normalized')
title('deficit')



lib.view.file.figure(fh,'export/W0');
end



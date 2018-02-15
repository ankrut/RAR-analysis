function fh=figure_grid(ax,varargin)
% default values
WIDTH		= 17;
HEIGHT		= 17*3/4;
PADDING		= struct('top', 0.6, 'left', 1.5, 'right', 0.5, 'bottom', 1.5);

Q = lib.module.struct(...
	'width',		WIDTH,...
	'height',		HEIGHT,...
	'padding',		PADDING,...
	'showLabels',	'auto',...
	'figure',		{},...
	varargin{:}...
);

% destructure
WIDTH		= Q.width;
PADDING		= Q.padding;

try
	switch class(Q.axWidth)
	case 'double'
		AXWIDTH = Q.axWidth;
		
% 		case 'char'
% 		switch Q.axHeight
% 			case 'equal'
% 			AXWIDTH = AXHEIGHT;
% 			
% 			otherwise
% 			error('axHeight keyword not defined');
% 		end
		
		otherwise
		error('wrong axWidth type');
	end
	
	WIDTH = AXWIDTH*size(ax,2) + PADDING.left + PADDING.right;
catch
	AXWIDTH = (WIDTH - PADDING.left - PADDING.right)/size(ax,2);
end


try	
	switch class(Q.axHeight)
		case 'double'
		AXHEIGHT = Q.axHeight;
		
		case 'function_handle'
		AXHEIGHT = Q.axHeight(AXWIDTH);
		
		case 'char'
		switch Q.axHeight
			case 'equal'
			AXHEIGHT = AXWIDTH;
			
			otherwise
			error('axHeight keyword not defined');
		end
		
		otherwise
		error('wrong axHeight type');
	end
	
	HEIGHT = AXHEIGHT*size(ax,1) + PADDING.top + PADDING.bottom;
catch
	AXHEIGHT = (HEIGHT - PADDING.top - PADDING.bottom)/size(ax,1);
end


DIM = struct(...
	'width',	WIDTH,...
	'padding',	PADDING,...
	'height',	HEIGHT,...
	'grid',		size(ax) ...
);

fh = figure(...
	'Visible',					'off',...
	'Color',					[1 1 1],...
	'defaulttextinterpreter',	'latex',...
	'Units',					'centimeters',...
	'PaperUnits',				'centimeters',...
	'PaperSize',				[DIM.width DIM.height],...
	'PaperPosition',			[0,0,DIM.width,DIM.height],...
	Q.figure{:}...
);

fh.Position(2) = fh.Position(2) - (DIM.height - fh.Position(4));
fh.Position(3) = DIM.width;
fh.Position(4) = DIM.height;

% AXWIDTH		= (DIM.width - (DIM.padding.left + DIM.padding.right))/DIM.grid(2);
% AXHEIGHT	= (DIM.height - (DIM.padding.bottom + DIM.padding.top))/DIM.grid(1);

% hide ticks and labels
if strcmp(Q.showLabels, 'auto')
	set(ax(2:size(ax,1),:),'XTickLabel',[]);
	set(ax(2:size(ax,1),:),'XLabel',[]);
	set(ax(:,2:size(ax,2)),'YTickLabel',[]);
	set(ax(:,2:size(ax,2)),'YLabel',[]);
end

for ii = 0:size(ax,2)-1
for jj = 0:size(ax,1)-1
	if isa(ax(jj+1,ii+1),'matlab.graphics.GraphicsPlaceholder')
		continue
	end
	
	set(ax(jj+1,ii+1),...
		'Parent',			fh,...
		'Units',			'centimeter',...
		'Position',			[(DIM.padding.left + ii*AXWIDTH) (DIM.padding.bottom + jj*AXHEIGHT) AXWIDTH AXHEIGHT] ...
	);
end
end


fh.UserData.dim = DIM;
fh.UserData.axes = ax;
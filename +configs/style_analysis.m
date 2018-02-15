% styles
C = lib.color.lines(1);
EXPORT.center	= {'color',[1 1 1]*0.5,'LineWidth',2,'LineStyle', '-','DisplayName','center'};
EXPORT.core		= {'color',C{1},'LineStyle', '-','DisplayName','core'};
EXPORT.plateau	= {'color',C{1},'LineStyle', '-.','DisplayName','plateau'};
EXPORT.halo		= {'color',C{1},'LineStyle', '--','DisplayName','halo'};
EXPORT.surface	= {'color','k','LineWidth',2,'DisplayName','surface'};
MAP		= lib.require(@lib.model.tov.rar.map);
SCALE	= lib.require(@lib.model.tov.rar.scale);

fLabelUnit		= @(Q) lib.sprintf('$%s/%s$', Q.map.label, Q.scale.label);
fLabelUnitless	= @(Q) lib.sprintf('$%s$', Q.map.label);

% define axis
EXPORT.radius			= lib.module.ProfileAxis('map', MAP.radius,				'scale', SCALE.raw.radius,			'label', fLabelUnit);
EXPORT.density			= lib.module.ProfileAxis('map', MAP.cache.density,		'scale', SCALE.raw.density,			'label', fLabelUnit);
EXPORT.pressure			= lib.module.ProfileAxis('map', MAP.cache.pressure,		'scale', SCALE.raw.pressure,		'label', fLabelUnit);
EXPORT.mass				= lib.module.ProfileAxis('map', MAP.mass,				'scale', SCALE.raw.mass,			'label', fLabelUnit);
EXPORT.velocity			= lib.module.ProfileAxis('map', MAP.velocity,			'scale', SCALE.raw.velocity,		'label', fLabelUnit);
EXPORT.velDisp			= lib.module.ProfileAxis('map', MAP.velocity_dispersion,'scale', SCALE.raw.velocity,		'label', fLabelUnit);
EXPORT.speedOfSound		= lib.module.ProfileAxis('map', MAP.velocitySOS,		'scale', SCALE.raw.velocity,		'label', fLabelUnit);
EXPORT.massDiff			= lib.module.ProfileAxis('map', MAP.massDiff,			'scale', SCALE.raw.radiusInverse,	'label', fLabelUnit);
EXPORT.degeneracyDiff	= lib.module.ProfileAxis('map', MAP.degeneracyDiff,		'scale', SCALE.raw.radiusInverse,	'label', fLabelUnit);

EXPORT.potential		= lib.module.ProfileAxis('map', MAP.potential,	'label', fLabelUnitless);
EXPORT.compactness		= lib.module.ProfileAxis('map', MAP.compactness,'label', fLabelUnitless);
EXPORT.degeneracy		= lib.module.ProfileAxis('map', MAP.degeneracy,	'label', fLabelUnitless);
EXPORT.cutoff			= lib.module.ProfileAxis('map', MAP.cutoff,		'label', fLabelUnitless);

% define makeups axis (experimental)
EXPORT.makeup.radius	= lib.module.ProfileAxis('map', MAP.makeup.radius,		'scale', SCALE.raw.radius);
EXPORT.makeup.density	= lib.module.ProfileAxis('map', MAP.makeup.density,		'scale', SCALE.raw.density);
EXPORT.makeup.pressure	= lib.module.ProfileAxis('map', MAP.makeup.pressure,	'scale', SCALE.raw.pressure);
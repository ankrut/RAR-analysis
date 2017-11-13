MAP		= lib.require(@model.tov.rar.map);
SCALE	= lib.require(@model.tov.rar.scale);

% define axis
EXPORT.radius			= module.ProfileAxis(MAP.radius,				SCALE.raw.radius);
EXPORT.density			= module.ProfileAxis(MAP.cache.density,			SCALE.raw.density);
EXPORT.pressure			= module.ProfileAxis(MAP.cache.pressure,		SCALE.raw.pressure);
EXPORT.potential		= module.ProfileAxis(MAP.potential);
EXPORT.mass				= module.ProfileAxis(MAP.mass,					SCALE.raw.mass);
EXPORT.velocity			= module.ProfileAxis(MAP.velocity,				SCALE.raw.velocity);
EXPORT.velDisp			= module.ProfileAxis(MAP.velocity_dispersion,	SCALE.raw.velocity);
EXPORT.speedOfSound		= module.ProfileAxis(MAP.velocitySOS,			SCALE.raw.velocity);
EXPORT.compactness		= module.ProfileAxis(MAP.compactness);
EXPORT.degeneracy		= module.ProfileAxis(MAP.degeneracy);
EXPORT.cutoff			= module.ProfileAxis(MAP.cutoff);
EXPORT.massDiff			= module.ProfileAxis(MAP.massDiff,				SCALE.raw.radiusInverse);
EXPORT.degeneracyDiff	= module.ProfileAxis(MAP.degeneracyDiff,		SCALE.raw.radiusInverse);


% set makeups
EXPORT.makeup.radius	= module.ProfileAxis(MAP.makeup.radius,			SCALE.raw.radius);
EXPORT.makeup.density	= module.ProfileAxis(MAP.makeup.density,		SCALE.raw.density);
EXPORT.makeup.pressure	= module.ProfileAxis(MAP.makeup.pressure,		SCALE.raw.pressure);
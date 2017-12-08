MAP		= lib.require(@model.tov.rar.map);
SCALE	= lib.require(@model.tov.rar.scale);

% define axis
EXPORT.radius			= module.ProfileAxis(MAP.radius,			SCALE.astro.radius);
EXPORT.density			= module.ProfileAxis(MAP.cache.density,		SCALE.astro.density);
EXPORT.pressure			= module.ProfileAxis(MAP.cache.pressure,	SCALE.astro.pressure);
EXPORT.mass				= module.ProfileAxis(MAP.mass,				SCALE.astro.mass);
EXPORT.velocity			= module.ProfileAxis(MAP.velocity,			SCALE.astro.velocity);
EXPORT.velocityRMS		= module.ProfileAxis(MAP.velocityRMS,		SCALE.astro.velocity);
EXPORT.massDiff			= module.ProfileAxis(MAP.massDiff,			SCALE.astro.massDiff);
EXPORT.degeneracyDiff	= module.ProfileAxis(MAP.degeneracyDiff,	SCALE.astro.degeneracyDiff);

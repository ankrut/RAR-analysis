MAP		= lib.require(@model.tov.rar.map);
SCALE	= lib.require(@model.tov.rar.scale);

% define axis
EXPORT.radius			= module.ProfileAxis(MAP.radius,				SCALE.halo.radius);
EXPORT.density			= module.ProfileAxis(MAP.cache.density,			SCALE.halo.density);
EXPORT.pressure			= module.ProfileAxis(MAP.cache.pressure,		SCALE.halo.pressure);
EXPORT.pressure			= module.ProfileAxis(MAP.potential,				SCALE.halo.potential);
EXPORT.mass				= module.ProfileAxis(MAP.mass,					SCALE.halo.mass);
EXPORT.velocity			= module.ProfileAxis(MAP.velocity,				SCALE.halo.velocity);
EXPORT.compactness		= module.ProfileAxis(MAP.compactness,			SCALE.halo.compactness);
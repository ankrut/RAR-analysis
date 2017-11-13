MAP		= lib.require(@model.tov.rar.map);
SCALE	= lib.require(@model.tov.rar.scale);

% define axis
EXPORT.radius			= module.ProfileAxis(MAP.radius,				SCALE.core.radius);
EXPORT.density			= module.ProfileAxis(MAP.cache.density,			SCALE.core.density);
EXPORT.pressure			= module.ProfileAxis(MAP.cache.pressure,		SCALE.core.pressure);
EXPORT.pressure			= module.ProfileAxis(MAP.potential,				SCALE.core.potential);
EXPORT.mass				= module.ProfileAxis(MAP.mass,					SCALE.core.mass);
EXPORT.velocity			= module.ProfileAxis(MAP.velocity,				SCALE.core.velocity);
EXPORT.compactness		= module.ProfileAxis(MAP.compactness,			SCALE.core.compactness);
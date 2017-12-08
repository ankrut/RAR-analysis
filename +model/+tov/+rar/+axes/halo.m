ANCH	= lib.require(@model.tov.rar.anchor);
MAP		= lib.require(@model.tov.rar.map);
SCALE	= lib.require(@model.tov.rar.scale);

% define axis
EXPORT.radius			= module.ProfileAxis(MAP.radius,				SCALE.halo.radius);
EXPORT.density			= module.ProfileAxis(MAP.cache.density,			SCALE.halo.density);
EXPORT.pressure			= module.ProfileAxis(MAP.cache.pressure,		SCALE.halo.pressure);
EXPORT.potential		= module.ProfileAxis(MAP.potential,				SCALE.halo.potential);
EXPORT.mass				= module.ProfileAxis(MAP.mass,					SCALE.halo.mass);
EXPORT.velocity			= module.ProfileAxis(MAP.velocity,				SCALE.halo.velocity);
EXPORT.compactness		= module.ProfileAxis(MAP.compactness,			SCALE.halo.compactness);
EXPORT.degeneracy		= module.ProfileAxis(@(obj) MAP.degeneracy.map(obj) - ANCH.velocity_halo.map(obj,MAP.degeneracy));
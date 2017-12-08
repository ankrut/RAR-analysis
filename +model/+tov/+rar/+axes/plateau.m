ANCH	= lib.require(@model.tov.rar.anchor);
MAP		= lib.require(@model.tov.rar.map);
SCALE	= lib.require(@model.tov.rar.scale);

% define axis
EXPORT.radius			= module.ProfileAxis(MAP.radius,				SCALE.plateau.radius);
EXPORT.density			= module.ProfileAxis(MAP.cache.density,			SCALE.plateau.density);
EXPORT.pressure			= module.ProfileAxis(MAP.cache.pressure,		SCALE.plateau.pressure);
EXPORT.potential		= module.ProfileAxis(MAP.potential,				SCALE.plateau.potential);
EXPORT.mass				= module.ProfileAxis(MAP.mass,					SCALE.plateau.mass);
EXPORT.velocity			= module.ProfileAxis(MAP.velocity,				SCALE.plateau.velocity);
EXPORT.compactness		= module.ProfileAxis(MAP.compactness,			SCALE.plateau.compactness);
EXPORT.degeneracy		= module.ProfileAxis(@(obj) MAP.degeneracy.map(obj) - ANCH.velocity_plateau.map(obj,MAP.degeneracy));
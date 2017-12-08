MAP		= lib.require(@model.tov.rar.map);
SCALE	= lib.require(@model.tov.rar.scale);

% define axis
EXPORT.radius			= module.ProfileAxis(MAP.radius,				SCALE.SI.radius);
EXPORT.density			= module.ProfileAxis(MAP.cache.density,			SCALE.SI.density);
EXPORT.pressure			= module.ProfileAxis(MAP.cache.pressure,		SCALE.SI.pressure);
EXPORT.potential		= module.ProfileAxis(MAP.potential);
EXPORT.mass				= module.ProfileAxis(MAP.mass,					SCALE.SI.mass);
EXPORT.velocity			= module.ProfileAxis(MAP.velocity,				SCALE.SI.velocity);
EXPORT.velDisp			= module.ProfileAxis(MAP.velocity_dispersion,	SCALE.SI.velocity);
EXPORT.speedOfSound		= module.ProfileAxis(MAP.velocitySOS,			SCALE.SI.velocity);
EXPORT.compactness		= module.ProfileAxis(MAP.compactness);
EXPORT.degeneracy		= module.ProfileAxis(MAP.degeneracy);
EXPORT.cutoff			= module.ProfileAxis(MAP.cutoff);
% EXPORT.massDiff			= module.ProfileAxis(MAP.massDiff,				SCALE.SI.radiusInverse);
% EXPORT.degeneracyDiff	= module.ProfileAxis(MAP.degeneracyDiff,		SCALE.SI.radiusInverse);

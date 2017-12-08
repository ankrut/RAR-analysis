MAP		= lib.require(@model.tov.rar.map);
SCALE	= lib.require(@model.tov.rar.scale);

% define axis
EXPORT.density			= module.ProfileAxis(MAP.cache.density,			SCALE.central.density);
EXPORT.pressure			= module.ProfileAxis(MAP.cache.pressure,		SCALE.central.pressure);
EXPORT.degeneracy		= module.ProfileAxis(@(obj) MAP.degeneracy.map(obj) - obj.data.theta0);
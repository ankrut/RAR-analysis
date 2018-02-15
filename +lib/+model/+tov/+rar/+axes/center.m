MAP		= lib.require(@lib.model.tov.rar.map);
SCALE	= lib.require(@lib.model.tov.rar.scale);


fLabel = @(Q) lib.sprintf('$%s/%s$', Q.map.label, Q.scale.label);

% define axis
EXPORT.density			= lib.module.ProfileAxis('map', MAP.cache.density,		'scale', SCALE.central.density,		'label', fLabel);
EXPORT.pressure			= lib.module.ProfileAxis('map', MAP.cache.pressure,		'scale', SCALE.central.pressure,	'label', fLabel);
EXPORT.degeneracy		= lib.module.ProfileAxis('map', @(obj) obj.data.theta0 - MAP.degeneracy.map(obj), 'label', '$\theta_0 - \theta(r)$');
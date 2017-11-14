ANCH	= lib.require(@model.tov.rar.anchor);
MAP		= lib.require(@model.tov.rar.map);

EXPORT.ResponseList.rs		= @(obj) ANCH.surface.map(obj,MAP.radius);
EXPORT.ResponseList.rh		= @(obj) ANCH.velocity_halo.map(obj,MAP.radius);
EXPORT.ResponseList.rp		= @(obj) ANCH.velocity_plateau.map(obj,MAP.radius);
EXPORT.ResponseList.rc		= @(obj) ANCH.velocity_core.map(obj,MAP.radius);

EXPORT.ResponseList.rsorh	= @(obj) ANCH.surface.map(obj,MAP.radius)/ANCH.velocity_halo.map(obj,MAP.radius);
EXPORT.ResponseList.rsorp	= @(obj) ANCH.surface.map(obj,MAP.radius)/ANCH.velocity_plateau.map(obj,MAP.radius);
EXPORT.ResponseList.rsorc	= @(obj) ANCH.surface.map(obj,MAP.radius)/ANCH.velocity_core.map(obj,MAP.radius);

EXPORT.ResponseList.rporc	= @(obj) ANCH.velocity_plateau.map(obj,MAP.radius)/ANCH.velocity_core.map(obj,MAP.radius);


EXPORT.ResponseList.rhop_rho0	= @(obj) ANCH.velocity_plateau.map(obj,MAP.density)/ANCH.center.map(obj,MAP.density);


EXPORT.tau					= 1E-6;
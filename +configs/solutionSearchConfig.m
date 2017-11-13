ANCH	= lib.require(@model.tov.rar.anchor);
MAP		= lib.require(@model.tov.rar.map);

EXPORT.ResponseList.rs		= @(obj) ANCH.surface.map(obj,MAP.radius);
EXPORT.ResponseList.rsorp	= @(obj) ANCH.surface.map(obj,MAP.radius)/ANCH.velocity_plateau.map(obj,MAP.radius);
EXPORT.ResponseList.rsorc	= @(obj) ANCH.surface.map(obj,MAP.radius)/ANCH.velocity_core.map(obj,MAP.radius);

EXPORT.tau					= 1E-6;
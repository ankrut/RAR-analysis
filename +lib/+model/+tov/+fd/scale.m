lib.module.constraints
ANCH = lib.require(@lib.model.tov.fd.anchor);
MAP  = lib.require(@lib.model.tov.fd.map);

% load TOV defaults
EXPORT = lib.require(@lib.model.tov.scale);

% RAW SCALE
EXPORT.raw.density			= lib.module.ProfileMapping(1,'\rho');
EXPORT.raw.particle_density	= lib.module.ProfileMapping(1,'\rho/m');
EXPORT.raw.pressure			= lib.module.ProfileMapping(1,'\rho c^2');
EXPORT.raw.temperature		= lib.module.ProfileMapping(1,'mc^2/k_B');


% SI SCALE
EXPORT.SI.radius = lib.module.ProfileMapping(...
	@(obj) pi^(1/4)/sqrt(2)*(mp/obj.data.m)^2*lp,...
	'\mathrm{m}' ...
);

EXPORT.SI.mass = lib.module.ProfileMapping(...
	@(obj) 1/2*pi^(1/4)/sqrt(2)*(mp/obj.data.m)^2*mp,...
	'\mathrm{kg}'...
);

EXPORT.SI.acceleration = lib.module.ProfileMapping(...
	@(obj) c^2/EXPORT.SI.radius.map(obj),...
	'\mathrm{m/s^2}'...
);

EXPORT.SI.density = lib.module.ProfileMapping(...
	@(obj) 2*obj.data.m^4/h^3*c^3*pi^(3/2),...
	'\mathrm{kg}/\mathrm{m}^3');

EXPORT.SI.particledensity = lib.module.ProfileMapping(...
	@(obj) 2*obj.data.m^3/h^3*c^3*pi^(3/2),...
	'\mathrm{m}^{-3}');

EXPORT.SI.pressure = lib.module.ProfileMapping(...
	@(obj) EXPORT.SI.density.map(obj)*c^2,...
	'N/m^2'...
);

EXPORT.SI.particle_mass = lib.module.ProfileMapping(...
	@(obj) obj.data.m,...
	'\mathrm{kg}'...
);

EXPORT.SI.temperature_SI = lib.module.ProfileMapping(...
	@(obj) obj.data.m*c^2/kB,...
	'K'...
);


% CGS SCALE
EXPORT.cgs.density = lib.module.ProfileMapping(...
	@(obj) EXPORT.SI.density.map(obj)/1E-3,...
	'\mathrm{g}/\mathrm{cm}^3');



% ASTRO SCALE
EXPORT.astro.radius = lib.module.ProfileMapping(...
	@(obj) EXPORT.SI.radius.map(obj)/parsec,...
	'\mathrm{pc}' ...
);

EXPORT.astro.radius_kpc = lib.module.ProfileMapping(...
	@(obj) EXPORT.SI.radius.map(obj)/kpc,...
	'\mathrm{pc}' ...
);

EXPORT.astro.mass = lib.module.ProfileMapping(...
	@(obj) EXPORT.SI.mass.map(obj)/Msun,...
	'M_\odot'...
);

EXPORT.astro.massDiff = lib.module.ProfileMapping(...
	@(obj) EXPORT.SI.mass.map(obj)/Msun/(EXPORT.SI.radius.map(obj)/parsec),...
	'M_\odot/\mathrm{pc}'...
);

EXPORT.astro.density = lib.module.ProfileMapping(...
	@(obj) EXPORT.SI.density.map(obj)/(Msun/parsec^3),...
	'M_\odot/\mathrm{pc}^3' ...
);

EXPORT.astro.pressure = lib.module.ProfileMapping(...
	@(obj) EXPORT.SI.density.map(obj)/(c^2*Msun/parsec^3),...
	'c^2 M_\odot/\mathrm{pc}^3' ...
);

EXPORT.astro.particledensity = lib.module.ProfileMapping(...
	@(obj) EXPORT.SI.particledensity.map(obj)/(1/parsec^3),...
	'\mathrm{pc}^{-3}');

EXPORT.astro.restmass = lib.module.ProfileMapping(...
	@(obj) EXPORT.SI.density.map(obj)/Msun,...
	'M_\odot'...
);

EXPORT.astro.particle_mass = lib.module.ProfileMapping(...
	@(obj) obj.data.m/eVcc/1E3,...
	'\mathrm{keV}/c^2'...
);

EXPORT.astro.potentialDiff = lib.module.ProfileMapping(...
	@(obj) 1/(EXPORT.SI.radius.map(obj)/parsec),...
	'1/\mathrm{pc}'...
);

EXPORT.astro.degeneracyDiff = lib.module.ProfileMapping(...
	@(obj) -1/(EXPORT.SI.radius.map(obj)/parsec),...
	'-1/\mathrm{pc}'...
);

EXPORT.astro.temperatureDiff = lib.module.ProfileMapping(...
	@(obj) -obj.data.m*c^2/kB/(EXPORT.SI.radius.map(obj)/parsec),...
	'-K/\mathrm{pc}'...
);


% CENTRAL SCALE
EXPORT.central.density = lib.module.ProfileMapping(...
	@(obj) 1/obj.data.density(1),...
	'\rho_0'...
);

EXPORT.central.pressure = lib.module.ProfileMapping(...
	@(obj) 1/obj.data.pressure(1),...
	'\rho_0 c^2'...
);

EXPORT.central.degeneracy = lib.module.ProfileMapping(...
	@(obj) obj.data.theta0,...
	'\theta_0'...
);


% CORE SCALE
fscale = @(obj,ykey) 1/ANCH.velocity_core.map(obj,ykey);

EXPORT.core.radius = lib.module.ProfileMapping(...
	@(obj) fscale(obj,MAP.radius),...
	'r_c'...
);

EXPORT.core.density = lib.module.ProfileMapping(...
	@(obj) fscale(obj,obj.data.density),...
	'\rho_c'...
);

EXPORT.core.pressure = lib.module.ProfileMapping(...
	@(obj) fscale(obj,obj.data.pressure),...
	'P_c'...
);

EXPORT.core.mass = lib.module.ProfileMapping(...
	@(obj) fscale(obj,MAP.mass),...
	'M_c'...
);

EXPORT.core.velocity = lib.module.ProfileMapping(...
	@(obj) fscale(obj,MAP.velocity),...
	'v_c'...
);

EXPORT.core.potential = lib.module.ProfileMapping(...
	@(obj) fscale(obj,obj.data.potential),...
	'\nu_c'...
);

EXPORT.core.compactness = lib.module.ProfileMapping(...
	@(obj) fscale(obj,MAP.compactness),...
	'\varphi_c'...
);


% PLATEAU SCALE
fscale = @(obj,ykey) 1/ANCH.velocity_plateau.map(obj,ykey);

EXPORT.plateau.radius = lib.module.ProfileMapping(...
	@(obj) fscale(obj,MAP.radius),...
	'r_p'...
);

EXPORT.plateau.density = lib.module.ProfileMapping(...
	@(obj) fscale(obj,obj.data.density),...
	'\rho_p'...
);

EXPORT.plateau.pressure = lib.module.ProfileMapping(...
	@(obj) fscale(obj,obj.data.pressure),...
	'P_p'...
);

EXPORT.plateau.mass = lib.module.ProfileMapping(...
	@(obj) fscale(obj,MAP.mass),...
	'M_p'...
);

EXPORT.plateau.velocity = lib.module.ProfileMapping(...
	@(obj) fscale(obj,MAP.velocity),...
	'v_p'...
);

EXPORT.plateau.potential = lib.module.ProfileMapping(...
	@(obj) fscale(obj,obj.data.potential),...
	'\nu_c'...
);

EXPORT.plateau.compactness = lib.module.ProfileMapping(...
	@(obj) fscale(obj,MAP.compactness),...
	'\varphi_p'...
);


% halo SCALE
fscale = @(obj,ykey) 1/ANCH.velocity_halo.map(obj,ykey);

EXPORT.halo.radius = lib.module.ProfileMapping(...
	@(obj) fscale(obj,MAP.radius),...
	'r_h'...
);

EXPORT.halo.density = lib.module.ProfileMapping(...
	@(obj) fscale(obj,obj.data.density),...
	'\rho_h'...
);

EXPORT.halo.pressure = lib.module.ProfileMapping(...
	@(obj) fscale(obj,obj.data.pressure),...
	'P_h'...
);

EXPORT.halo.mass = lib.module.ProfileMapping(...
	@(obj) fscale(obj,MAP.mass),...
	'M_h'...
);

EXPORT.halo.velocity = lib.module.ProfileMapping(...
	@(obj) fscale(obj,MAP.velocity),...
	'v_h'...
);

EXPORT.halo.potential = lib.module.ProfileMapping(...
	@(obj) fscale(obj,obj.data.potential),...
	'\nu_h'...
);

EXPORT.halo.compactness = lib.module.ProfileMapping(...
	@(obj) fscale(obj,MAP.compactness),...
	'\varphi_h'...
);
% axes wich consider the difference between the center and the core
% (e.g. nu_0 - nu_c)

MAP = lib.require(@model.tov.fd.dynmap);

% define axis
EXPORT.degeneracy	= module.ProfileAxis(MAP.degeneracy_plateau_offset);
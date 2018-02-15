% load FD anchors
EXPORT = lib.require(@lib.model.tov.fd.anchor);

% extend RAR anchors
MAP = lib.require(@lib.model.tov.rar.map);

EXPORT.surface = lib.module.ProfileAnchor(...
	@(obj) MAP.radius.map(obj),...
	@(obj,X) obj.data.radius(end)...
);

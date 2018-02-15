function list = createGrid(vm,W0)
list = lib.module.array();

for ii=1:numel(W0)
	list.push(lib.struct.setfield(vm,'param/W0',W0(ii)));
end
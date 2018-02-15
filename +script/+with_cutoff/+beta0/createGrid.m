function list = createGrid(vm,BETA0)
list = lib.module.array();

for ii=1:numel(BETA0)
	list.push(lib.struct.setfield(vm,'param/beta0',BETA0(ii)));
end
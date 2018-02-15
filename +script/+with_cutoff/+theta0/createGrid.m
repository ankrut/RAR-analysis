function list = createGrid(vm,THETA0)
list = lib.module.array();

for ii=1:numel(THETA0)
	list.push(lib.struct.setfield(vm,'param/theta0',THETA0(ii)));
end
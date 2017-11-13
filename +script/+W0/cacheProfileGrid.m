function cacheProfileGrid
TBL = load('export/TblProfileW0.mat');

P.cored		= TBL.cored.pick(1:5:51).map(@(t) model.tov.rar.profile('model',t.model));
P.cuspy		= TBL.cuspy.pick(1:5:51).map(@(t) model.tov.rar.profile('model',t.model));
P.deficit	= TBL.deficit.pick(1:10:21).map(@(vm) model.tov.rar.profile('model',vm));
P.disrupt	= TBL.disrupt.pick(1:2:21).map(@(vm) model.tov.rar.profile('model',vm));

lib.save('export/CacheProfileW0.mat',P);
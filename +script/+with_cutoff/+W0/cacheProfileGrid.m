function cacheProfileGrid
TBL = load('export/TblProfileW0.mat');

P.cored		= TBL.cored.pick(1:5:51).map(@(t) lib.model.tov.rar.profile('model',t.model));
P.cuspy		= TBL.cuspy.pick(1:5:51).map(@(t) lib.model.tov.rar.profile('model',t.model));
P.deficit	= TBL.deficit.pick(1:10:21).map(@(vm) lib.model.tov.rar.profile('model',vm));
P.disrupt	= TBL.disrupt.pick(3:2:21).map(@(t) lib.model.tov.rar.profile('model',t.model));

lib.save('export/CacheProfileW0.mat',P);
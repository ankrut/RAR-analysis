function cacheProfileGrid
TBL = load('export/TblProfileTheta0Low.mat');

P.is	= TBL.is;
P.trans	= TBL.trans.pick([6:5:16, 20]).map(@(t) lib.model.tov.rar.profile('model',t.model));
P.cored	= TBL.cored.pick(1:4:21).map(@(t) lib.model.tov.rar.profile('model',t.model));

lib.save('export/CacheProfileTheta0Low.mat',P);
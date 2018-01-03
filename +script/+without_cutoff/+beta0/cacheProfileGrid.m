function cacheProfileGrid
TBL = load('export/TblWithoutCutoffBeta0Profiles.mat');

P.low	= model.tov.rar.profile('model',TBL.low);
P.trans	= TBL.trans.pick(1:4:17).map(@(t) model.tov.rar.profile('model',t.model));
P.high	= TBL.high.pick(1:4:21).map(@(t) model.tov.rar.profile('model',t.model));

lib.save('export/CacheWithoutCutoffBeta0Profiles.mat',P);
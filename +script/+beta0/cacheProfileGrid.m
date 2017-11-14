function cacheProfileGrid
TBL = load('export/TblProfileBeta0.mat');

P.cored.low		= TBL.cored.low.pick(1:4:21).map(@(t) model.tov.rar.profile('model',t.model));
P.cored.high	= TBL.cored.high.pick(1:2:21).map(@(t) model.tov.rar.profile('model',t.model));

P.cuspy.high	= TBL.cuspy.high.pick(1:6:31).map(@(t) model.tov.rar.profile('model',t.model));
P.cuspy.trans	= TBL.cuspy.trans.pick(1:10:51).map(@(t) model.tov.rar.profile('model',t.model));
P.cuspy.deficit	= TBL.cuspy.deficit.pick(1:7:15).map(@(t) model.tov.rar.profile('model',t.model));
P.cuspy.low		= TBL.cuspy.low.pick(1:2:21).map(@(t) model.tov.rar.profile('model',t.model));

% P.deficit	= TBL.deficit.pick(1:4:61);

% P.cuspy.low	= TBL.cuspy.low.pick(1:4:21).map(@(t) model.tov.rar.profile('model',t.model));
% P.cuspy.high	= TBL.cuspy.high.pick(1:10:61).map(@(t) model.tov.rar.profile('model',t.model));

lib.save('export/CacheProfileBeta0.mat',P);
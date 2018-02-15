function cacheProfileGrid
TBL = load('export/TblWithCutoffAnalysisMpMs.mat');

P.cuspy	= TBL.cuspy.pick([1 + 4*9:9:91, 95, 98, 100, 109, 119]).map(@(t) lib.model.tov.rar.profile('model',t));

lib.save('export/CacheWithCutoffProfilesMpMs.mat',P);
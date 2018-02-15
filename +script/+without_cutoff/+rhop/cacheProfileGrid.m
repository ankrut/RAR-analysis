function cacheProfileGrid
TBL = load('export/TblWithoutCutoffAnalysisRhop.mat');

P.thin	= TBL.thin.pick(1+3*9:9:100).map(@(t) lib.model.tov.rar.profile('model',t));

lib.save('export/CacheWithoutCutoffProfilesRhop.mat',P);
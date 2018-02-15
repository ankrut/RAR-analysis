function cacheProfileGrid
TBL = load('export/TblWithoutCutoffAnalysisRho0.mat');

P.thin	= TBL.thin.pick(1:9:100).map(@(t) lib.model.tov.rar.profile('model',t));

lib.save('export/CacheWithoutCutoffProfilesRho0.mat',P);
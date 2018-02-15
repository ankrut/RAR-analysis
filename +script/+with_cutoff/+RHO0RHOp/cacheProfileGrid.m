function cacheProfileGrid
TBL = load('export/TblWithCutoffAnalysisRHO0RHOp.mat');

P.RHO0RHOp	= TBL.RHO0RHOp.pick(1:9:100).map(@(t) lib.model.tov.rar.profile('model',t));

lib.save('export/CacheWithCutoffProfilesRHO0RHOp.mat',P);
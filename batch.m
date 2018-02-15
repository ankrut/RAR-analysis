try
	script.without_cutoff.rho0.createAnalysisGrid
	script.without_cutoff.rho0.cacheAnalysisGrid
	script.without_cutoff.rho0.cacheProfileGrid
catch
	ERROR.withoutCutoff.rho0 = true;
end

try
	script.without_cutoff.rhop.createAnalysisGrid
	script.without_cutoff.rhop.cacheAnalysisGrid
	script.without_cutoff.rhop.cacheProfileGrid
catch
	ERROR.withoutCutoff.rho = true;
end

try
	script.with_cutoff.MpMs.createAnalysisGrid
	script.with_cutoff.MpMs.cacheAnalysisGrid
	script.with_cutoff.MpMs.cacheProfileGrid
catch
	ERROR.withCutoff.MpMs = true;
end

try
	script.with_cutoff.RHO0RHOp.createAnalysisGrid
	script.with_cutoff.RHO0RHOp.cacheAnalysisGrid
	script.with_cutoff.RHO0RHOp.cacheProfileGrid
catch
	ERROR.withoutCutoff.RHO0RHOp = true;
end

try
	script.with_cutoff.W0.createAnalysisGrid
	script.with_cutoff.W0.createProfileGrid
	script.with_cutoff.W0.cacheAnalysisGrid
	script.with_cutoff.W0.cacheProfileGrid
catch
	ERROR.withCutoff.W0 = true;
end

try
	script.with_cutoff.theta0.createAnalysisGrid
	script.with_cutoff.theta0.createProfileGrid
	script.with_cutoff.theta0.cacheAnalysisGrid
	script.with_cutoff.theta0.cacheProfileGrid
catch
	ERROR.withCutoff.theta0 = true;
end

try
	script.with_cutoff.beta0.createAnalysisGrid
	script.with_cutoff.beta0.createProfileGrid
	script.with_cutoff.beta0.cacheAnalysisGrid
	script.with_cutoff.beta0.cacheProfileGrid
catch
	ERROR.withCutoff.beta0 = true;
end
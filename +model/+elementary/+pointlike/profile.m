classdef profile < module.ProfileData
	methods
		function obj=profile(M,varargin)
			obj = obj@module.ProfileData(varargin{:});
			obj.set('M0',M);
		end
	end
end
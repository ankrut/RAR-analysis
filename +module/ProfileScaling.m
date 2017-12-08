classdef ProfileScaling < handle
	properties
		fmap
		unit
	end
	
	methods
		function obj=ProfileScaling(fmap,varargin)
			if(lib.isfunc(fmap))
				obj.fmap = fmap;
			else
				obj.fmap = @(obj) fmap;
			end
			
			if nargin > 1
				obj.unit = varargin{1};
			end
		end
		
		function q=map(obj,profile)
			q = obj.fmap(profile);
		end
	end
end
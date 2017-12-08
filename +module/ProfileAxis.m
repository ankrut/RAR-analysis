classdef ProfileAxis < handle
	properties
		mapmodel
		scalemodel
	end
	
	methods
		function obj=ProfileAxis(map,varargin)
			switch class(map)
				case 'function_handle'
				obj.mapmodel = module.ProfileMapping(map);
					
				otherwise
				obj.mapmodel = map;
			end
			
			if(nargin == 1)
				obj.scalemodel = module.ProfileScaling(1,'');
			else
				scale = varargin{:};
				
				switch class(scale)
					case 'function_handle'
						obj.scalemodel = module.ProfileScaling(scale);
						
					otherwise
						obj.scalemodel = scale;
				end
			end
		end
		
		function Y=map(obj,elm)
			Y = obj.mapmodel.map(elm)*obj.scalemodel.map(elm);
		end
	end
end
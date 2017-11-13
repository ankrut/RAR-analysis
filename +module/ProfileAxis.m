classdef ProfileAxis < handle
	properties
		mapmodel
		scalemodel
	end
	
	methods
		function obj=ProfileAxis(map,varargin)
			if(nargin == 1)
				obj.scalemodel = module.ProfileScaling(1,'');
			else
				obj.scalemodel = varargin{1};
			end
			
			switch class(map)
				case 'function_handle'
				obj.mapmodel = module.ProfileMapping(map);
					
				otherwise
				obj.mapmodel = map;
			end
		end
		
		function Y=map(obj,elm)
			Y = obj.mapmodel.map(elm)*obj.scalemodel.map(elm);
		end

		% PERSISTENT EXTENSION (EXPERIMENTAL)
		function y=GET(obj,elm)
			persistent OBJ INPUT OUTPUT

			if(isempty(OBJ) ...				first call
			|| OBJ ~= obj ...				another object
			|| ~isequal(elm,INPUT)...	another parameter (input)
			)
				y = obj.map(elm);
				
				OBJ		= obj;
				INPUT	= elm;
				OUTPUT	= y;
			else
				y = OUTPUT;
			end
		end
	end
end
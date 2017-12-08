% class for fully degenerate core (fermionic model)
classdef Core < module.tov
    methods
        function obj=Core(varargin)
			obj = obj@module.tov(varargin{:});
		end
		
		function obj=define(obj,s)
			lib.array(fieldnames(s)).forEach(@(key) ...
				obj.set(key,s.(key)) ...
			);
		end
		
		function obj=calc(obj,opts)
			% destructor
			EF		= obj.data.fermi_energy;
			XMIN	= opts.xmin;
			XMAX	= opts.xmax;
			TAU		= opts.tau;		% absolute error for ode solver
			RTAU	= opts.rtau;	% relative error for ode solver
			
			% substitution
			fE		= @(nu) EF*exp(-nu./2);
			fK		= @(nu) sqrt(EF^2*exp(-nu) - 1);
			
			% method 1: most general approximation (f(r,E) ~ 1)
			frho	= @(r,nu) 1/2/sqrt(pi)*(2*fE(nu).*fK(nu).^3 + fE(nu).*fK(nu) - log(fE(nu) + fK(nu)));
			fp		= @(r,nu) 3/2/sqrt(pi)*(2/3*fE(nu).*fK(nu).^3 - fE(nu).*fK(nu) + log(fE(nu) + fK(nu)));
			
			% method 2: low Fermi energies (E_F ~ 1)
% 			frho	= @(r,nu) 4/3/sqrt(pi)*(2*fE(nu) - 2).^(3/2);
% 			fp		= @(r,nu) 4/5/sqrt(pi)*(2*fE(nu) - 2).^(5/2);
			
			% method 3: high Fermi energies (E_F >> 1)
% 			frho	= @(r,nu) 1/sqrt(pi)*(fE(nu)).^4;
% 			fp		= @(r,nu) 1/sqrt(pi)*(fE(nu)).^4;
			
			% set OPTIONS (for ODE solver)
			fevent	= @(r,y) lib.ode_event_negative(EF*exp(-y(1)/2) - 1); % check cutoff condition
			options	= odeset('RelTol',RTAU,'AbsTol',TAU*[1 1],'NonNegative',1,'Event',fevent);

			% call ode solver for theta(r)
			[R, NU, M] = classes.profile.TOV.ode_solver_logeta(0,frho,fp,XMIN,XMAX,options);
			
			obj.data.radius			= R;
			obj.data.potential		= NU;
			obj.data.mass			= M;
			
			% cache time consuming magnitudes
			obj.data.density		= frho(R,NU);
			obj.data.pressure		= fp(R,NU);
		end
	end
end
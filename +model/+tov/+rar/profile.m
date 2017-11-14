% REQUIERMENTS
%	module.tov
classdef profile < module.tov
	methods
		function obj=profile(varargin)
			obj = obj@module.tov();
			
			if nargin > 0
				Q = module.struct(varargin{:});

				if isfield(Q,'param')
					obj.define(Q.param);
				end

				if isfield(Q,'options')
					obj.calc(Q.options);
				end

				if isfield(Q,'model')
					obj.define(Q.model.param).calc(Q.model.options);
				end
			end
		end
		
		function obj=define(obj,s)
			module.array(fieldnames(s)).forEach(@(key) ...
				obj.set(key,s.(key)) ...
			);
		end
		
		function obj=calc(obj,opts)
			% destructor
			THETA0	= obj.data.theta0;
			W0		= obj.data.W0;
			BETA0	= obj.data.beta0;
			
			CELL = lib.struct.toCell(opts);
			Q = module.struct(...
				'xmin',			'auto',...
				'xmax',			1E20,...
				'tau',			1E-16,...
				'rtau',			1E-4,...
				'tol',			1E-15,...
				'numPoints',	500,...
				CELL{:} ...
			);
		
			XMIN	= Q.xmin;
			XMAX	= Q.xmax;
			TOL		= Q.tol;		% how close to singularity (TOL > 0)
			TAU		= Q.tau;		% absolute error for ode solver
			RTAU	= Q.rtau;		% relative error for ode solver
			NN		= Q.numPoints;	% number of points for integral
			
			
			tt = cputime;
			dt = 10; % sec;
			
			function [value,isterminal,direction] = fMaxExecutionTime()
				value		= dt - (cputime - tt);
				isterminal	= 1;
				direction	= 0;
			end
			
			function [value,isterminal,direction] = fEventNegative(x)
				value      = real(x);
				isterminal = 1;    % stop the integration
				direction  = -1;   % positive direction only
			end
			
			function [value,isterminal,direction] = fEvent(x)
				[value(1),isterminal(1),direction(1)] = fMaxExecutionTime();
				[value(2),isterminal(2),direction(2)] = fEventNegative(x);
			end
			
			% substitution
			ALPHA0	= 1 + THETA0*BETA0;
			EC0		= 1 + W0*BETA0;
			
			% define density and pressure function handles
			func_rho	= @(E,beta,alpha,ec) sqrt(E.^2 - 1).*E.^2.*(1 - exp((E - ec)./beta))./(exp((E - alpha)./beta) + 1);
			func_p		= @(E,beta,alpha,ec) (E.^2 - 1).^(3/2).*(1 - exp((E - ec)./beta))./(exp((E - alpha)./beta) + 1);
			frho		= @(r,nu) real(4/sqrt(pi)*model.tov.rar.integral.trapz(func_rho,BETA0*exp(-nu./2),ALPHA0*exp(-nu./2),EC0*exp(-nu./2),NN));
			fp			= @(r,nu) real(4/3/sqrt(pi)*model.tov.rar.integral.trapz(func_p,BETA0*exp(-nu./2),ALPHA0*exp(-nu./2),EC0*exp(-nu./2),NN));
			
			% set OPTIONS (for ODE solver)
			fevent	= @(r,y) fEvent(EC0*exp(-y(1)/2) - 1); % check cutoff condition
			options	= odeset('RelTol',RTAU,'AbsTol',TAU*[1 1],'Event',fevent);
			
			if strcmp(XMIN,'auto')
				XMIN = sqrt(6*TOL/frho(0,0));
			end
			
			% call ode solver for theta(r)
			RHO0		= frho(0,0);
			ICS			= [1/6*RHO0*XMIN^2, 1/3*RHO0*XMIN^2];
			[R, NU, M]	= module.tov.ode_solver(ICS,frho,fp,XMIN,XMAX,options);
			
			obj.data.radius			= R;
			obj.data.potential		= NU;
			obj.data.mass			= M;
			
			% cache time consuming variables (often needed)
			obj.data.density		= frho(R,NU);
			obj.data.pressure		= fp(R,NU);
		end
	end
	
	
	% CORRESPONDING PROFILES ---------------------------------------------
	methods
		function p = get_vacuum(obj,XMAX)
			XMIN	= obj.data.radius(end);
			M0		= obj.data.mass(end);
			
			p = model.elementary.pointlike.profile(M0).set('radius', linspace(XMIN,XMAX));
		end
		
% % % 		% TODO (I need the relativistic version, Newtonian version does not work due to the beta0 parameter)
% % % 		function p=get_king(obj)
% % % 			% calc classic King profile
% % % 			% use the corresponding central degeneracy at the degeneracy
% % % 			% plateau (defined as first minima of rotation curve)
% % % 			% (this way it works amazingly good!)
% % % 			pnt		= lib.get_extrema(obj.data.radius,-obj.data.velocity,1);
% % % 			W0		= interp1(obj.data.radius,obj.data.cutoff,pnt,'spline');
% % % 			THETA0	= interp1(obj.data.radius,obj.data.degeneracy,pnt,'spline');
% % % 			p		= classes.profile.newton.rar.profile(W0,obj.data.radius(1),obj.data.radius(end),1E-6);
% % % 
% % % 			classes.profile.newton.rar.profile.fermionic_rescale(p,THETA0,W0);
% % % 		end
	end
end
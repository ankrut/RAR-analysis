function cuspyMaxRadius
searchCfg	= lib.require(@configs.solutionSearchConfig);
W0			= linspace(35.790981099387963,35.790981099387963 - 2e-06 ,51);

% halo deficit seed
opts	= struct('xmin', 1E-7, 'xmax', 1E20, 'tau', 1E-16, 'rtau', 1E-4);
param	= struct('beta0', 1E-6, 'theta0', 20, 'W0', 35.790981099387963);
vm		= struct('param', param, 'options', opts);

P		= script.W0.createGridW0(vm,W0)...
		  .map(@(vm) model.tov.rar.profile('model',vm));

% find extremum
RSORC	= P.accumulate(@(p) searchCfg.ResponseList.rsorc(p));
kk		= find(RSORC == max(RSORC));

X		= (W0 - W0(kk))*1E6;
Y		= log(RSORC);
x		= lib.get_extrema(X,Y,1);
y		= interp1(X,Y,x,'spline');

W0max	= x*1E-6 + W0(kk);
Rmax	= exp(y);

figure
axes('XScale','log','YScale','log');
hold on

loglog(W0,RSORC);
plot(W0max,Rmax,'k+');
text(W0max,Rmax,sprintf('(%1.8f,%1.2E)',W0max,Rmax),'HorizontalAlignment','left','VerticalAlignment','bottom');
function vm = estimateModelStruct(x,fx,vm,TBL,kk)
% exclude model with same surfacr radius
T0 = TBL.filter(@(t) fx(t) ~= x);

if T0.length < 2
	error('not enough data points (n<2)');
end

% find the <kmax> closest solutions (at least 2, max kk)
kmax = min(kk,T0.length-1);
T0 = T0...
	.sort(@(t) abs(round(log(fx(t)),12) - round(log(x),12)) +  abs(log(t.model.param.W0) - log(vm.param.W0)) + abs(log(t.model.param.W0) - log(vm.param.W0)))...
	.pick(1:kmax);

% extract grid
X = T0.accumulate(@(t) fx(t));

% estimate model (polyfit)
vm = polyfitModelStruct(x,X,vm,T0.map(@(t) t.model));

function vm = polyfitModelStruct(x,X,vm,T)
THETA0	= T.accumulate(@(t) t.param.theta0);

% polynom degree (max 2)
nn = max(2,T.length-1);

p				= polyfit(log(X),THETA0,nn);
vm.param.theta0	= polyval(p,log(x));
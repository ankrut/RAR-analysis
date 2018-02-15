function vm = estimateModelStruct(x,fx,vm,TBL,kk)
% exclude model with same surfacr radius
T0 = TBL.filter(@(t) fx(t) ~= x);

if T0.length < 2
	error('not enough data points (n<2)');
end

% find the <kmax> closest solutions (at least 2, max kk)
kmax = min(kk,T0.length-1);
T0 = T0...
	.sort(@(t) abs(round(log(fx(t)),12) - round(log(x),12)) +  abs(log(t.model.param.theta0) - log(vm.param.theta0)) + abs(log(t.model.param.W0) - log(vm.param.W0)))...
	.pick(1:kmax);

% extract grid
X = T0.accumulate(@(t) fx(t));

% estimate model (polyfit)
vm = polyfitModelStruct(x,X,vm,T0.map(@(t) t.model));

function vm = polyfitModelStruct(x,X,vm,T)


% X		= T.accumulate(@(t) t.param.rs);
% BETA0	= T.accumulate(@(t) t.param.beta0);
% THETA0	= T.accumulate(@(t) t.param.theta0);
W0		= T.accumulate(@(t) t.param.W0);

% polynom degree (max 2)
nn = max(2,T.length-1);

% p1 = polyfit(log(X),log(BETA0),nn);
% p2 = polyfit(log(X),log(THETA0),nn);
p3 = polyfit(log(X),log(W0),nn);

% vm.param.beta0	= exp(polyval(p1,log(x)));
% vm.param.theta0	= exp(polyval(p2,log(x)));
vm.param.W0		= exp(polyval(p3,log(x)));
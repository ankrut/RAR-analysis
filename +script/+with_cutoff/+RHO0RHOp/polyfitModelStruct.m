function vm = polyfitModelStruct(x,fX,vm,T)
X		= T.accumulate(fX);
BETA0	= T.accumulate(@(t) t.param.beta0);
THETA0	= T.accumulate(@(t) t.param.theta0);

% polynom degree (max 2)
nn = max(2,T.length-1);

p1				= polyfit(X,log(BETA0),nn);
vm.param.beta0	= exp(polyval(p1,x));

p2				= polyfit(X,THETA0,nn);
vm.param.theta0	= polyval(p2,x);
function meansol=mexp(a,b,c,V,X)
% analytically calculates the flux factor

% define parameters from inputs
alpha=a;
beta=b;
v=V;
ci=c;
ce=1-ci;
x=X;

fluxf=alpha.*((v.^2+4.*(beta+alpha)).^(1/2)+(-1).*v.*tanh((1/2).*(v.^2+4.*(beta+ ...
  alpha)).^(1/2))).*(alpha.*(v.^2+4.*(beta+alpha)).^(1/2)+(-1).*v.*(beta+alpha+(-1) ...
  .*beta.*coth((1/2).*v)).*tanh((1/2).*(v.^2+4.*(beta+alpha)).^(1/2))).^( ...
  -1);
Jopen = v*(ci-ce*exp(-v))/(1-exp(-v));
Jg=fluxf*Jopen;

meansol=(1-exp(v*x))./V*Jg+ci.*exp(v*x);

end
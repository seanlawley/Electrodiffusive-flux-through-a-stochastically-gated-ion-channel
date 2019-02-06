function fluxf=shortexp(a,b,V)
% analytically calculates the flux factor

% define parameters from inputs
alpha=a;
beta=b;
v=V;

fluxf=alpha.*((v.^2+4.*(beta+alpha)).^(1/2)+(-1).*v.*tanh((1/2).*(v.^2+4.*(beta+ ...
  alpha)).^(1/2))).*(alpha.*(v.^2+4.*(beta+alpha)).^(1/2)+(-1).*v.*(beta+alpha+(-1) ...
  .*beta.*coth((1/2).*v)).*tanh((1/2).*(v.^2+4.*(beta+alpha)).^(1/2))).^( ...
  -1);

end
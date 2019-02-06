function run_short(RHO0,nnn)
% This function runs stochastic simulations of the stochastic PDE where
% $\rho_0=RHO0$ and the number of monte carlo
% trials is nnn. In particular, this function runs these trials for each 8
% possible values of \alpha_0+\alpha_1.

tic

% alpha1=alpha
% alpha0=beta

xi=logspace(-3,4,1e2); % xi=alpha0+alpha1
xip=logspace(-1,3,8); % sparse xi=alpha0+alpha1
rho0=RHO0;
a=rho0*xi; % alpha
ap=rho0*xip; % sparse alpha
b=(1-rho0)*xi; % beta
bsp=(1-rho0)*xip; % sparse beta
V=4;
ci=1;
expl=zeros(length(xi),1);
mc=zeros(length(xip),1);
numtrials=nnn;

for i=1:length(xi)
    expl(i)=shortexp(a(i),b(i),V);
end
parfor i=1:length(xip)
    mc(i)=short(ap(i),bsp(i),V,ci,numtrials);
end

%% saving data

filename = ['data_short',datestr(clock,0)];
save(filename)

%% plotting

hold all
plot(xip,mc,'kd','LineWidth',2)
plot(xi,expl,'k-','LineWidth',2)
plot(xi,rho0*ones(length(xi),1),...
    'k--','LineWidth',1)
plot(xi,1*ones(length(xi),1),...
    'k--','LineWidth',1)
set(gca,'xscale','log')
ll=legend(...
    'Monte Carlo',...
    'Analytic',...
    'Location','east');
xl=xlabel('$\alpha_0+\alpha_1$');
yl=ylabel('Gated flux');
set(xl,'Interpreter','Latex')
set(yl,'Interpreter','Latex')
set(ll,'Interpreter','Latex')
axis([min(xi),max(xi),0,1.2])

toc
end
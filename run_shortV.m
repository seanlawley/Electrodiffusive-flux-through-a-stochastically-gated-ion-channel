function run_shortV(RHO0,XI,nnn)
% This function runs stochastic simulations of the stochastic PDE where
% $\rho_0=RHO0$, $\alpha_0+\alpha_1=XI$, and the number of monte carlo
% trials is nnn. In particular, this function runs these trials for each 8
% possible values of V.

close all
tic

VV=linspace(-5,20,1e2);
VVp=linspace(-5,20,8);
rho0=RHO0;
xi=XI; % \alpha_0+\alpha_1
a=rho0*xi; % \alpha_1
b=(1-rho0)*xi; % \alpha_0
ci=1;
expl=zeros(length(VV),1);
mc=zeros(length(VVp),1);
numtrials=nnn;

for i=1:length(VV)
    expl(i)=shortexp(a,b,VV(i));
end
parfor i=1:length(VVp)
    mc(i)=short(a,b,VVp(i),ci,numtrials);
end

%% saving data

filename = ['data_shortV',datestr(clock,0)];
save(filename)

toc
end
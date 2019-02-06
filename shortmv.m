function statSOL=shortmv(ALPHA,BETA,vv,CI,N,X)
% This file runs the Monte Carlo simulation of the stochastic PDE.
%% parameters to change
% close all

L=1; % length of interval
D=1; % diffusion coefficient
nswitches=N; % how many cycles of switching
ci=CI; % BC parameter at x=0
ce=1-ci; % BC parameter at x=1
alpha=ALPHA; % jump rate from NEU(1) to DIR(0)
beta=BETA; % jump rate from DIR(0) to NEU(1)
xmesh=1e2; % number of spatial grid points (WAS 100 BEFORE)
V=vv; % voltage

% define function handles
pdexpde = @fpdexpde;
pdex1ic = @fpdex1ic;
bc0 = @fbc0;
bc1 = @fbc1;


%% calculate parameters - don't change
m = 0; % slab (matlab parameter)
x = linspace(0,L,xmesh); % spatial domain for PDEs
xsp = X; % sparse spatial domain for computing stats

%% loop
xout = xsp;

% rng default % sets random number generator to default value
dataSOL0=zeros(nswitches/2,length(xout)); % hold the solution at switching times
dataSOL1=zeros(nswitches/2,length(xout)); % hold the solution at switching times

% solve switching pdes
t=linspace(0,exprnd(1/alpha),3); % time mesh until random sw. time
sol=pdepe(m,pdexpde,pdex1ic,bc1,x,t); % solve pdes until sw. time
dataSOL1(1,:)=pdeval(m,x,sol(end,:,1),xout); % save value
% of soln and derivative at x=xout at sw. time
t=linspace(0,exprnd(1/beta),3);
sol=pdepe(m,pdexpde,@(z) interp1(x,sol(end,:,1),z),bc0,x,t);
dataSOL0(1,:)=pdeval(m,x,sol(end,:,1),xout); % save value

for k=2:(nswitches/2)
    t=linspace(0,exprnd(1/alpha),3);
    sol=pdepe(m,pdexpde,@(z) interp1(x,sol(end,:,1),z),bc1,x,t);
    dataSOL1(k,:)=pdeval(m,x,sol(end,:,1),xout); % save value
    t=linspace(0,exprnd(1/beta),3);
    sol=pdepe(m,pdexpde,@(z) interp1(x,sol(end,:,1),z),bc0,x,t);
    dataSOL0(k,:)=pdeval(m,x,sol(end,:,1),xout); % save value
end
dataSOL=[dataSOL0;dataSOL1];

statSOL=[mean(dataSOL);std(dataSOL)];

%% functions called in PDE
% --------------------------------------------------------------
    function [c,f,s] = fpdexpde(x,t,u,DuDx) % pde
        c = 1/D;
        f = DuDx;
        s = -V*DuDx;
    end
% --------------------------------------------------------------
    function u0 = fpdex1ic(x) % initial condition
        u0=1*u0ss;
    end
% --------------------------------------------------------------
    function [pl,ql,pr,qr] = fbc0(xl,ul,xr,ur,t)
        pl = ul-ci;
        ql = 0;
        pr = ur-ce;
        qr = 0;
    end
% --------------------------------------------------------------
    function [pl,ql,pr,qr] = fbc1(xl,ul,xr,ur,t)
        pl = ul-ci;
        ql = 0;
        pr = -V*ur;
        qr = 1;
    end
end
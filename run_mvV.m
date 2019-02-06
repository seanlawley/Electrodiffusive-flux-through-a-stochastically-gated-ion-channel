function run_mvV
% This function runs stochastic simulations of the stochastic PDE and
% returns the mean and variance. It runs these simulations for varying
% values of $V$.
close all
tic

% alpha1=alpha
% alpha0=beta

VV=linspace(-5,15,3)
VVs=linspace(VV(end)+5,200,10) % extra V's for std deviation
xi=1; % xi=alpha0+alpha1
rho0=.5;
a=rho0*xi; % alpha
b=(1-rho0)*xi; % beta
ci=.9;
numtrials=1e2;
X=linspace(0,1,1e1);
Xf=linspace(0,1,1e2);

mSOL=zeros(length(VV),length(X));
sSOL=zeros(length(VV),length(X));
mSOL2=zeros(length(VVs),length(Xf));
sSOL2=zeros(length(VVs),length(Xf));
mTHEOR=zeros(length(VV),length(Xf));

for i=1:length(VV)
    mTHEOR(i,:)=mexp(a,b,ci,VV(i),Xf);
end
parfor i=1:length(VV)
    temp=shortmv(a,b,VV(i),ci,numtrials,X);
    mSOL(i,:)=temp(1,:);
    sSOL(i,:)=temp(2,:);
end
parfor i=1:length(VVs)
    temp=shortmv(a,b,VVs(i),ci,numtrials,Xf);
    mSOL2(i,:)=temp(1,:);
    sSOL2(i,:)=temp(2,:);
end

% slow switching theoretical std deviation
V=VV(1);
ce=1-ci;
u0ss=((-1)+exp(1).^V).^(-1).*(ci.*(exp(1).^V+(-1).*exp(1).^(V.*Xf))+ce.* ...
    ((-1)+exp(1).^(V.*Xf)));
u1ss=ci.*exp(1).^(V.*Xf);
sTHEOR=sqrt(rho0*(1-rho0)*(u0ss-u1ss).^2);

%% saving data

filename = ['data_mvV',datestr(clock,0)];
save(filename)

%% plotting
% figure('units','inches','position',[.5 .5 1*8 1*3])
figure('units','inches','position',[.5 .5 3*8 3*3])
subplot(1,2,1)
hold all
plot(X,mSOL(1,:),'ro','LineWidth',2)
plot(X,mSOL(2,:),'ko','LineWidth',2)
plot(X,mSOL(3,:),'bo','LineWidth',2)
plot(Xf,mTHEOR(1,:),'r','LineWidth',2)
plot(Xf,mTHEOR(2,:),'k','LineWidth',2)
plot(Xf,mTHEOR(3,:),'b','LineWidth',2)
ll=legend(...
    '$V=-5$',...
    '$V=5$',...
    '$V=15$',...
    'Location','northwest');
xl=xlabel('$x$');
yl=ylabel('Mean');
set(xl,'Interpreter','Latex')
set(yl,'Interpreter','Latex')
set(ll,'Interpreter','Latex')
xlim([0,1])
set(gca,'yscale','log')

subplot(1,2,2)
hold all
plot(X,sSOL(1, :),'ro','LineWidth',2)
plot(X,sSOL(2, :),'ko','LineWidth',2)
plot(X,sSOL(3, :),'bo','LineWidth',2)
for i=1:length(VVs)
    plot(Xf,sSOL2(i, :),'k','LineWidth',1)
end
plot(Xf,sTHEOR,'r','LineWidth',2)
xl=xlabel('$x$');
yl=ylabel('Standard deviation');
set(xl,'Interpreter','Latex')
set(yl,'Interpreter','Latex')
xlim([0,1])
ylim([1e-16,1e5])
set(gca,'yscale','log')

figure
hold all
for i=1:length(VVs)
    plot(Xf,mSOL2(i, :),'k','LineWidth',1)
end
set(gca,'yscale','log')




toc
end
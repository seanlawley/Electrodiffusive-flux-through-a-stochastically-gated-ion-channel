function run_mv
% This function runs stochastic simulations of the stochastic PDE and
% returns the mean and variance. It runs these simulations for varying
% values of $\alpha_0+\alpha_1$.
close all
tic

% alpha1=alpha
% alpha0=beta

xi=logspace(-1,3,3); % xi=alpha0+alpha1
rho0=.5;
a=rho0*xi; % alpha
b=(1-rho0)*xi; % beta
V=1;
ci=1;
numtrials=1e4;
X=linspace(0,1,10);

mSOL=zeros(length(xi),length(X));
sSOL=zeros(length(xi),length(X));
mTHEOR=zeros(length(xi),length(X));

for i=1:length(xi)
    mTHEOR(i,:)=mexp(a(i),b(i),ci,V,X);
end
parfor i=1:length(xi)
    temp=shortmv(a(i),b(i),V,ci,numtrials,X);
    mSOL(i,:)=temp(1,:);
    sSOL(i,:)=temp(2,:);
end

% slow switching theoretical std deviation
ce=1-ci;
u0ss=((-1)+exp(1).^V).^(-1).*(ci.*(exp(1).^V+(-1).*exp(1).^(V.*X))+ce.* ...
    ((-1)+exp(1).^(V.*X)));
u1ss=ci.*exp(1).^(V.*X);
sTHEOR=sqrt(rho0*(1-rho0)*(u0ss-u1ss).^2);

%% saving data

filename = ['data_mv',datestr(clock,0)];
save(filename)

%% plotting
figure('units','inches','position',[.5 .5 1*8 1*3])
subplot(1,2,1)
hold all
plot(X,mSOL(1,:),'ro','LineWidth',2)
plot(X,mSOL(2,:),'ko','LineWidth',2)
plot(X,mSOL(3,:),'bo','LineWidth',2)
plot(X,mTHEOR(1,:),'r','LineWidth',2)
plot(X,mTHEOR(2,:),'k','LineWidth',2)
plot(X,mTHEOR(3,:),'b','LineWidth',2)
ll=legend(...
    '$\alpha_0+\alpha_1=10^{-1}$',...
    '$\alpha_0+\alpha_1=10^{1}$',...
    '$\alpha_0+\alpha_1=10^{3}$',...
    'Location','southwest');
xl=xlabel('$x$');
yl=ylabel('Mean');
set(xl,'Interpreter','Latex')
set(yl,'Interpreter','Latex')
set(ll,'Interpreter','Latex')
xlim([0,1])

subplot(1,2,2)
hold all
plot(X,sSOL(1, :),'ro','LineWidth',2)
plot(X,sSOL(2, :),'ko','LineWidth',2)
plot(X,sSOL(3, :),'bo','LineWidth',2)
plot(X,sTHEOR,'r','LineWidth',2)
xl=xlabel('$x$');
yl=ylabel('Standard deviation');
set(xl,'Interpreter','Latex')
set(yl,'Interpreter','Latex')
xlim([0,1])



toc
end
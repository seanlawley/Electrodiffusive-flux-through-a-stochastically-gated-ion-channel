% plot_ff.m
% This file plots Figure 6. The data is generated from running runflux.m.
close all
clear

% plot data
figure('units','inches','position',[5 5 1*8 1*3])
subplot(1,2,1)
hold all
load('data_V0001.mat')
p1=plot(VVp,mc,'ro','LineWidth',2,'MarkerSize',7);
plot(VV,expl,'r-','LineWidth',2)
load('data_V01.mat')
p2=plot(VVp,mc,'k+','LineWidth',2,'MarkerSize',7);
plot(VV,expl,'k-','LineWidth',2)
load('data_V1.mat')
p3=plot(VVp,mc,'bs','LineWidth',2,'MarkerSize',7);
plot(VV,expl,'b-','LineWidth',2)
plot(VV,rho0*ones(length(VV),1),...
    'k--','LineWidth',1)
plot(VV,1*ones(length(VV),1),...
    'k--','LineWidth',1)
ll=legend(...
    [p1,p2,p3],...
    '$\alpha_0+\alpha_1=10^{-4}$',...
    '$\alpha_0+\alpha_1=10^{-2}$',...
    '$\alpha_0+\alpha_1=10^{0}$',...
    'Location','northwest');
xl=xlabel('$V$');
yl=ylabel('$f=$ flux reduction factor');
set(xl,'Interpreter','Latex')
set(yl,'Interpreter','Latex')
set(ll,'Interpreter','Latex')
xlim([min(0,min(VV)),max(VV)])
ylim([0,1.1])

subplot(1,2,2)
hold all
load('data_xip1.mat')
p1=plot(xip,mc,'ro','LineWidth',2,'MarkerSize',7);
plot(xi,expl,'r-','LineWidth',2)
plot(xi,rho0*ones(length(xi),1),...
    'k--','LineWidth',1)
plot(xi,1*ones(length(xi),1),...
    'k--','LineWidth',1)
load('data_xip5.mat')
p2=plot(xip,mc,'k+','LineWidth',2,'MarkerSize',7);
plot(xi,expl,'k-','LineWidth',2)
plot(xi,rho0*ones(length(xi),1),...
    'k--','LineWidth',1)
load('data_xip9.mat')
p3=plot(xip,mc,'bs','LineWidth',2,'MarkerSize',7);
plot(xi,expl,'b-','LineWidth',2)
plot(xi,rho0*ones(length(xi),1),...
    'k--','LineWidth',1)
set(gca,'xscale','log')
ll=legend(...
    [p1,p2,p3],...
    '$\rho_0=0.1$',...
    '$\rho_0=0.5$',...
    '$\rho_0=0.9$',...
    'Location','southeast');
xl=xlabel('$\alpha_0+\alpha_1$');
yl=ylabel('$f=$ flux reduction factor');
set(xl,'Interpreter','Latex')
set(yl,'Interpreter','Latex')
set(ll,'Interpreter','Latex')
axis([min(xi),max(xi),0,1.1])
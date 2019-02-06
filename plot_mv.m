% plot_mv.m
% This file plots Figure 4. The data is generated from running run_mv.m.
close all

% load data
load('data_mv1')

% plot data
figure('units','inches','position',[.5 .5 1*8 1*3])
subplot(1,2,1)
hold all
plot(X,mSOL(1,:),'ro','LineWidth',2,'MarkerSize',7);
plot(X,mSOL(2,:),'k+','LineWidth',2,'MarkerSize',7);
plot(X,mSOL(3,:),'bs','LineWidth',2,'MarkerSize',7);
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
plot(X,sSOL(1, :),'ro','LineWidth',2,'MarkerSize',7);
plot(X,sSOL(2, :),'k+','LineWidth',2,'MarkerSize',7);
plot(X,sSOL(3, :),'bs','LineWidth',2,'MarkerSize',7);
plot(X,sTHEOR,'r','LineWidth',2)
% ll=legend(...
%     '$\alpha_0+\alpha_1=10^{-1}$',...
%     '$\alpha_0+\alpha_1=10^{1}$',...
%     '$\alpha_0+\alpha_1=10^{3}$',...
%     'Location','northwest');
xl=xlabel('$x$');
yl=ylabel('Standard deviation');
set(xl,'Interpreter','Latex')
set(yl,'Interpreter','Latex')
% set(ll,'Interpreter','Latex')

xlim([0,1])
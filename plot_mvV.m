% plot_mvV.m
% This file plots Figure 5. The data is generated from running run_mvV.m.
close all

% load data
load('data_mvV1')

% plot data
figure('units','inches','position',[.5 .5 1*8 1*3])
% figure('units','inches','position',[.5 .5 3*8 3*3])
subplot(1,2,1)
hold all
plot(X,mSOL(1,:),'ro','LineWidth',2,'MarkerSize',7);
plot(X,mSOL(2,:),'k+','LineWidth',2,'MarkerSize',7);
plot(X,mSOL(3,:),'bs','LineWidth',2,'MarkerSize',7);
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
plot(X,sSOL(1, :),'ro','LineWidth',2,'MarkerSize',7);
plot(X,sSOL(2, :),'k+','LineWidth',2,'MarkerSize',7);
plot(X,sSOL(3, :),'bs','LineWidth',2,'MarkerSize',7);
for i=1:length(VVs)
    plot(Xf,sSOL2(i, :),'k','LineWidth',1)
end
plot(Xf,sTHEOR,'r','LineWidth',2)
% ll=legend(...
%     '$V=-5$',...
%     '$V=5$',...
%     '$V=15$',...
%     '$V=20,40,\dots,200$',...
%     'Location','northwest');
xl=xlabel('$x$');
yl=ylabel('Standard deviation');
set(xl,'Interpreter','Latex')
set(yl,'Interpreter','Latex')
% set(ll,'Interpreter','Latex')
xlim([0,1])
ylim([1e-14,1e5])
set(gca,'yscale','log')
% set(gca,'xscale','log')
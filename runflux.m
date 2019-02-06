% runflux.m
% This file generates the stochastic simulation data used in Figure 6.

% number of monte carlo trials
numtrials=1e4;

% generate data for Figure 6, left panel. Here, $\rho_0=0.1$,
% $\alpha_0+\alpha_1$ varies between 10^-4, 10^-2, and 1, and $V$ varies.
run_shortV(.1,.0001,numtrials)
run_shortV(.1,.01,numtrials)
run_shortV(.1,1,numtrials)

% generate data for Figure 6, right panel. Here, $V=4$, $\rho_0$ varies
% between 0.1, 0.5, and 0.9, and $\alpha_0+\alpha_1$ varies.
run_short(.1,numtrials)
run_short(.5,numtrials)
run_short(.9,numtrials)
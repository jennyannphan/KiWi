%%%%%%% steady state parameters calculation %%%%%%%%%
% VOLUME OF DISTRIBUTION

% OVERVIEW: 
% How many files are interconnected?
% Custom steady state calculator runs three files:
% 1. CustomFit_VT.m;
% 2. CustomFit_K1_k2.m;
% 3. CustomFit_rsq.mreallocation:
CustomFit.SteadyState.rsq.all_plots(1,:) = CustomFit.SteadyState.rsq.N1; % N1 | Cumming 1993
CustomFit.SteadyState.rsq.all_plots(2,:) = CustomFit.SteadyState.rsq.N2; % N2 | Gjedde 2000
CustomFit.SteadyState.rsq.all_plots(3,:) = CustomFit.SteadyState.rsq.P1; % P1 | Gjedde 1982
CustomFit.SteadyState.rsq.all_plots(4,:) = CustomFit.SteadyState.rsq.P2; % P2 | Logan 1990
CustomFit.SteadyState.rsq.all_plots(5,:) = CustomFit.SteadyState.rsq.P3; % P3 | Reith 1990
CustomFit.SteadyState.rsq.all_plots(6,:) = CustomFit.SteadyState.rsq.P4; % P4 | Nahimi 2015

%% all plots into one data table: 
CustomFit.SteadyState.rsq.all_plots(1,:) = CustomFit.SteadyState.rsq.N1;
CustomFit.SteadyState.rsq.all_plots(2,:) = CustomFit.SteadyState.rsq.N2;
CustomFit.SteadyState.rsq.all_plots(3,:) = CustomFit.SteadyState.rsq.P1;
CustomFit.SteadyState.rsq.all_plots(4,:) = CustomFit.SteadyState.rsq.P2;
CustomFit.SteadyState.rsq.all_plots(5,:) = CustomFit.SteadyState.rsq.P3;
CustomFit.SteadyState.rsq.all_plots(6,:) = CustomFit.SteadyState.rsq.P4;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



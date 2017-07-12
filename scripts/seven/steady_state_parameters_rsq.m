%%%%%%% steady state parameters calculation %%%%%%%%%
% VOLUME OF DISTRIBUTION

% OVERVIEW: 
% How many files are interconnected?
% steady_state_parameters_calculator: 
% 1. steady_state_parameter_VT
% 2. steady_state_parameter_K1_k2
% 3. steady_state_parameter_rsq

%% define structures for preallocation:
BestFit.rsq.all_plots(1,:) = SteadyState.rsq.N1; % N1 | Cumming 1993
BestFit.rsq.all_plots(2,:) = SteadyState.rsq.N2; % N2 | Gjedde 2000
BestFit.rsq.all_plots(3,:) = SteadyState.rsq.P1; % P1 | Gjedde 1982
BestFit.rsq.all_plots(4,:) = SteadyState.rsq.P2; % P2 | Logan 1990
BestFit.rsq.all_plots(5,:) = SteadyState.rsq.P3; % P3 | Reith 1990
BestFit.rsq.all_plots(6,:) = SteadyState.rsq.P4; % P4 | Nahimi 2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% all plots into one data table: 
SteadyState.rsq.all_plots(1,:) = SteadyState.rsq.N1;
SteadyState.rsq.all_plots(2,:) = SteadyState.rsq.N2;
SteadyState.rsq.all_plots(3,:) = SteadyState.rsq.P1;
SteadyState.rsq.all_plots(4,:) = SteadyState.rsq.P2;
SteadyState.rsq.all_plots(5,:) = SteadyState.rsq.P3;
SteadyState.rsq.all_plots(6,:) = SteadyState.rsq.P4;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%% steady state parameters calculation %%%%%%%%%
% VOLUME OF DISTRIBUTION

% OVERVIEW: 
% How many files are interconnected?
% steady_state_parameters_calculator: 
% 1. steady_state_parameter_VT
% 2. steady_state_parameter_K1_k2
% 3. steady_state_parameter_rsq


%% define structures for preallocation:
SteadyState.VT.N1=[] %preallocate struct   N1 | Cumming 1993
SteadyState.VT.N2=[] %preallocate struct   N2 | Gjedde 2000

SteadyState.VT.P1=[] %preallocate struct   P1 | Gjedde 1982
SteadyState.VT.P2=[] %preallocate struct   P2| Logan 1990
SteadyState.VT.P3=[] %preallocate struct   P3 | Reith 1990
SteadyState.VT.P4=[] %preallocate struct   P4 | Nahimi 2015
SteadyState.VT.all_plots=[]%preallocate struct

%% kinetic model: Cumming 1993 kappa=K1-k2*VT
%K1 is yIntercept, k2 is slope
%VT is K1/k2 ratio:
data = bsxfun(@rdivide, ...
    linearModel.yIntercept.N1, linearModel.slope.N1);
SteadyState.VT.N1 = -1.*data

clearvars data


%% kinetic model: Gjedde 2000 Vol = VT -(1/k2)*Kappa
% VT is the yIntercept
SteadyState.VT.N2=   linearModel.yIntercept.N2(1,:);

%% kinetic model: Gjedde 1982 1/kappa=theta*(1/VT)+(1/K1)
% slope = 1/VT
% VT = 1/ slope
SteadyState.VT.P1= 1./linearModel.slope.P1;


%% kinetic model: Logan 1990 theta=VT*(1/Kappa)-(1/k2)
% VT is the slope of the curve
SteadyState.VT.P2=    linearModel.slope.P2(1,:);


%% kinetic model: Reith 1990 1/theta=K1*(1/vol)-k2
% K1 is 1slope, k2 is yIntercept
%VT=slope/yIntercept

data =  bsxfun(@rdivide,...
linearModel.slope.P3, linearModel.yIntercept.P3);
SteadyState.VT.P3 = -1.*data

clearvars data

%% kinetic model: P4 plot 1/vol=(1/theta)*(1/K1)+(1/VT)
%(1/VT)=yIntercept;
% VT=1/yIntercept;

SteadyState.VT.P4=       1./linearModel.yIntercept.P4

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% all plots into one data table: 
SteadyState.VT.all_plots(1,:) = SteadyState.VT.N1;
SteadyState.VT.all_plots(2,:) = SteadyState.VT.N2;
SteadyState.VT.all_plots(3,:) = SteadyState.VT.P1;
SteadyState.VT.all_plots(4,:) = SteadyState.VT.P2;
SteadyState.VT.all_plots(5,:) = SteadyState.VT.P3;
SteadyState.VT.all_plots(6,:) = SteadyState.VT.P4;

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

run steady_state_parameters_K1_k2.m


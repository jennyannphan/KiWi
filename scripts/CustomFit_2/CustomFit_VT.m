%%%%%%% steady state parameters calculation %%%%%%%%%
% VOLUME OF DISTRIBUTION

% OVERVIEW: 
% How many files are interconnected?
% Custom steady state calculator runs three files:
% 1. CustomFit_VT.m;
% 2. CustomFit_K1_k2.m;
% 3. CustomFit_rsq.m


%% define structures for preallocation:
CustomFit.SteadyState.V_T.N1=[]       %preallocate struct   N1 | Cumming 1993
CustomFit.SteadyState.V_T.N2=[]       %preallocate struct   N2 | Gjedde 2000

CustomFit.SteadyState.V_T.P1=[]       %preallocate struct   P1 | Gjedde 1982
CustomFit.SteadyState.V_T.P2=[]       %preallocate struct   P2| Logan 1990
CustomFit.SteadyState.V_T.P3=[]       %preallocate struct   P3 | Reith 1990
CustomFit.SteadyState.V_T.P4=[]       %preallocate struct   P4 | Nahimi 2015
CustomFit.SteadyState.V_T.all_plots=[]%preallocate struct


%% kinetic model: N2 Gjedde 2000 Vol = V_T -(1/k2)*Kappa
% V_T is the yIntercept
CustomFit.SteadyState.V_T.N2=   CustomFit.yIntercept.N2(1,:);


%% kinetic model: P2 Logan 1990 theta=V_T*(1/Kappa)-(1/k2)
% V_T is the slope of the curve
CustomFit.SteadyState.V_T.P2=    CustomFit.slope.P2(1,:);

%% kinetic model: P4 Nahimi 2015 1/vol=(1/theta)*(1/K1)+(1/V_T)
%(1/V_T)=yIntercept;
% V_T=1/yIntercept;

CustomFit.SteadyState.V_T.P4=       1./CustomFit.yIntercept.P4

%% kinetic model: N1 Cumming 1993 kappa=K1-k2*V_T
%K1 is yIntercept, k2 is slope
%V_T is K1/k2 ratio:
data = bsxfun(@rdivide, ...
    CustomFit.yIntercept.N1, CustomFit.slope.N1);
CustomFit.SteadyState.V_T.N1 = -1.*data

clearvars data

%% kinetic model: P1 Gjedde 1982 1/kappa=theta*(1/V_T)+(1/K1)
% slope = 1/V_T
% V_T = 1/ slope
CustomFit.SteadyState.V_T.P1= 1./CustomFit.slope.P1;

%% kinetic model: P3 Reith 1990 1/theta=K1*(1/vol)-k2
% K1 is 1slope, k2 is yIntercept
%V_T=slope/yIntercept

data =  bsxfun(@rdivide,...
CustomFit.slope.P3, CustomFit.yIntercept.P3);
CustomFit.SteadyState.V_T.P3 = -1.*data

clearvars data

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% all plots into one data table: 

CustomFit.SteadyState.V_T.all_plots(1,:) = CustomFit.SteadyState.V_T.N1;
CustomFit.SteadyState.V_T.all_plots(2,:) = CustomFit.SteadyState.V_T.N2;
CustomFit.SteadyState.V_T.all_plots(3,:) = CustomFit.SteadyState.V_T.P1;
CustomFit.SteadyState.V_T.all_plots(4,:) = CustomFit.SteadyState.V_T.P2;
CustomFit.SteadyState.V_T.all_plots(5,:) = CustomFit.SteadyState.V_T.P3;
CustomFit.SteadyState.V_T.all_plots(6,:) = CustomFit.SteadyState.V_T.P4;



%run steady_state_parameters_K1_k2_CustomFit.m


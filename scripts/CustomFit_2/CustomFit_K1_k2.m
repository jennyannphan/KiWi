%%%%%%% steady state parameters calculator %%%%%%%%%
% K1 rate constant

% OVERVIEW: 
% How many files are interconnected?
% Custom steady state calculator runs three files:
% 1. CustomFit_VT.m;
% 2. CustomFit_K1_k2.m;
% 3. CustomFit_rsq.m
%% define structures for preallocation:

CustomFit.SteadyState.K1.N1=[]; %preallocate struct  N1 | Cumming 1993
CustomFit.SteadyState.K1.N2=[]; %preallocate struct  N2 | Gjedde 2000
CustomFit.SteadyState.K1.P1=[]; %preallocate struct  P1 | Gjedde 1982
CustomFit.SteadyState.K1.P2=[]; %preallocate struct  P2 | Logan 1990
CustomFit.SteadyState.K1.P3=[]; %preallocate struct  P3 | Reith 1990
CustomFit.SteadyState.K1.P4=[]; %preallocate struct  P4 | Nahimi 2015

CustomFit.SteadyState.K1.all_plots=[];%preallocate struct

CustomFit.SteadyState.k2.N1=[]; %preallocate struct  N1 | Cumming 1993
CustomFit.SteadyState.k2.N2=[]; %preallocate struct  N2 | Gjedde 2000
CustomFit.SteadyState.k2.P1=[]; %preallocate struct  P1 | Gjedde 1982
CustomFit.SteadyState.k2.P2=[]; %preallocate struct  P2 | Logan 1990
CustomFit.SteadyState.k2.P4=[]; %preallocate struct  P4 | Nahimi 2015
CustomFit.SteadyState.k2.P3=[]; %preallocate struct  P3 | Reith 1990

CustomFit.SteadyState.k2.all_plots=[]; %preallocate struct

%% kinetic model: N1 Cumming 1993 kappa=K1-k2*V_T
%K1 is yIntercept, k2 is slope
% K1:
CustomFit.SteadyState.K1.N1= CustomFit.yIntercept.N1;

% k2: 
data= CustomFit.slope.N1;
CustomFit.SteadyState.k2.N1= -1.*data;
clearvars data


%% kinetic model: N2 Gjedde 2000 Vol = V_T -(1/k2)*Kappa
% K1= V_T*k2
%V_T is the yIntercept, k2 is 1/slope
% K1 = yIntercept * (1/slope)

% k1
data =bsxfun(@rdivide,...
    CustomFit.yIntercept.N2,...
    CustomFit.slope.N2);

CustomFit.SteadyState.K1.N2= -1.*data;
clearvars data

% k2
CustomFit.SteadyState.k2.N2= -1./ CustomFit.slope.N2;

%% kinetic model: P1 Gjedde 1982 1/kappa=theta*(1/V_T)+(1/K1)
% K1 is 1/yIntercept
CustomFit.SteadyState.K1.P1= 1./ CustomFit.yIntercept.P1; 

% k2 is K1/V_T
%k2 =(1/yIntercept)/(1/slope)
CustomFit.SteadyState.k2.P1= bsxfun(@rdivide,...
    CustomFit.slope.P1,...
    CustomFit.yIntercept.P1);

%% kinetic model: P2 Logan 1990 theta=V_T*(1/Kappa)-(1/k2)
% K1= V_T*k2
% V_T is the slope, k2 is 1/yIntercept
% K1=slope *(1/yIntercept)

% K1:
 data = bsxfun(@rdivide,...
    CustomFit.slope.P2, ...
    CustomFit.yIntercept.P2);

CustomFit.SteadyState.K1.P2= -1.*data;
clearvars data

% k2:
CustomFit.SteadyState.k2.P2= -1./ CustomFit.yIntercept.P2;

%% kinetic model: P3 Reith 1990 1/theta=K1*(1/vol)-k2
% K1 is 1slope, k2 is yIntercept
% K1:
CustomFit.SteadyState.K1.P3 = CustomFit.slope.P3;

% k2: 
data = CustomFit.yIntercept.P3;
CustomFit.SteadyState.k2.P3= -1.*data;
clearvars data

%% kinetic model: P4 Nahimi 2015 1/vol=(1/theta)*(1/K1)+(1/V_T)
% K1 = 1/slope, V_T=1/yIntercept

%K1:
CustomFit.SteadyState.K1.P4= 1./CustomFit.slope.P4;

%k2: 
% k2 = K1/V_T
% k2 = (1/slope)/(1/yIntercept)=yIntercept/slope
CustomFit.SteadyState.k2.P4= bsxfun(@rdivide,...
    CustomFit.yIntercept.P4,...
    CustomFit.slope.P4);

%% organize parameters:
CustomFit.SteadyState.K1.all_plots(1,:) = CustomFit.SteadyState.K1.N1;
CustomFit.SteadyState.K1.all_plots(2,:) = CustomFit.SteadyState.K1.N2;
CustomFit.SteadyState.K1.all_plots(3,:) = CustomFit.SteadyState.K1.P1;
CustomFit.SteadyState.K1.all_plots(4,:) = CustomFit.SteadyState.K1.P2;
CustomFit.SteadyState.K1.all_plots(5,:) = CustomFit.SteadyState.K1.P3;
CustomFit.SteadyState.K1.all_plots(6,:) = CustomFit.SteadyState.K1.P4;

CustomFit.SteadyState.k2.all_plots(4,:) = CustomFit.SteadyState.k2.N1;
CustomFit.SteadyState.k2.all_plots(1,:) = CustomFit.SteadyState.k2.N2;
CustomFit.SteadyState.k2.all_plots(5,:) = CustomFit.SteadyState.k2.P1;
CustomFit.SteadyState.k2.all_plots(2,:) = CustomFit.SteadyState.k2.P2;
CustomFit.SteadyState.k2.all_plots(6,:) = CustomFit.SteadyState.k2.P3;
CustomFit.SteadyState.k2.all_plots(3,:) = CustomFit.SteadyState.k2.P4;


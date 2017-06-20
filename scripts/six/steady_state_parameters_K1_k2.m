%%%%%%% steady state parameters calculator %%%%%%%%%
% K1 rate constant

% OVERVIEW: 
% How many files are interconnected?
% steady_state_parameter_calculator: 
% 1. steady_state_parameter_VT
% 2. steady_state_parameter_K1_k2
% 3. steady_state_parameter_rsq

%% define structures for preallocation:
SteadyState.K1.N1=[]; %preallocate struct  N1 | Cumming 1993
SteadyState.K1.N2=[]; %preallocate struct  N2 | Gjedde 2000
SteadyState.K1.P1=[]; %preallocate struct  P1 | Gjedde 1982
SteadyState.K1.P2=[]; %preallocate struct  P2 | Logan 1990
SteadyState.K1.P3=[]; %preallocate struct  P3 | Reith 1990
SteadyState.K1.P4=[]; %preallocate struct  P4 | Nahimi 2015

SteadyState.K1.all_plots=[];%preallocate struct

SteadyState.k2.N1=[]; %preallocate struct  N1 | Cumming 1993
SteadyState.k2.N2=[]; %preallocate struct  N2 | Gjedde 2000
SteadyState.k2.P1=[]; %preallocate struct  P1 | Gjedde 1982
SteadyState.k2.P2=[]; %preallocate struct  P2 | Logan 1990
SteadyState.k2.P4=[]; %preallocate struct  P4 | Nahimi 2015
SteadyState.k2.P3=[]; %preallocate struct  P3 | Reith 1990

SteadyState.k2.all_plots=[]; %preallocate struct


%% kinetic model: Gjedde 2000 Vol = VT -(1/k2)*Kappa
% K1= VT*k2
%VT is the yIntercept, k2 is 1/slope
% K1 = yIntercept * (1/slope)

% k1
data =bsxfun(@rdivide,...
    linearModel.yIntercept.N2,...
    linearModel.slope.N2);

SteadyState.K1.N2= -1.*data;
clearvars data

% k2
SteadyState.k2.N2= -1./ linearModel.slope.N2;

%% kinetic model: Logan 1990 theta=VT*(1/Kappa)-(1/k2)
% K1= VT*k2
% VT is the slope, k2 is 1/yIntercept
% K1=slope *(1/yIntercept)

% K1:
 data = bsxfun(@rdivide,...
    linearModel.slope.P2, ...
    linearModel.yIntercept.P2);

SteadyState.K1.P2= -1.*data;
clearvars data

% K1:
SteadyState.k2.P2= -1./ linearModel.yIntercept.P2;

%% kinetic model: P4 plot 1/vol=(1/theta)*(1/K1)+(1/VT)
% K1 = 1/slope, VT=1/yIntercept

%K1:
SteadyState.K1.P4= 1./linearModel.slope.P4;

%k2: 
% k2 = K1/VT
% k2 = (1/slope)/(1/yIntercept)=yIntercept/slope
SteadyState.k2.P4= bsxfun(@rdivide,...
    linearModel.yIntercept.P4,...
    linearModel.slope.P4);

%% kinetic model: Cumming 1993 kappa=K1-k2*VT
%K1 is yIntercept, k2 is slope
% K1:
SteadyState.K1.N1= linearModel.yIntercept.N1;

% k2: 
data= linearModel.slope.N1;
SteadyState.k2.N1= -1.*data;
clearvars data

%% kinetic model: Gjedde 1982 1/kappa=theta*(1/VT)+(1/K1)
% K1 is 1/yIntercept
SteadyState.K1.P1= 1./ linearModel.yIntercept.P1; 

% k2 is K1/VT
%k2 =(1/yIntercept)/(1/slope)
SteadyState.k2.P1= bsxfun(@rdivide,...
    linearModel.slope.P1,...
    linearModel.yIntercept.P1);

%% kinetic model: Reith 1990 1/theta=K1*(1/vol)-k2
% K1 is 1slope, k2 is yIntercept
% K1:
SteadyState.K1.P3 = linearModel.slope.P3;

% k2: 
data = linearModel.yIntercept.P3;
SteadyState.k2.P3= -1.*data;
clearvars data

%% organize parameters:
SteadyState.K1.all_plots(1,:) = SteadyState.K1.N1;
SteadyState.K1.all_plots(2,:) = SteadyState.K1.N2;
SteadyState.K1.all_plots(3,:) = SteadyState.K1.P1;
SteadyState.K1.all_plots(4,:) = SteadyState.K1.P2;
SteadyState.K1.all_plots(5,:) = SteadyState.K1.P3;
SteadyState.K1.all_plots(6,:) = SteadyState.K1.P4;

SteadyState.k2.all_plots(4,:) = SteadyState.k2.N1;
SteadyState.k2.all_plots(1,:) = SteadyState.k2.N2;
SteadyState.k2.all_plots(5,:) = SteadyState.k2.P1;
SteadyState.k2.all_plots(2,:) = SteadyState.k2.P2;
SteadyState.k2.all_plots(6,:) = SteadyState.k2.P3;
SteadyState.k2.all_plots(3,:) = SteadyState.k2.P4;

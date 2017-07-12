% Code written by MD-PhD student, Jenny-Ann Phan

%compute Int_M(T) - cumulative integral of VOI activity 
% a = 'TAC.time_min'; 
% b = 'TAC.ROI_activity_kbq';
% int_M = cumtrapz(a,b);

% This script computes the dynamic parameters: V_app(T), K_app(T), theta(T)

a= TAC.time_min;
b= TAC.ROI_activity_kbq;

% compute Int_M(T) - cumulative integral of VOI activity 
TAC.int_M = cumtrapz(a,b);

% compute integral of plasmaInput
TAC.int_input = cumtrapz(a,TAC.input_kbq);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ALL PARAMETERS CALCULATION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Eq 2.1 compute VOL:          vol = INT_M(T) / INT_REF(T)
dynamic.vol = bsxfun(@rdivide,TAC.int_M,TAC.int_input);

%% Eq 2.2 computes THETA:        theta = INT_M(T) / M(T)

dynamic.theta = bsxfun(@rdivide, TAC.int_M, TAC.ROI_activity_kbq);

% Eq 2.3 computes KAPPA:         kappa = M(T) / INT_REF(T)
dynamic.kappa = bsxfun(@rdivide,TAC.ROI_activity_kbq ,TAC.int_input);

% now compute reciproc values
% Eq 2.4 1/VOL
dynamic.vol_reciproc = bsxfun(@rdivide,TAC.int_input,TAC.int_M);

% Eq 2.5 1/theta
dynamic.theta_reciproc = bsxfun(@rdivide,TAC.ROI_activity_kbq,TAC.int_M);

% Eq 2.6 1/kappa
dynamic.kappa_reciproc = bsxfun(@rdivide,TAC.int_input,TAC.ROI_activity_kbq);
 
%retrieve brain regions from raw data: 
dynamic.name=TAC.name;
clearvars a b;




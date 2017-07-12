% Code written by MD, PhD student, Jenny-Ann Phan
% Calculation bases on linear interpolated data

%compute Int_M(T) - cumulative integral of VOI activity 
 time = TAC_interpol.time_min; 
 m_brain = TAC_interpol.brain_activity.kBq;        % M(T)
 m_ref = TAC_interpol.input_activity.kBq;        % M(Ref)
 
 dynamic.calc.int_M = cumtrapz(time,m_brain);      % compute integral of brain activity  INT(M)
 dynamic.calc.int_ref = cumtrapz(time, m_ref); % compute integral of plasma Input   INT(Ref)

 int_m= dynamic.calc.int_M;
 int_ref = dynamic.calc.int_ref;
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ALL PARAMETERS CALCULATION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Eq 2.1 compute VOL:          vol = INT_M(T) / INT_REF(T)
dynamic.vol = bsxfun(@rdivide, int_m, int_ref);

% Eq 2.2 computes THETA:        theta = INT_M(T) / M(T)
dynamic.theta = bsxfun(@rdivide, int_m, m_brain);

% Eq 2.3 computes KAPPA:         kappa = M(T) / INT_REF(T)
dynamic.kappa = bsxfun(@rdivide, m_brain , int_ref);

%% now compute reciproc values
% Eq 2.4 1/VOL
dynamic.vol_reciproc = bsxfun(@rdivide,int_ref,int_m);

% Eq 2.5 1/theta
dynamic.theta_reciproc = bsxfun(@rdivide,m_brain, int_m);

% Eq 2.6 1/kappa
dynamic.kappa_reciproc = bsxfun(@rdivide,int_ref,m_brain);
 
%retrieve brain regions from raw data: 
dynamic.brain_region=TAC.brain_region;
clearvars time m_brain m_ref int_m int_ref;




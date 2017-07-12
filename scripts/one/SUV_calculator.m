%%% SUV CALCULATOR
SUV.InjectedDose_Mbq=SUV_injected_dose;         % in Mbq
SUV.InjectedDose_kbq=SUV_injected_dose*1000;    % convert to MBq to kBq

SUV.BodyWeight=SUV_body_weight;                 % in kg

SUV.ID_div_BW= SUV.InjectedDose_kbq/SUV.BodyWeight;

SUV.ROI_SUV=bsxfun(@rdivide, TAC.brain_activity.kBq, SUV.ID_div_BW);

clearvars  SUV_injected_dose SUV_body_weight
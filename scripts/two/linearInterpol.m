

% conduct linear interpolation of brain and input activity
% interpolates using plasma time axis, because plasma time is usually
% shorter than brain time.

TAC_interpol.stepLength=stepLength;
TAC_interpol.time_min =[0:stepLength:TAC.input_time_min(end)]'; % new interpolated time line for both brain and plasma

TAC_interpol.brain_activity.kBq=...
interp1(...
TAC.brain_time_min,...  % raw time
TAC.brain_activity.kBq,...%measured activity
TAC_interpol.time_min); % interpolated time 


TAC_interpol.input_activity.kBq=...
interp1(...
TAC.input_time_min,...  % raw time    
TAC.input_activity.kBq, ... %measured activity
TAC_interpol.time_min); % interpolated time 


    
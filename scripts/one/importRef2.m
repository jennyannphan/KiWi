% Description: this script enables you to select import TACs data from 
...the path and filename 
% Date: Sep 28, 2015

% INSTRUCTIONS 
% Use this script to import time-interpolated plasma activity curves 

[fileName, pathName] = uigetfile('*.xlsx');
myFile=[pathName '/' fileName];

% If statement: if cancel is pressed, don't import anything
if pathName==0;
    clear pathName clear fileName clear myFile;
end

% Import data if file is chosen
data=xlsread(myFile);
TAC.time_min=data(:,1);             % time frame in min
TAC.input_kbq=data(:,2);  % activity in kBq/mL plasma

clearvars data fileName pathName myFile;





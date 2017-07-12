% Description: this script enables you to select import blood data from 
...the path and filename 
% Date: Sep 28, 2015

% INSTRUCTIONS 
% Use this script to import time-interpolated plasma activity curves 

% Define directory to file
[fileName, pathName] = uigetfile('*.xlsx');
myFile=[pathName '/' fileName];

% If statement: if cancel is pressed, don't import anything
if pathName==0;
    clear pathName clear fileName clear myFile;
end

% Import data if file is chosen
data=xlsread(myFile);
TAC.input_time_min=data(:,1);             % time frame in min
TAC.input_time_min=[0; TAC.input_time_min] % add zero to the start time

TAC.input_activity.kBq=data(:,2);  % activity in kBq/mL plasma
TAC.input_activity.kBq=[0; TAC.input_activity.kBq] % add zero to the first row

clearvars data fileName pathName myFile;







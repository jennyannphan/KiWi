% Description: this function enables you to import TAC from one folder
% and organize the data in a struct
% Date: Sep 28, 2015
% Written by Jenny-Ann Phan, MD-PhD student


folder=uigetdir;

% if the user clicks cancel, delete the variable
if folder ==0;
    clear folder;
end 

% organize brain data in a struct
contents=dir(folder);
TAC=struct;
TAC.brain_activity.Bq=[];
TAC.brain_region = cell(1,1);
for currentFile=3:length(contents)
    myFile=[folder '/' contents(currentFile).name];
    data=dlmread(myFile,'\t',1); % function
    TAC.brain_time_min=data(:,1);
    TAC.brain_activity.Bq(:,currentFile-2)=data(:,5);
   
    % content inside {} indicate postion in db.name 
    TAC.brain_region{currentFile-2}=contents(currentFile).name(1:end-4);    

end

% add zeros to the first row of activity 
col_size=size(TAC.brain_activity.Bq); 
zero_row=zeros(1, col_size(2)); % create a row of zero with a width that corresponds to the columns of brain regions 
TAC.brain_activity.Bq=[zero_row; TAC.brain_activity.Bq];  % add the row of zeros to the first row of TACs 


TAC.brain_time_min=[0; TAC.brain_time_min] % add zero to the start time

TAC.brain_activity.kBq = TAC.brain_activity.Bq/1000; % convert Bq to kBq

% compute cummulative integral of M(T). This is needed for later analysis
x=TAC.brain_time_min;
y=TAC.brain_activity.kBq;
TAC.int_m=cumtrapz(x,y);     % Int(M) calculation - Integral of brain TAC

clearvars x y folder contents currentFile myFile data col_size zero_row; 





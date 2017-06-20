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
TAC.ROI_activity_Bq=[];
TAC.name = cell(1,1);
for currentFile=3:length(contents)
    myFile=[folder '/' contents(currentFile).name];
    data=dlmread(myFile,'\t',1); % function
    TAC.time_min=data(:,1);
    TAC.ROI_activity_Bq(:,currentFile-2)=data(:,5);
   
    % content inside {} indicate postion in db.name 
    TAC.name{currentFile-2}=contents(currentFile).name(1:end-4);    

end
% convert Bq to kBq
TAC.ROI_activity_kbq = TAC.ROI_activity_Bq/1000;

% compute cummulative integral of M(T). This is needed for later analysis
x=TAC.time_min;
y=TAC.ROI_activity_kbq;
TAC.int_m=cumtrapz(x,y);     % Int(M) calculation - Integral of brain TAC

clearvars x y folder contents currentFile myFile data; 





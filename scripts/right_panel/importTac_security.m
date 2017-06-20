% Description: this function enables you to import TAC from one folder
% and organize the data in a struct
% Date: Sep 28, 2015
% Written by Jenny-Ann Phan, MD-PhD student

function db=importtac
folder=uigetdir;
contents=dir(folder);
db=struct;
db.ROI_activity_Bq=[];
db.name = cell(1,1);
for currentFile=3:length(contents)
    myFile=[folder '/' contents(currentFile).name];
    data=dlmread(myFile,'\t',1); % function
    db.time_min=data(:,1);
    db.ROI_activity_Bq(:,currentFile-2)=data(:,5);
   
    % content inside {} indicate postion in db.name 
    db.name{currentFile-2}=contents(currentFile).name(1:end-4);    

end
% convert Bq to kBq
db.ROI_activity_kbq = db.ROI_activity_Bq/1000;

% compute integral of M(T)
x=db.time_min;
y=db.ROI_activity_kbq;
db.int_m=cumtrapz(x,y);     % Int(M) calculation
clearvars x y; 





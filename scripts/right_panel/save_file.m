[filename,pathname] = uiputfile('*.mat','Save Workspace As');

% if the user clicks cancel, delete the variable
if filename ==0;
    clear filename pathname;
end 

newfilename = fullfile(pathname, filename);
save(newfilename);


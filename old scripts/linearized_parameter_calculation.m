%%%%%%% Linearized parameters calculation %%%%%%%%%
% SLOPE
%% define structures for preallocation:
linearModel.slope.all_slopes=[];

% put all data into one struct (to display in GUI)
linearModel.slope.all_slopes(1,:)=  linearModel.slope.N1; % N1 | Cumming 1993
linearModel.slope.all_slopes(2,:)=  linearModel.slope.N2; % N2 | Gjedde 2000

linearModel.slope.all_slopes(3,:)=  linearModel.slope.P1; % P1 | Gjedde 1982
linearModel.slope.all_slopes(4,:)=  linearModel.slope.P2; % P2 | Logan 1990
linearModel.slope.all_slopes(5,:)=  linearModel.slope.P3; % P3 | Reith 1990
linearModel.slope.all_slopes(6,:)=  linearModel.slope.P4; % P4 | Nahimi 2015


%% define structures for preallocation:
linearModel.yIntercept.all_yIntercepts=[];

% put all data into one struct (to display in GUI)
linearModel.yIntercept.all_yIntercepts(1,:)=    linearModel.yIntercept.N1; % N1 | Cumming 1993
linearModel.yIntercept.all_yIntercepts(2,:)=    linearModel.yIntercept.N2; % N2 | Gjedde 2000

linearModel.yIntercept.all_yIntercepts(3,:)=    linearModel.yIntercept.P1; % P1 | Gjedde 1982
linearModel.yIntercept.all_yIntercepts(4,:)=    linearModel.yIntercept.P2; % P2 | Logan 1990
linearModel.yIntercept.all_yIntercepts(5,:)=    linearModel.yIntercept.P3; % P3 | Reith 1990
linearModel.yIntercept.all_yIntercepts(6,:)=    linearModel.yIntercept.P4; % P4 | Nahimi 2015

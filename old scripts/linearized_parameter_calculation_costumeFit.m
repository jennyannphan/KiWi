%%%%%%% Linearized parameters calculation %%%%%%%%%
% SLOPE
%% define structures for preallocation:
costumeFit.slope.all_slopes=[];

% put all data into one struct (to display in GUI)
costumeFit.slope.all_slopes(1,:)=  costumeFit.slope.N1; % N1 | Cumming 1993
costumeFit.slope.all_slopes(2,:)=  costumeFit.slope.N2; % N2 | Gjedde 2000

costumeFit.slope.all_slopes(3,:)=  costumeFit.slope.P1; % P1 | Gjedde 1982
costumeFit.slope.all_slopes(4,:)=  costumeFit.slope.P2; % P2 | Logan 1990
costumeFit.slope.all_slopes(5,:)=  costumeFit.slope.P3; % P3 | Reith 1990
costumeFit.slope.all_slopes(6,:)=  costumeFit.slope.P4; % P4 | Nahimi 2015


%% define structures for preallocation:
costumeFit.yIntercept.all_yIntercepts=[];

% put all data into one struct (to display in GUI)
costumeFit.yIntercept.all_yIntercepts(1,:)=    costumeFit.yIntercept.N1; % N1 | Cumming 1993
costumeFit.yIntercept.all_yIntercepts(2,:)=    costumeFit.yIntercept.N2; % N2 | Gjedde 2000

costumeFit.yIntercept.all_yIntercepts(3,:)=    costumeFit.yIntercept.P1; % P1 | Gjedde 1982
costumeFit.yIntercept.all_yIntercepts(4,:)=    costumeFit.yIntercept.P2; % P2 | Logan 1990
costumeFit.yIntercept.all_yIntercepts(5,:)=    costumeFit.yIntercept.P3; % P3 | Reith 1990
costumeFit.yIntercept.all_yIntercepts(6,:)=    costumeFit.yIntercept.P4; % P4 | Nahimi 2015

%%%% calculate yFitted values for plotting models %%%%

% define structures for preallocation:
linearModel.yFitted.N1=[] %preallocate struct | cumming 1993
linearModel.yFitted.N2=[] %preallocate struct | gjedde 2000

linearModel.yFitted.P1=[] %preallocate struct | gjedde 1982
linearModel.yFitted.P2=[] %preallocate struct | logan 1990
linearModel.yFitted.P3=[] %preallocate struct | reith 1990
linearModel.yFitted.P4=[] %preallocate struct | nahimi 2015

%% model N1 | Cumming 1993:
startFrame=BestFit.N1.firstInd; %best linear interval
endFrame=BestFit.N1.lastInd;    %best linear interval

x=dynamic.vol(startFrame:endFrame,:);
a=linearModel.slope.N1;
b=linearModel.yIntercept.N1;
ax=bsxfun(@times,a,x);
yFitted=bsxfun(@plus,ax,b);

linearModel.yFitted.N1=yFitted % insert fitted data into struct

clearvars a x ax b yFitted 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% model N2 | Gjedde 2000: 
startFrame=BestFit.N2.firstInd; %best linear interval
endFrame=BestFit.N2.lastInd;    %best linear interval

x=dynamic.kappa(startFrame:endFrame,:);
a=linearModel.slope.N2;
b=linearModel.yIntercept.N2;
ax=bsxfun(@times,a,x);
yFitted=bsxfun(@plus,ax,b);

linearModel.yFitted.N2=yFitted % insert fitted data into struct

clearvars a x ax b yFitted 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% model P1 | Gjedde 1982:
startFrame=BestFit.P1.firstInd; %best linear interval
endFrame=BestFit.P1.lastInd;    %best linear interval

x=dynamic.theta(startFrame:endFrame,:);
a=linearModel.slope.P1;
b=linearModel.yIntercept.P1;
ax=bsxfun(@times,a,x);
yFitted=bsxfun(@plus,ax,b);

linearModel.yFitted.P1=yFitted % insert fitted data into struct

clearvars a x ax b yFitted 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% model P2 | logan 1990: 
startFrame=BestFit.P2.firstInd; %best linear interval
endFrame=BestFit.P2.lastInd;    %best linear interval

x=dynamic.kappa_reciproc(startFrame:endFrame,:);
a=linearModel.slope.P2;
b=linearModel.yIntercept.P2;
ax=bsxfun(@times,a,x);
yFitted=bsxfun(@plus,ax,b);

linearModel.yFitted.P2=yFitted % insert fitted data into struct

clearvars a x ax b yFitted 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% model P3 | Reith 1990:
startFrame=BestFit.P3.firstInd; %best linear interval
endFrame=BestFit.P3.lastInd;    %best linear interval

x=dynamic.vol_reciproc(startFrame:endFrame,:);
a=linearModel.slope.P3;
b=linearModel.yIntercept.P3;
ax=bsxfun(@times,a,x);
yFitted=bsxfun(@plus,ax,b);

linearModel.yFitted.P3=yFitted % insert fitted data into struct

clearvars a x ax b yFitted startFrame endFrame
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% model P4 | Nahimi 2015: 
startFrame=BestFit.P4.firstInd; %best linear interval
endFrame=BestFit.P4.lastInd;    %best linear interval

x=dynamic.theta_reciproc(startFrame:endFrame,:);
a=linearModel.slope.P4;
b=linearModel.yIntercept.P4;
ax=bsxfun(@times,a,x);
yFitted=bsxfun(@plus,ax,b);

linearModel.yFitted.P4=yFitted % insert fitted data into struct

clearvars a x ax b yFitted startFrame endFrame
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



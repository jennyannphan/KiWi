%%%% calculate yFitted values for plotting models %%%%

% define structures for preallocation:
costumeFit.yFitted.N1=[] %preallocate struct | cumming 1993
costumeFit.yFitted.N2=[] %preallocate struct | gjedde 2000

costumeFit.yFitted.P1=[] %preallocate struct | gjedde 1982
costumeFit.yFitted.P2=[] %preallocate struct | logan 1990
costumeFit.yFitted.P3=[] %preallocate struct | reith 1990
costumeFit.yFitted.P4=[] %preallocate struct | nahimi 2015

%% model N1 Cumming 1993:

x=dynamic.vol(FrameStart_CostumeFit:FrameEnd_CostumeFit,:);
a=costumeFit.slope.N1;
b=costumeFit.yIntercept.N1;
ax=bsxfun(@times,a,x);
yFitted=bsxfun(@plus,ax,b);

costumeFit.yFitted.N1=yFitted % insert fitted data into struct

clearvars a x ax b yFitted 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% model N2 Gjedde 2000: 

x=dynamic.kappa(FrameStart_CostumeFit:FrameEnd_CostumeFit,:);
a=costumeFit.slope.N2;
b=costumeFit.yIntercept.N2;
ax=bsxfun(@times,a,x);
yFitted=bsxfun(@plus,ax,b);

costumeFit.yFitted.N2=yFitted % insert fitted data into struct

clearvars a x ax b yFitted 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% model P1 Gjedde 1982:

x=dynamic.theta(FrameStart_CostumeFit:FrameEnd_CostumeFit,:);
a=costumeFit.slope.P1;
b=costumeFit.yIntercept.P1;
ax=bsxfun(@times,a,x);
yFitted=bsxfun(@plus,ax,b);

costumeFit.yFitted.P1=yFitted % insert fitted data into struct

clearvars a x ax b yFitted 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% model P2 logan 1990: 

x=dynamic.kappa_reciproc(FrameStart_CostumeFit:FrameEnd_CostumeFit,:);
a=costumeFit.slope.P2;
b=costumeFit.yIntercept.P2;
ax=bsxfun(@times,a,x);
yFitted=bsxfun(@plus,ax,b);

costumeFit.yFitted.P2=yFitted % insert fitted data into struct

clearvars a x ax b yFitted 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% model P3 Reith 1990:

x=dynamic.vol_reciproc(FrameStart_CostumeFit:FrameEnd_CostumeFit,:);
a=costumeFit.slope.P3;
b=costumeFit.yIntercept.P3;
ax=bsxfun(@times,a,x);
yFitted=bsxfun(@plus,ax,b);

costumeFit.yFitted.P3=yFitted % insert fitted data into struct

clearvars a x ax b yFitted 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% model P4 Nahimi 2015: 

x=dynamic.theta_reciproc(FrameStart_CostumeFit:FrameEnd_CostumeFit,:);
a=costumeFit.slope.P4;
b=costumeFit.yIntercept.P4;
ax=bsxfun(@times,a,x);
yFitted=bsxfun(@plus,ax,b);

costumeFit.yFitted.P4=yFitted % insert fitted data into struct

clearvars a x ax b yFitted FrameStart_CostumeFit FrameEnd_CostumeFit
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


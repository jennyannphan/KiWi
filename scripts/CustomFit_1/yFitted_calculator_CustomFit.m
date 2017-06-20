%%%% calculate yFitted values for plotting models %%%%

% define structures for preallocation:
CustomFit.yFitted.N1=[] %preallocate struct | cumming 1993
CustomFit.yFitted.N2=[] %preallocate struct | gjedde 2000

CustomFit.yFitted.P1=[] %preallocate struct | gjedde 1982
CustomFit.yFitted.P2=[] %preallocate struct | logan 1990
CustomFit.yFitted.P3=[] %preallocate struct | reith 1990
CustomFit.yFitted.P4=[] %preallocate struct | nahimi 2015

%% model N1 Cumming 1993:

x=dynamic.vol(FrameStart_CustomFit:FrameEnd_CustomFit,:);
a=CustomFit.slope.N1;
b=CustomFit.yIntercept.N1;
ax=bsxfun(@times,a,x);
yFitted=bsxfun(@plus,ax,b);

CustomFit.yFitted.N1=yFitted % insert fitted data into struct

clearvars a x ax b yFitted 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% model N2 Gjedde 2000: 

x=dynamic.kappa(FrameStart_CustomFit:FrameEnd_CustomFit,:);
a=CustomFit.slope.N2;
b=CustomFit.yIntercept.N2;
ax=bsxfun(@times,a,x);
yFitted=bsxfun(@plus,ax,b);

CustomFit.yFitted.N2=yFitted % insert fitted data into struct

clearvars a x ax b yFitted 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% model P1 Gjedde 1982:

x=dynamic.theta(FrameStart_CustomFit:FrameEnd_CustomFit,:);
a=CustomFit.slope.P1;
b=CustomFit.yIntercept.P1;
ax=bsxfun(@times,a,x);
yFitted=bsxfun(@plus,ax,b);

CustomFit.yFitted.P1=yFitted % insert fitted data into struct

clearvars a x ax b yFitted 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% model P2 logan 1990: 

x=dynamic.kappa_reciproc(FrameStart_CustomFit:FrameEnd_CustomFit,:);
a=CustomFit.slope.P2;
b=CustomFit.yIntercept.P2;
ax=bsxfun(@times,a,x);
yFitted=bsxfun(@plus,ax,b);

CustomFit.yFitted.P2=yFitted % insert fitted data into struct

clearvars a x ax b yFitted 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% model P3 Reith 1990:

x=dynamic.vol_reciproc(FrameStart_CustomFit:FrameEnd_CustomFit,:);
a=CustomFit.slope.P3;
b=CustomFit.yIntercept.P3;
ax=bsxfun(@times,a,x);
yFitted=bsxfun(@plus,ax,b);

CustomFit.yFitted.P3=yFitted % insert fitted data into struct

clearvars a x ax b yFitted 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% model P4 Nahimi 2015: 

x=dynamic.theta_reciproc(FrameStart_CustomFit:FrameEnd_CustomFit,:);
a=CustomFit.slope.P4;
b=CustomFit.yIntercept.P4;
ax=bsxfun(@times,a,x);
yFitted=bsxfun(@plus,ax,b);

CustomFit.yFitted.P4=yFitted % insert fitted data into struct

clearvars a x ax b yFitted FrameStart_CustomFit FrameEnd_CustomFit
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


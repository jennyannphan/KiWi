%%%% calculate linear fits %%%%

% OVERVIEW: 
% How many files are interconnected?
% linear_fit_calculator -> linear_fit_organizer -> yFitted


%% kinetic model: N1 Cumming 1993 kappa=K1-k2*V_T

x=dynamic.vol(FrameStart_CustomFit:FrameEnd_CustomFit,:)
y=dynamic.kappa(FrameStart_CustomFit:FrameEnd_CustomFit,:)

CustomFit.fit.N1=[] % preallocation of space

index = size(x,2); ;
for k = 1:index;
    xn=x(:,k)
    yn=y(:,k)
md=fitlm(xn,yn,'linear');

CustomFit.fit.N1{2,k} = md

end 
[CustomFit.fit.N1(1,:)]=dynamic.name;

clearvars x y xn yn md k 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% kinetic model: N2 Gjedde 2000 Vol = V_T -(1/k2)*Kappa

x=dynamic.kappa(FrameStart_CustomFit:FrameEnd_CustomFit,:)
y=dynamic.vol(FrameStart_CustomFit:FrameEnd_CustomFit,:)

CustomFit.fit.N2=[] % preallocation of space

index = size(x,2); ;
for k = 1:index;
    xn=x(:,k)
    yn=y(:,k)
md=fitlm(xn,yn,'linear');

CustomFit.fit.N2{2,k} = md

end 
[CustomFit.fit.N2(1,:)]=dynamic.name;
clearvars x y xn yn md k 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% kinetic model: P1 Gjedde 1982 1/kappa=theta*(1/V_T)+(1/K1)

x=dynamic.theta(FrameStart_CustomFit:FrameEnd_CustomFit,:)
y=dynamic.kappa_reciproc(FrameStart_CustomFit:FrameEnd_CustomFit,:)

CustomFit.fit.P1=[] % preallocation of space

index = size(x,2); ;
for k = 1:index;
    xn=x(:,k)
    yn=y(:,k)
md=fitlm(xn,yn,'linear');

CustomFit.fit.P1{2,k} = md

end 
[CustomFit.fit.P1(1,:)]=dynamic.name;

clearvars x y xn yn md k 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% kinetic model: P2 Logan 1990 theta=V_T*(1/Kappa)-(1/k2)


x=dynamic.kappa_reciproc(FrameStart_CustomFit:FrameEnd_CustomFit,:)
y=dynamic.theta(FrameStart_CustomFit:FrameEnd_CustomFit,:)

CustomFit.fit.P2=[] % preallocation of space

index = size(x,2); ;
for k = 1:index;
    xn=x(:,k)
    yn=y(:,k)
md=fitlm(xn,yn,'linear');

CustomFit.fit.P2{2,k} = md

end 
[CustomFit.fit.P2(1,:)]=dynamic.name;
clearvars x y xn yn md k 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% kinetic model: P3 Reith 1990 1/theta=K1*(k2/k1)-k2

x=dynamic.vol_reciproc(FrameStart_CustomFit:FrameEnd_CustomFit,:)
y=dynamic.theta_reciproc(FrameStart_CustomFit:FrameEnd_CustomFit,:)

CustomFit.fit.P3=[] % preallocation of space

index = size(x,2); ;
for k = 1:index;
    xn=x(:,k)
    yn=y(:,k)
md=fitlm(xn,yn,'linear');

CustomFit.fit.P3{2,k} = md

end 
[CustomFit.fit.P3(1,:)]=dynamic.name;

clearvars x y xn yn md k 
         

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% kinetic model: P4 Nahimi 2015 1/vol=(1/theta)*(1/K1)+(1/V_T)

x=dynamic.theta_reciproc(FrameStart_CustomFit:FrameEnd_CustomFit,:)
y=dynamic.vol_reciproc(FrameStart_CustomFit:FrameEnd_CustomFit,:)

CustomFit.fit.P4=[] % preallocation of space

index = size(x,2); ;
for k = 1:index;
    xn=x(:,k)
    yn=y(:,k)
md=fitlm(xn,yn,'linear');

CustomFit.fit.P4{2,k} = md

end 
[CustomFit.fit.P4(1,:)]=dynamic.name;

clearvars x y xn yn md k 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% advance to next script

run linear_fit_organizer_CustomFit.m;
run yFitted_calculator_CustomFit.m;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




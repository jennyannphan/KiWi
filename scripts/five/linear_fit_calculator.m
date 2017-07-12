%%%% calculate linear fits %%%%

% OVERVIEW: 
% How many files are interconnected?
% linear_fit_calculator -> linear_fit_organizer -> yFitted

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% kinetic model: N1 [Cumming 1993 | kappa=K1-k2*V_T]

startFrame=BestFit.N1.firstInd
endFrame=BestFit.N1.lastInd

x=dynamic.vol(startFrame:endFrame,:)
y=dynamic.kappa(startFrame:endFrame,:)

linearModel.fit.N1=[] % preallocation of space

index = size(x,2); ;
for k = 1:index;
    xn=x(:,k)
    yn=y(:,k)
md=fitlm(xn,yn,'linear');

linearModel.fit.N1{2,k} = md

end 
[linearModel.fit.N1(1,:)]=dynamic.brain_region;

clearvars x y xn yn md k startFrame endFrame

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% kinetic model: N2   [Gjedde 2000 | Vol = V_T -(1/k2)*Kappa]
startFrame=BestFit.N2.firstInd
endFrame=BestFit.N2.lastInd

x=dynamic.kappa(startFrame:endFrame,:)
y=dynamic.vol(startFrame:endFrame,:)

linearModel.fit.N2=[] % preallocation of space

index = size(x,2); ;
for k = 1:index;
    xn=x(:,k)
    yn=y(:,k)
md=fitlm(xn,yn,'linear');

linearModel.fit.N2{2,k} = md

end 
[linearModel.fit.N2(1,:)]=dynamic.brain_region;
clearvars x y xn yn md k startFrame endFrame

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% kinetic model: P1 [Gjedde 1982 | 1/kappa=theta*(1/V_T)+(1/K1)]

startFrame=BestFit.P1.firstInd
endFrame=BestFit.P1.lastInd

x=dynamic.theta(startFrame:endFrame,:)
y=dynamic.kappa_reciproc(startFrame:endFrame,:)

linearModel.fit.P1=[] % preallocation of space

index = size(x,2); ;
for k = 1:index;
    xn=x(:,k)
    yn=y(:,k)
md=fitlm(xn,yn,'linear');

linearModel.fit.P1{2,k} = md

end 
[linearModel.fit.P1(1,:)]=dynamic.brain_region;

clearvars x y xn yn md k startFrame endFrame

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% kinetic model: P2 [Logan 1990 |  theta=V_T*(1/Kappa)-(1/k2)]

startFrame=BestFit.P2.firstInd
endFrame=BestFit.P2.lastInd

x=dynamic.kappa_reciproc(startFrame:endFrame,:)
y=dynamic.theta(startFrame:endFrame,:)

linearModel.fit.P2=[] % preallocation of space

index = size(x,2); ;
for k = 1:index;
    xn=x(:,k)
    yn=y(:,k)
md=fitlm(xn,yn,'linear');

linearModel.fit.P2{2,k} = md

end 
[linearModel.fit.P2(1,:)]=dynamic.brain_region;
clearvars x y xn yn md k startFrame endFrame

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% kinetic model: P3 [Reith 1990 | 1/theta=K1*(k2/k1)-k2]

startFrame=BestFit.P3.firstInd
endFrame=BestFit.P3.lastInd

x=dynamic.vol_reciproc(startFrame:endFrame,:)
y=dynamic.theta_reciproc(startFrame:endFrame,:)

linearModel.fit.P3=[] % preallocation of space

index = size(x,2); ;
for k = 1:index;
    xn=x(:,k)
    yn=y(:,k)
md=fitlm(xn,yn,'linear');

linearModel.fit.P3{2,k} = md

end 
[linearModel.fit.P3(1,:)]=dynamic.brain_region;

clearvars x y xn yn md k startFrame endFrame 
         
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% kinetic model: P4 [Nahimi 2015 | 1/vol=(1/theta)*(1/K1)+(1/V_T]

startFrame=BestFit.P4.firstInd
endFrame=BestFit.P4.lastInd

x=dynamic.theta_reciproc(startFrame:endFrame,:)
y=dynamic.vol_reciproc(startFrame:endFrame,:)

linearModel.fit.P4=[] % preallocation of space

index = size(x,2); ;
for k = 1:index;
    xn=x(:,k)
    yn=y(:,k)
md=fitlm(xn,yn,'linear');

linearModel.fit.P4{2,k} = md

end 
[linearModel.fit.P4(1,:)]=dynamic.brain_region;

clearvars x y xn yn md k startFrame endFrame

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% advance to next script

run linear_fit_organizer.m;
run yFitted_calculator.m;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


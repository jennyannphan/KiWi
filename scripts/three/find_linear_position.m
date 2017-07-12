% get_FrameWidth = get(tab3, handles.FrameWidth ,'string');
% FrameWidth = str2num(get_FrameWidth);

%OUTPUT = BestFit struct with best fit intervals (startframe, endframe) in different models
% clear earlier fits  

clearvars BestFit linearModel SteadyState % clear variable before new iterative analysis

%%%%%%%%%%%%%%%%%%%%%%%
%   N1 (Cumming 1993) 
%%%%%%%%%%%%%%%%%%%%%%%
FitColumn=iterative_region_idx;
x= dynamic.vol(1:end,FitColumn);
y=dynamic.kappa(1:end,FitColumn);

md = fitlm(x,y)
for k = 1:length(x)-FrameWidth+1;
    xn = x(k:k+FrameWidth-1)
    yn = y(k:k+FrameWidth-1)
    md = fitlm(xn,yn)
    BestFit.N1.rsq((k),1) = md.Rsquared.Ordinary   % calculates rsq for every fitting interval
    BestFit.N1.intercept(k,1)=md.Coefficients{1,1} % calculates Y-intercept for every fitting interval
    BestFit.N1.slope(k,1)=md.Coefficients{2,1} % calculates slope for every fitting interval
end

[max, BestFit.N1.firstInd] = max(BestFit.N1.rsq);
BestFit.N1.lastInd = BestFit.N1.firstInd + FrameWidth - 1

BestFit.N1.time_BestFit = TAC.time_min(BestFit.N1.firstInd:BestFit.N1.lastInd,1);

clearvars   md xn yn k firstInd lastInd max x y; 

%%%%%%%%%%%%%%%%%%%%%%%
%   N2 (Gjedde 2000)
%%%%%%%%%%%%%%%%%%%%%%%

x= dynamic.kappa(1:end,FitColumn);
y=dynamic.vol(1:end,FitColumn);

md = fitlm(x,y)
for k = 1:length(x)-FrameWidth+1;
    xn = x(k:k+FrameWidth-1)
    yn = y(k:k+FrameWidth-1)
    md = fitlm(xn,yn)
    BestFit.N2.rsq((k),1) = md.Rsquared.Ordinary  
    BestFit.N2.intercept(k,1)=md.Coefficients{1,1} 
    BestFit.N2.slope(k,1)=md.Coefficients{2,1} 
end

[max, BestFit.N2.firstInd] = max(BestFit.N2.rsq);
BestFit.N2.lastInd = BestFit.N2.firstInd + FrameWidth - 1

BestFit.N2.time_BestFit = TAC.time_min(BestFit.N2.firstInd:BestFit.N2.lastInd,1);

clearvars  md xn yn k firstInd lastInd max x y; 


%%%%%%%%%%%%%%%%%%%%%%%
%  P1 (Gjedde 1982) 
%%%%%%%%%%%%%%%%%%%%%%%

x= dynamic.theta(1:end,FitColumn);
y=dynamic.kappa_reciproc(1:end,FitColumn);

md = fitlm(x,y)
for k = 1:length(x)-FrameWidth+1;
    xn = x(k:k+FrameWidth-1)
    yn = y(k:k+FrameWidth-1)
    md = fitlm(xn,yn)
   BestFit.P1.rsq((k),1) = md.Rsquared.Ordinary
   BestFit.P1.intercept(k,1)=md.Coefficients{1,1} 
   BestFit.P1.slope(k,1)=md.Coefficients{2,1} 
end

[max,BestFit.P1.firstInd] = max(BestFit.P1.rsq);
BestFit.P1.lastInd =BestFit.P1.firstInd + FrameWidth - 1

BestFit.P1.time_BestFit = TAC.time_min(BestFit.P1.firstInd:BestFit.P1.lastInd,1);

clearvars  md xn yn k firstInd lastInd max x y; 


%%%%%%%%%%%%%%%%%%%%%%%
%  P2 (Logan 1990)
%%%%%%%%%%%%%%%%%%%%%%%

x= dynamic.kappa_reciproc(1:end,FitColumn);
y=dynamic.theta(1:end,FitColumn);

md = fitlm(x,y)
for k = 1:length(x)-FrameWidth+1;
    xn = x(k:k+FrameWidth-1)
    yn = y(k:k+FrameWidth-1)
    md = fitlm(xn,yn)
    BestFit.P2.rsq((k),1) = md.Rsquared.Ordinary
    BestFit.P2.intercept(k,1)=md.Coefficients{1,1} 
    BestFit.P2.slope(k,1)=md.Coefficients{2,1} 
end

[max, BestFit.P2.firstInd] = max(BestFit.P2.rsq);
BestFit.P2.lastInd = BestFit.P2.firstInd + FrameWidth - 1

BestFit.P2.time_BestFit = TAC.time_min(BestFit.P2.firstInd:BestFit.P2.lastInd,1);

clearvars  md xn yn k firstInd lastInd max x y; 

%%%%%%%%%%%%%%%%%%%%%%%
%   P3 (Reith 1990)
%%%%%%%%%%%%%%%%%%%%%%%

x= dynamic.vol_reciproc(1:end,FitColumn);
y=dynamic.theta_reciproc(1:end,FitColumn);

md = fitlm(x,y)
for k = 1:length(x)-FrameWidth+1;
    xn = x(k:k+FrameWidth-1)
    yn = y(k:k+FrameWidth-1)
    md = fitlm(xn,yn)
    BestFit.P3.rsq((k),1) = md.Rsquared.Ordinary
    BestFit.P3.intercept(k,1)=md.Coefficients{1,1} 
    BestFit.P3.slope(k,1)=md.Coefficients{2,1} 
end

[max, BestFit.P3.firstInd] = max(BestFit.P3.rsq);
BestFit.P3.lastInd = BestFit.P3.firstInd + FrameWidth - 1

BestFit.P3.time_BestFit = TAC.time_min(BestFit.P3.firstInd:BestFit.P3.lastInd,1);

clearvars   md xn yn k firstInd lastInd max x y; 


%%%%%%%%%%%%%%%%%%%%%%%
%   P4 (Nahimi 2015) 
%%%%%%%%%%%%%%%%%%%%%%%

x= dynamic.theta_reciproc(1:end,FitColumn);
y=dynamic.vol_reciproc(1:end,FitColumn);

md = fitlm(x,y)
for k = 1:length(x)-FrameWidth+1;
    xn = x(k:k+FrameWidth-1)
    yn = y(k:k+FrameWidth-1)
    md = fitlm(xn,yn)
    BestFit.P4.rsq((k),1) = md.Rsquared.Ordinary
    BestFit.P4.intercept(k,1)=md.Coefficients{1,1} 
    BestFit.P4.slope(k,1)=md.Coefficients{2,1} 
end

[max, BestFit.P4.firstInd] = max(BestFit.P4.rsq);
BestFit.P4.lastInd = BestFit.P4.firstInd + FrameWidth - 1

BestFit.P4.time_BestFit = TAC.time_min(BestFit.P4.firstInd:BestFit.P4.lastInd,1);

clearvars  md xn yn k firstInd lastInd max x y FitColumn; 

%Organize information of iterative analysis into structure called BestFit
BestFit.FrameConfig =[];
BestFit.FrameConfig.iterative_region={}
BestFit.FrameConfig.iterative_region{1,1}=iterative_region;
BestFit.FrameConfig.FrameWidth=FrameWidth;
BestFit.FrameConfig.iterative_region_idx=iterative_region_idx;
clearvars FrameWidth iterative_region iterative_region_idx;

% calculation of V_T as a function of time
BestFit.N1.VT=(BestFit.N1.intercept./BestFit.N1.slope)*-1;
BestFit.N2.VT=BestFit.N2.intercept;
BestFit.P1.VT=1./BestFit.P1.slope;

BestFit.P2.VT=BestFit.P2.slope;
BestFit.P3.VT= (BestFit.P3.slope./ BestFit.P3.intercept)*-1;
BestFit.P4.VT=1./BestFit.P4.intercept;

% rsq_all:
BestFit.rsq_all=[];
BestFit.rsq_all(:,1)=BestFit.N1.rsq;
BestFit.rsq_all(:,2)=BestFit.N2.rsq;
BestFit.rsq_all(:,3)=BestFit.P1.rsq;

BestFit.rsq_all(:,4)=BestFit.P2.rsq;
BestFit.rsq_all(:,5)=BestFit.P3.rsq;
BestFit.rsq_all(:,6)=BestFit.P4.rsq;

% VT_all
BestFit.VT_all=[];
BestFit.VT_all(:,1)=BestFit.N1.VT;
BestFit.VT_all(:,2)=BestFit.N2.VT;
BestFit.VT_all(:,3)=BestFit.P1.VT;
BestFit.VT_all(:,4)=BestFit.P2.VT;
BestFit.VT_all(:,5)=BestFit.P3.VT;
BestFit.VT_all(:,6)=BestFit.P4.VT;



%%%%%%%%%%%%%%%%%%%%%%%
BestFit.all_plots=[];
BestFit.all_plots(1,1)=BestFit.N1.firstInd;
BestFit.all_plots(1,2)=BestFit.N1.lastInd;
BestFit.all_plots(1,3)=TAC.time_min(BestFit.N1.firstInd,1);
BestFit.all_plots(1,4)=TAC.time_min(BestFit.N1.lastInd,1);

BestFit.all_plots(2,1)=BestFit.N2.firstInd;
BestFit.all_plots(2,2)=BestFit.N2.lastInd;
BestFit.all_plots(2,3)=TAC.time_min(BestFit.N2.firstInd,1);
BestFit.all_plots(2,4)=TAC.time_min(BestFit.N2.lastInd,1);

BestFit.all_plots(3,1)=BestFit.P1.firstInd;
BestFit.all_plots(3,2)=BestFit.P1.lastInd;
BestFit.all_plots(3,3)=TAC.time_min(BestFit.P1.firstInd,1);
BestFit.all_plots(3,4)=TAC.time_min(BestFit.P1.lastInd,1);

BestFit.all_plots(4,1)=BestFit.P2.firstInd;
BestFit.all_plots(4,2)=BestFit.P2.lastInd;
BestFit.all_plots(4,3)=TAC.time_min(BestFit.P2.firstInd,1);
BestFit.all_plots(4,4)=TAC.time_min(BestFit.P2.lastInd,1);

BestFit.all_plots(5,1)=BestFit.P3.firstInd;
BestFit.all_plots(5,2)=BestFit.P3.lastInd;
BestFit.all_plots(5,3)=TAC.time_min(BestFit.P3.firstInd,1);
BestFit.all_plots(5,4)=TAC.time_min(BestFit.P3.lastInd,1);

BestFit.all_plots(6,1)=BestFit.P4.firstInd;
BestFit.all_plots(6,2)=BestFit.P4.lastInd;
BestFit.all_plots(6,3)=TAC.time_min(BestFit.P4.firstInd,1);
BestFit.all_plots(6,4)=TAC.time_min(BestFit.P4.lastInd,1);


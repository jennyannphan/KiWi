% organize linear fit parameters (SLOPE and yInterceot) into new struct

% define structures for preallocation:
CustomFit.FrameConfig.FrameWidth=FrameEnd_CustomFit-FrameStart_CustomFit;
CustomFit.FrameConfig.FrameStart=FrameStart_CustomFit;
CustomFit.FrameConfig.FrameEnd=FrameEnd_CustomFit;

CustomFit.slope.N1=[] %preallocate struct | Cumming 1993
CustomFit.slope.N2=[] %preallocate struct | Gjedde 2000

CustomFit.slope.P1=[] %preallocate struct | Gjedde 1982
CustomFit.slope.P2=[] %preallocate struct | Logan 1990
CustomFit.slope.P3=[] %preallocate struct | Reith 1990
CustomFit.slope.P4=[] %preallocate struct | Nahimi 2015


%% SLOPE %% SLOPE %% SLOPE %% SLOPE %% SLOPE %% SLOPE %% SLOPE %% SLOPE
% model N1 Cumming 1993:
for k =1:index;
      data= table2array(CustomFit.fit.N1{2,k}.Coefficients(2,1));
       [CustomFit.slope.N1(1,k)]=data;
           
end
% model N2 Gjedde 2000:
for k =1:index;
      data= table2array(CustomFit.fit.N2{2,k}.Coefficients(2,1));
       [CustomFit.slope.N2(1,k)]=data;
           
end
% model P1 Gjedde 1982:
for k =1:index;
      data= table2array(CustomFit.fit.P1{2,k}.Coefficients(2,1));
       [CustomFit.slope.P1(1,k)]=data;
           
end
% model P2 Logan 1990:
for k =1:index;
      data= table2array(CustomFit.fit.P2{2,k}.Coefficients(2,1));
       [CustomFit.slope.P2(1,k)]=data;
           
end
% model P3 Reith 1990:
for k =1:index;
      data= table2array(CustomFit.fit.P3{2,k}.Coefficients(2,1));
       [CustomFit.slope.P3(1,k)]=data;
           
end
% model P4 Nahimi 2015:

for k =1:index;
      data= table2array(CustomFit.fit.P4{2,k}.Coefficients(2,1));
       [CustomFit.slope.P4(1,k)]=data;
           
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% define structures for preallocation:
CustomFit.yIntercept.N1=[] %preallocate struct | Cumming 1993
CustomFit.yIntercept.N2=[] %preallocate struct | Gjedde 2000

CustomFit.yIntercept.P1=[] %preallocate struct | Gjedde 1982
CustomFit.yIntercept.P2=[] %preallocate struct | Logan 1990
CustomFit.yIntercept.P3=[] %preallocate struct | Reith 1990
CustomFit.yIntercept.P4=[] %preallocate struct | Nahimi 2015

%% Y-INTERCEPT %% Y-INTERCEPT %% Y-INTERCEPT %% Y-INTERCEPT %% Y-INTERCEPT
% model N1 Cumming 1993:
for k =1:index;
      data= table2array(CustomFit.fit.N1{2,k}.Coefficients(1,1));
       [CustomFit.yIntercept.N1(1,k)]=data;
          
end

%% Y-INTERCEPT %% Y-INTERCEPT %% Y-INTERCEPT %% Y-INTERCEPT %% Y-INTERCEPT
% model N2 Gjedde 2000:
for k =1:index;
      data= table2array(CustomFit.fit.N2{2,k}.Coefficients(1,1));
       [CustomFit.yIntercept.N2(1,k)]=data;          
end

%% Y-INTERCEPT %% Y-INTERCEPT %% Y-INTERCEPT %% Y-INTERCEPT %% Y-INTERCEPT
% model P1 Gjedde 1982:
for k =1:index;
      data= table2array(CustomFit.fit.P1{2,k}.Coefficients(1,1));
       [CustomFit.yIntercept.P1(1,k)]=data;
           
end

%% Y-INTERCEPT %% Y-INTERCEPT %% Y-INTERCEPT %% Y-INTERCEPT %% Y-INTERCEPT
% model P2 Logan 1990:
for k =1:index;
      data= table2array(CustomFit.fit.P2{2,k}.Coefficients(1,1));
       [CustomFit.yIntercept.P2(1,k)]=data;
           
end

%% Y-INTERCEPT %% Y-INTERCEPT %% Y-INTERCEPT %% Y-INTERCEPT %% Y-INTERCEPT
% model P3 Reith 1990:
for k =1:index;
      data= table2array(CustomFit.fit.P3{2,k}.Coefficients(1,1));
       [CustomFit.yIntercept.P3(1,k)]=data;
           
end

%% Y-INTERCEPT %% Y-INTERCEPT %% Y-INTERCEPT %% Y-INTERCEPT %% Y-INTERCEPT
% model P4 Nahimi 2015:
for k =1:index;
      data= table2array(CustomFit.fit.P4{2,k}.Coefficients(1,1));
       [CustomFit.yIntercept.P4(1,k)]=data;
           
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% R-SQUARED %% R-SQUARED %% R-SQUARED %% R-SQUARED %% R-SQUARED
% model N1 Cumming 1993:
for k =1:index;
      data= CustomFit.fit.N1{2,k}.Rsquared.Ordinary;
       [CustomFit.SteadyState.rsq.N1(1,k)]=data;          
end

% model N2 Gjedde 2000:
for k =1:index;
      data= CustomFit.fit.N2{2,k}.Rsquared.Ordinary;
       [CustomFit.SteadyState.rsq.N2(1,k)]=data;          
end

% model P1 Gjedde 1982:
for k =1:index;
      data= CustomFit.fit.P1{2,k}.Rsquared.Ordinary;
       [CustomFit.SteadyState.rsq.P1(1,k)]=data;          
end

% model P2 Logan 1990:
for k =1:index;
      data= CustomFit.fit.P2{2,k}.Rsquared.Ordinary;
       [CustomFit.SteadyState.rsq.P2(1,k)]=data;          
end

% model P3 Reith 1990:
for k =1:index;
      data= CustomFit.fit.P3{2,k}.Rsquared.Ordinary;
       [CustomFit.SteadyState.rsq.P3(1,k)]=data;          
end

% model P4 Nahimi 2015:
for k =1:index;
      data= CustomFit.fit.P4{2,k}.Rsquared.Ordinary;
       [CustomFit.SteadyState.rsq.P4(1,k)]=data;          
end


clearvars     index k  data

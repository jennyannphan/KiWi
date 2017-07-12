% organize linear fit parameters (SLOPE and yInterceot) into new struct

% define structures for preallocation:
linearModel.slope.N1=[] %preallocate struct | Cumming 1993
linearModel.slope.N2=[] %preallocate struct | Gjedde 2000

linearModel.slope.P1=[] %preallocate struct | Gjedde 1982
linearModel.slope.P2=[] %preallocate struct | Logan 1990
linearModel.slope.P3=[] %preallocate struct | Reith 1990
linearModel.slope.P4=[] %preallocate struct | Nahimi 2015

%% SLOPE %% SLOPE %% SLOPE %% SLOPE %% SLOPE %% SLOPE %% SLOPE %% SLOPE
% model N1 | Cumming 1993:
for k =1:index;
      data= table2array(linearModel.fit.N1{2,k}.Coefficients(2,1));
       [linearModel.slope.N1(1,k)]=data;
           
end
% model N2 | Gjedde 2000:
for k =1:index;
      data= table2array(linearModel.fit.N2{2,k}.Coefficients(2,1));
       [linearModel.slope.N2(1,k)]=data;
           
end

% model P1 | Gjedde 1982:
for k =1:index;
      data= table2array(linearModel.fit.P1{2,k}.Coefficients(2,1));
       [linearModel.slope.P1(1,k)]=data;
           
end

% model P2 | Logan 1990:
for k =1:index;
      data= table2array(linearModel.fit.P2{2,k}.Coefficients(2,1));
       [linearModel.slope.P2(1,k)]=data;
           
end
% model P3 | Reith 1990:
for k =1:index;
      data= table2array(linearModel.fit.P3{2,k}.Coefficients(2,1));
       [linearModel.slope.P3(1,k)]=data;
           
end

% model P4 | Nahimi 2015:
for k =1:index;
      data= table2array(linearModel.fit.P4{2,k}.Coefficients(2,1));
       [linearModel.slope.P4(1,k)]=data;
           
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% define structures for preallocation:
linearModel.yIntercept.N1=[] %preallocate struct  | Cumming 1993
linearModel.yIntercept.N2=[] %preallocate struct  | Gjedde 2000

linearModel.yIntercept.P1=[] %preallocate struct  | Gjedde 1982
linearModel.yIntercept.P2=[] %preallocate struct  | Logan 1990
linearModel.yIntercept.P4=[] %preallocate struct  | Nahimi 2015
linearModel.yIntercept.P3=[] %preallocate struct  |Reith 1990
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Y-INTERCEPT %% Y-INTERCEPT %% Y-INTERCEPT %% Y-INTERCEPT %% Y-INTERCEPT
% model N1 | Cumming 1993:
for k =1:index;
      data= table2array(linearModel.fit.N1{2,k}.Coefficients(1,1));
       [linearModel.yIntercept.N1(1,k)]=data;
          
end
% model N2 | Gjedde 2000:
for k =1:index;
      data= table2array(linearModel.fit.N2{2,k}.Coefficients(1,1));
       [linearModel.yIntercept.N2(1,k)]=data;          
end

% model P1 | Gjedde 1982:
for k =1:index;
      data= table2array(linearModel.fit.P1{2,k}.Coefficients(1,1));
       [linearModel.yIntercept.P1(1,k)]=data;
           
end

% model P2 | Logan 1990:
for k =1:index;
      data= table2array(linearModel.fit.P2{2,k}.Coefficients(1,1));
       [linearModel.yIntercept.P2(1,k)]=data;
           
end

% model P3 | Reith 1990:
for k =1:index;
      data= table2array(linearModel.fit.P3{2,k}.Coefficients(1,1));
       [linearModel.yIntercept.P3(1,k)]=data;
          
end

% model P4 | Nahimi 2015:
for k =1:index;
      data= table2array(linearModel.fit.P4{2,k}.Coefficients(1,1));
       [linearModel.yIntercept.P4(1,k)]=data;
           
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% R-SQUARED %% R-SQUARED %% R-SQUARED %% R-SQUARED %% R-SQUARED
% model N1 | Cumming 1993:
for k =1:index;
      data= linearModel.fit.N1{2,k}.Rsquared.Ordinary;
       [SteadyState.rsq.N1(1,k)]=data;          
end

% model N2 | Gjedde 2000:
for k =1:index;
      data= linearModel.fit.N2{2,k}.Rsquared.Ordinary;
       [SteadyState.rsq.N2(1,k)]=data;          
end

% model P1 | Gjedde 1982:
for k =1:index;
      data= linearModel.fit.P1{2,k}.Rsquared.Ordinary;
       [SteadyState.rsq.P1(1,k)]=data;          
end

% model P2 | Logan 1990:
for k =1:index;
      data= linearModel.fit.P2{2,k}.Rsquared.Ordinary;
       [SteadyState.rsq.P2(1,k)]=data;          
end

% model P3 | Reith 1990:
for k =1:index;
      data= linearModel.fit.P3{2,k}.Rsquared.Ordinary;
       [SteadyState.rsq.P3(1,k)]=data;          
end

% model P4 | Nahimi 2015:
for k =1:index;
      data= linearModel.fit.P4{2,k}.Rsquared.Ordinary;
       [SteadyState.rsq.P4(1,k)]=data;          
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clearvars     index k  data

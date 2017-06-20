% KiWi |Kinetics Kiwi| 
function KiWi_02
%% %%%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Configure frame
%%%%%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%
h.fig2 = figure('MenuBar', 'none','units','pixels','Position', [0 0 1280 750],... % [x,y,width, height]
    'name','KiWi | Kinetics KiWi | Default fit','numbertitle','off','Resize', 'off');
tgroup = uitabgroup('Parent', h.fig2,'units','pixels','Position', [0 0 1280 750]); 

% Define tabs
tab1 = uitab('Parent', tgroup, 'Title', '1| Fitting frames');
tab2 = uitab('Parent', tgroup, 'Title', '2| Steady state parameters');

tab3 = uitab('Parent', tgroup, 'Title', '3| Linearized fit values');

%%%%%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%
%TAB1: LINEARIZED PLOTS - BEST FIT
%%%%%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Define buttons:
handles.button_best_fit = uicontrol('Parent', tab1,...
    'Style','pushbutton','String','Compute parameters of best fit',...
    'Position',[20 650 180 25], 'Callback', 'linear_fit_calculator'); % calculate parameters at best fit
         
handles.button_steady_state_para = uicontrol('Parent', tab1, 'Style','pushbutton',...
             'String','Display plots of best fit','Position',[20 620 180 25], 'Callback', {@best_fit}); 

        
%% Define axes   
handles.ax_N1 = axes('Parent', tab1 , 'units', 'pixels', 'Position',[250 410 300 250]);
handles.ax_N2 = axes('Parent', tab1 ,'units', 'pixels', 'Position',[250 60 300 250]);

handles.ax_P1 = axes('Parent', tab1 , 'units', 'pixels', 'Position',[600 410 300 250]);
handles.ax_P2 = axes('Parent', tab1 , 'units', 'pixels', 'Position',[600 60 300 250]);
handles.ax_P3 = axes('Parent', tab1 , 'units', 'pixels', 'Position',[950 410 300 250]);
handles.ax_P4 = axes('Parent', tab1 , 'units', 'pixels', 'Position',[950 60 300 250]);




%% Set graph titles 
 set(get(handles.ax_N1, 'Title'), 'String', 'N1');
 set(get(handles.ax_N2, 'Title'), 'String', 'N2');
 set(get(handles.ax_P1, 'Title'), 'String', 'P1');
 set(get(handles.ax_P2, 'Title'), 'String', 'P2'); 
 set(get(handles.ax_P3, 'Title'), 'String', 'P3');
 set(get(handles.ax_P4, 'Title'), 'String', 'P4');


 %% Set axes titles for dynamic parameters (Upper row)
 set(get(handles.ax_N2, 'XLabel'), 'String', '|Kappa|      \kappa [ml cm^{-3} min^{-1}]', 'FontSize', 10, 'FontName', 'Arial');
 set(get(handles.ax_N2, 'YLabel'), 'String', '|Vol|     \nu [ml cm^{-3}]', 'FontSize', 10, 'FontName', 'Arial');     
 set(get(handles.ax_P2, 'XLabel'), 'String', '|1/Kappa|     \kappa^{-1} [min cm^{3} ml^{-1}]', 'FontSize', 10, 'FontName', 'Arial');
 set(get(handles.ax_P2, 'YLabel'), 'String', '|Theta|     \Theta [min]', 'FontSize', 10, 'FontName', 'Arial');
 set(get(handles.ax_P4, 'XLabel'), 'String', '|1/Theta|     \Theta^{-1} [min^{-1}]', 'FontSize', 10, 'FontName', 'Arial');
 set(get(handles.ax_P4, 'YLabel'), 'String', '|1/Vol|     \nu^{-1} [cm{3} ml^{-1}]', 'FontSize', 10, 'FontName', 'Arial');
 
 %% Set axes titles for RECIPROCAL dynamic parameters (Lower row)
 set(get(handles.ax_N1, 'XLabel'), 'String', '|Vol|     \nu [ml cm^{-3}]', 'FontSize', 10, 'FontName', 'Arial');
 set(get(handles.ax_N1, 'YLabel'), 'String', '|Kappa|      \kappa [ml cm^{-3} min^{-1}]', 'FontSize', 10, 'FontName', 'Arial');     
 set(get(handles.ax_P1, 'XLabel'), 'String', '|Theta|     \Theta [min]', 'FontSize', 10, 'FontName', 'Arial');
 set(get(handles.ax_P1, 'YLabel'), 'String', '|1/Kappa|     \kappa^{-1} [min cm^{3} ml^{-1}]', 'FontSize', 10, 'FontName', 'Arial');
 set(get(handles.ax_P3, 'XLabel'), 'String', '|1/Vol|     \nu^{-1} [cm{3} ml^{-1}]', 'FontSize', 10, 'FontName', 'Arial');
 set(get(handles.ax_P3, 'YLabel'), 'String', '|1/Theta|     \Theta^{-1} [min^{-1}]', 'FontSize', 10, 'FontName', 'Arial');


 function best_fit(source,eventdata) % calculates time window of best linear fit
     %% get dynamic parameters:
     kappa = evalin('base','dynamic.kappa');
     theta = evalin('base','dynamic.theta');
     vol= evalin ('base','dynamic.vol');
     
     kappa_reciproc = evalin ('base','dynamic.kappa_reciproc');
     theta_reciproc = evalin ('base','dynamic.theta_reciproc');
     vol_reciproc = evalin ('base','dynamic.vol_reciproc');
     
%% get yFitted parameters: 
y_N1=evalin('base','linearModel.yFitted.N1');    %kappa fitted           % N1 Cumming1993     
y_N2= evalin('base','linearModel.yFitted.N2');   %vol fitted             % N2 Gjedde 2000
     
y_P1=evalin('base','linearModel.yFitted.P1');    %kappa_reciproc fitted  % P1 Gjedde 1982
y_P2=evalin('base','linearModel.yFitted.P2');    %theta fitted           % P2 Logan 1990 
y_P3=evalin('base','linearModel.yFitted.P3');    %theta_reciproc fitted  % P3 Reith 1990
y_P4=evalin('base','linearModel.yFitted.P4');    %vol_reciproc fitted    % P4 Nahimi 2015
     
     
    
     
%% define best fit frames :
    frame_start_N1 = evalin ('base','bestFit.N1.firstInd');         % N1 Cumming1993     
    frame_end_N1 = evalin ('base','bestFit.N1.lastInd');
    
    frame_start_N2 = evalin ('base','bestFit.N2.firstInd');         % N2 Gjedde 2000
    frame_end_N2 = evalin ('base','bestFit.N2.lastInd');
     
    frame_start_P1 = evalin ('base','bestFit.P1.firstInd');         % P1 Gjedde 1982
    frame_end_P1 = evalin ('base','bestFit.P1.lastInd');
    
    frame_start_P2 = evalin ('base','bestFit.P2.firstInd');         % P2 Logan 1990 
    frame_end_P2 = evalin ('base','bestFit.P2.lastInd');
     
    frame_start_P3 = evalin ('base','bestFit.P3.firstInd');         % P3 Reith 1990
    frame_end_P3 = evalin ('base','bestFit.P3.lastInd');
    
     frame_start_P4 = evalin ('base','bestFit.P4.firstInd');        % P4 Nahimi 2015
     frame_end_P4 = evalin ('base','bestFit.P4.lastInd');
     

%%% now plot best fit intervals - upper row:
    
% plot N2 gjedde 2000:   
[pax,pLine1,pLine2] = plotyy(handles.ax_N2,...
         kappa(frame_start_N2:frame_end_N2,:),...
         vol(frame_start_N2:frame_end_N2,:),...
         kappa(frame_start_N2:frame_end_N2,:),...
         y_N2);
     
set(pLine1, 'marker', 'o',...
            'markersize',2.5,...
            'linewidth',2,...
            'linestyle', 'none');
        
set(pLine2, 'linestyle', '-','linewidth',1);
set(pax(2),'ytick',[]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% plot P2 logan 1990
[pax,pLine1,pLine2] = plotyy(handles.ax_P2,...
         kappa_reciproc(frame_start_P2:frame_end_P2,:),...
         theta(frame_start_P2:frame_end_P2,:),...
         kappa_reciproc(frame_start_P2:frame_end_P2,:),...
         y_P2);
     
set(pLine1, 'marker', 'o',...
            'markersize',2.5,...
            'linewidth',2,...
            'linestyle', 'none');
        
set(pLine2, 'linestyle', '-','linewidth',1);
set(pax(2),'ytick',[]);   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         
%% plot P4 Nahimi 2015     
[pax,pLine1,pLine2] = plotyy(handles.ax_P4,...
         theta_reciproc(frame_start_P4:frame_end_P4,:),...
         vol_reciproc(frame_start_P4:frame_end_P4,:),...
         theta_reciproc(frame_start_P4:frame_end_P4,:),...
         y_P4);
set(pLine1, 'marker', 'o',...
            'markersize',2.5,...
            'linewidth',2,...
            'linestyle', 'none');
        
set(pLine2, 'linestyle', '-','linewidth',1);
set(pax(2),'ytick',[]);   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                  

%% plot N1 cumming 1993:         
[pax,pLine1,pLine2] = plotyy(handles.ax_N1,...
         vol(frame_start_N1:frame_end_N1,:),...
         kappa(frame_start_N1:frame_end_N1,:),...
         vol(frame_start_N1:frame_end_N1,:),...
         y_N1);
     
set(pLine1, 'marker', 'o',...
            'markersize',2.5,...
            'linewidth',2,...
            'linestyle', 'none');
        
set(pLine2, 'linestyle', '-','linewidth',1);
set(pax(2),'ytick',[]);        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                  

%% plot P1 Gjedde 1982:        

[pax,pLine1,pLine2] = plotyy(handles.ax_P1,...
         theta(frame_start_P1:frame_end_P1,:),...
         kappa_reciproc(frame_start_P1:frame_end_P1,:),...
         theta(frame_start_P1:frame_end_P1,:),...
         y_P1);
set(pLine1, 'marker', 'o',...
            'markersize',2.5,...
            'linewidth',2,...
            'linestyle', 'none');
        
set(pLine2, 'linestyle', '-','linewidth',1);
set(pax(2),'ytick',[]);                      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% plot Reith 1990:        

[pax,pLine1,pLine2] = plotyy(handles.ax_P3,...
         vol_reciproc(frame_start_P3:frame_end_P3,:),...
         theta_reciproc(frame_start_P3:frame_end_P3,:),...
         vol_reciproc(frame_start_P3:frame_end_P3,:),...
         y_P3);
set(pLine1, 'marker', 'o',...
            'markersize',2.5,...
            'linewidth',2,...
            'linestyle', 'none');
        
set(pLine2, 'linestyle', '-','linewidth',1);
set(pax(2),'ytick',[]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     
%%     %%%%%%%%%%%%%%%%%%%% Show legends %%%%%%%%%%%%%%%%%%%%%%%%%%
    handle_legend = evalin('base','ans.name');
    legend(handles.ax_P3,handle_legend, 'Location', 'none', [75 150 1 1]) ;%[20 620 180 25] 
    
%% redefine axes and title 
%Set graph titles 
set(get(handles.ax_N1, 'Title'), 'String', 'N1'); 
set(get(handles.ax_N2, 'Title'), 'String', 'N2');


 set(get(handles.ax_P1, 'Title'), 'String', 'P1');
 set(get(handles.ax_P2, 'Title'), 'String', 'P2');
 set(get(handles.ax_P3, 'Title'), 'String', 'P3');
 set(get(handles.ax_P4, 'Title'), 'String', 'P4');
 

 %% Set axes titles for dynamic parameters 
 set(get(handles.ax_N1, 'XLabel'), 'String', '|Vol|     \nu [ml cm^{-3}]', 'FontSize', 10, 'FontName', 'Arial');
 set(get(handles.ax_N1, 'YLabel'), 'String', '|Kappa|      \kappa [ml cm^{-3} min^{-1}]', 'FontSize', 10, 'FontName', 'Arial');     
 
 set(get(handles.ax_N2, 'XLabel'), 'String', '|Kappa|      \kappa [ml cm^{-3} min^{-1}]', 'FontSize', 10, 'FontName', 'Arial');
 set(get(handles.ax_N2, 'YLabel'), 'String', '|Vol|     \nu [ml cm^{-3}]', 'FontSize', 10, 'FontName', 'Arial');     
 
 set(get(handles.ax_P1, 'XLabel'), 'String', '|Theta|     \Theta [min]', 'FontSize', 10, 'FontName', 'Arial');
 set(get(handles.ax_P1, 'YLabel'), 'String', '|1/Kappa|     \kappa^{-1} [min cm^{3} ml^{-1}]', 'FontSize', 10, 'FontName', 'Arial');
 
 set(get(handles.ax_P2, 'XLabel'), 'String', '|1/Kappa|     \kappa^{-1} [min cm^{3} ml^{-1}]', 'FontSize', 10, 'FontName', 'Arial');
 set(get(handles.ax_P2, 'YLabel'), 'String', '|Theta|     \Theta [min]', 'FontSize', 10, 'FontName', 'Arial');
 
 set(get(handles.ax_P3, 'XLabel'), 'String', '|1/Vol|     \nu^{-1} [cm{3} ml^{-1}]', 'FontSize', 10, 'FontName', 'Arial');
 set(get(handles.ax_P3, 'YLabel'), 'String', '|1/Theta|     \Theta^{-1} [min^{-1}]', 'FontSize', 10, 'FontName', 'Arial');
 
 set(get(handles.ax_P4, 'XLabel'), 'String', '|1/Theta|     \Theta^{-1} [min^{-1}]', 'FontSize', 10, 'FontName', 'Arial');
 set(get(handles.ax_P4, 'YLabel'), 'String', '|1/Vol|     \nu^{-1} [cm{3} ml^{-1}]', 'FontSize', 10, 'FontName', 'Arial');
 


 end

%%%%%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%
%TAB2: SHOW STEADY STATE DATA
%%%%%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% define buttons
handles.button = uicontrol('Parent', tab2, 'Style','pushbutton',...
    'String','Compute steady state parameters',...
    'Position',[20 650 180 25], 'Callback', 'steady_state_parameters_calculator'); % [x,y,width, height]

handles.button = uicontrol('Parent', tab2, 'Style','pushbutton',...
    'String','Display steady state parameters',...
    'Position',[20 620 180 25], 'Callback', {@display_steady_state_parameters}); % [x,y,width, height]

%% Define text 
handles.heading = uicontrol('Parent', tab2, 'Style','text',...
    'String','Volume of distribution',...
    'fontsize', 10, ...
    'fontweight', 'bold',...
    'horizontalAlignment', 'left',...
    'Position',[20 560 150 25], 'Callback', 'steady_state_parameters_calculator'); % [x,y,width, height]

handles.heading = uicontrol('Parent', tab2, 'Style','text',...
    'String','Rate constant K1',...
    'fontsize', 10, ...
    'fontweight', 'bold',...
    'horizontalAlignment', 'left',...
    'Position',[20 360 150 25], 'Callback', 'steady_state_parameters_calculator'); % [x,y,width, height]

handles.heading = uicontrol('Parent', tab2, 'Style','text',...
    'String','Rate constant k2',...
    'fontsize', 10, ...
    'fontweight', 'bold',...
    'horizontalAlignment', 'left',...
    'Position',[20 160 150 25], 'Callback', 'steady_state_parameters_calculator'); % [x,y,width, height]


%% define table V_T
columnname=evalin('base','ans.name');

handles.uitable_VT = uitable('Parent', tab2,...
        'ColumnName', columnname,...
        'rowname', {'N1 plot', 'N2 plot', 'P1 plot','P2 plot',....
        'P3 plot', 'P4 plot'},...
        'Position',[20 430 1150 130]);
    
% define table K1
handles.uitable_K1 = uitable('Parent', tab2,...
        'ColumnName', columnname,...
        'rowname', {'N1 plot', 'N2 plot', 'P1 plot','P2 plot',....
        'P3 plot', 'P4 plot'},...
        'Position',[20 230 1150 130]);
     
% define table k2
handles.uitable_k2 = uitable('Parent', tab2,...
        'ColumnName', columnname,...
        'rowname', {'N1 plot', 'N2 plot', 'P1 plot','P2 plot',....
        'P3 plot', 'P4 plot'},...
        'Position',[20 30 1150 130]);
    
    function display_steady_state_parameters (source,eventdata)
        V_T= evalin('base', 'steadyState.V_T.all_plots');
        K1=evalin('base', 'steadyState.K1.all_plots');
        k2=evalin('base', 'steadyState.k2.all_plots');
        
        set(handles.uitable_VT, 'Visible', 'on');
        set(handles.uitable_VT, 'Data', V_T, 'ColumnFormat', {'numeric'});
      
        set(handles.uitable_K1, 'Visible', 'on');
        set(handles.uitable_K1, 'Data', K1, 'ColumnFormat', {'numeric'});
       
        set(handles.uitable_k2, 'Visible', 'on');
        set(handles.uitable_k2, 'Data', k2, 'ColumnFormat', {'numeric'});     
    end


%% %%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%
%TAB3: SHOW LINEARIZED FIT VALUES
%%%%%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% define buttons
handles.button = uicontrol('Parent', tab3, 'Style','pushbutton',...
    'String','Compute linearized fit values',...
    'Position',[20 650 180 25], 'Callback', 'linearized_parameter_calculation'); % [x,y,width, height]

handles.button = uicontrol('Parent', tab3, 'Style','pushbutton',...
    'String','Display steady state parameters',...
    'Position',[20 620 180 25], 'Callback', {@display_linearized_parameters}); % [x,y,width, height]

%% define table Slope
columnname=evalin('base','ans.name');

handles.uitable_slope = uitable('Parent', tab3,...
        'ColumnName', columnname,...
        'rowname', {'N1 plot', 'N2 plot', 'P1 plot',....
        'P2 plot', 'P3 plot', 'P4 plot'},...
        'Position',[20 430 1150 130]);
    
% define table yIntercept
handles.uitable_yIntercept = uitable('Parent', tab3,...
        'ColumnName', columnname,...
        'rowname', {'N1 plot', 'N2 plot', 'P1 plot',....
        'P2 plot', 'P3 plot', 'P4 plot'},...
        'Position',[20 230 1150 130]);

% define table RSquared
handles.uitable_RSquared = uitable('Parent', tab3,...
        'ColumnName', columnname,...
        'rowname', {'N1 plot', 'N2 plot', 'P1 plot',....
        'P2 plot', 'P3 plot', 'P4 plot'},...
        'Position',[20 30 1150 130]);    
        
%% callback function to display all linearized data
    function display_linearized_parameters (source,eventdata)
        slope=evalin('base', 'linearModel.slope.all_slopes');
        yIntercept=evalin('base', 'linearModel.yIntercept.all_yIntercepts');
        rsq =evalin('base', 'steadyState.rsq.all_plots');

        set(handles.uitable_slope, 'Visible', 'on');
        set(handles.uitable_slope, 'Data', slope, 'ColumnFormat', {'numeric'});
        
        set(handles.uitable_yIntercept, 'Visible', 'on');
        set(handles.uitable_yIntercept, 'Data', yIntercept, 'ColumnFormat', {'numeric'});
        
        set(handles.uitable_RSquared, 'Visible', 'on');
        set(handles.uitable_RSquared, 'Data', rsq, 'ColumnFormat', {'numeric'});
    end

%% Define text 
handles.heading = uicontrol('Parent', tab3, 'Style','text',...
    'String','Slope',...
    'fontsize', 10, ...
    'fontweight', 'bold',...
    'horizontalAlignment', 'left',...
    'Position',[20 560 150 25], 'Callback', 'steady_state_parameters_calculator'); % [x,y,width, height]

handles.heading = uicontrol('Parent', tab3, 'Style','text',...
    'String','Y-intercept',...
    'fontsize', 10, ...
    'fontweight', 'bold',...
    'horizontalAlignment', 'left',...
    'Position',[20 360 150 25], 'Callback', 'steady_state_parameters_calculator'); % [x,y,width, height]

handles.heading = uicontrol('Parent', tab3, 'Style','text',...
    'String','R-squared',...
    'fontsize', 10, ...
    'fontweight', 'bold',...
    'horizontalAlignment', 'left',...
    'Position',[20 160 150 25], 'Callback', 'steady_state_parameters_calculator'); % [x,y,width, height]

end

% KiWi |Kinetics Windows| 
function KiWi_custom
%% open in the center of screen
size = [1500 850]; % figure size
screensize = get(0,'ScreenSize'); % find screen size
xpos = ceil((screensize(3)-size(1))/2); % center the figure on the screen horizontally
ypos = ceil((screensize(4)-size(2))/2); % center the figure on the screen vertically

%% Configure frame
h.custom = figure('MenuBar', 'none','units','pixels','Position', [xpos+50 ypos+50 size(1) size(2)],... % [x,y,width, height]
    'name','KiWi | Kinetics Windows | - STEP 1','numbertitle','off','Resize', 'off');

tgroup = uitabgroup('Parent', h.custom,'units','pixels',...
      'Position', [0 0  size(1) size(2)]); 

% Define tabs
tab1 = uitab('Parent', tgroup, 'Title', 'Insert Frames');
tab2 = uitab('Parent', tgroup, 'Title', 'Display Results');


%% predefine paths
ImageDir = strcat(pwd,'\elements');
addpath(genpath('./scripts/CustomFit_1'));
addpath(genpath('./scripts/CustomFit_2'));

%% %%%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TAB 1: INSERT START AND END FRAMES
%%%%%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%%

handles.background = axes('Parent', tab1 , 'units', 'pixels','Position',[0 0 1500 820]);
background=imread([ImageDir '/' 'background_custom.png']);
imshow(background);
set(handles.background,'handlevisibility','off', 'visible','off');

panel_custom_1=imread([ImageDir '/' 'panel_custom_1.png']);  
handles.logo = uicontrol('Parent', tab1, 'Style','Pushbutton', 'Position',[0 0 270  820], 'CData',panel_custom_1); 
 
frame_start=imread([ImageDir '/' 'frame_start.png']); 
handles.frame_start = uicontrol('Parent', tab1, 'Style','Pushbutton', 'Position',[112 660 132  36], 'CData',frame_start, ...
        'Callback', {@get_frame_start});

frame_end=imread([ImageDir '/' 'frame_end.png']); 
handles.frame_start = uicontrol('Parent', tab1, 'Style','Pushbutton', 'Position',[112 620 132  36], 'CData',frame_end, ...
        'Callback', {@get_frame_end});
    
handles.editbox_frame_start = uicontrol('Parent', tab1, 'style','edit',...
            'units','pixels',...
            'position',[58 663 50 30],...  
            'string','insert',...
            'foregroundcolor',[122, 120, 118]./255) ;    % color code indicates RGB value in a vector divided by 255
        
handles.editbox_frame_end = uicontrol('Parent', tab1, 'style','edit',...
    'units','pixels',...
    'position',[58 623 50 30],...  
    'string','insert',...
    'foregroundcolor',[122, 120, 118]./255);            % color code indicates RGB value in a vector divided by 255     

custom_compute_values=imread([ImageDir '/' 'custom_compute_values.png']);  
handles.button_plot_dyn = uicontrol('Parent', tab1, 'Style','Pushbutton', 'Position',[50 580 196  36], 'CData',custom_compute_values, ...
          'Callback', 'linear_fit_calculator_CustomFit');
      
custom_plot_linearizations=imread([ImageDir '/' 'custom_plot_linearizations.png']);  
handles.button_plot_dyn = uicontrol('Parent', tab1, 'Style','Pushbutton', 'Position',[50 540 196  36], 'CData',custom_plot_linearizations, ...
          'Callback', {@display_CustomFit});
      
%% functions
    function get_frame_start(source, eventdata)
      s=  str2double(get(handles.editbox_frame_start, 'string'));
       assignin('base', 'FrameStart_CustomFit', s);
    end

 function get_frame_end(source, eventdata)
      s=  str2double(get(handles.editbox_frame_end, 'string'));
       assignin('base', 'FrameEnd_CustomFit', s);
 end

panel_1_1_custom= uipanel('parent', tab1,'fontsize',12,...
    'backgroundColor','white',...
    'units','pixels',...
    'Position', [300 415 360 360]);

panel_1_2_custom= uipanel('parent', tab1,'fontsize',12,...
    'backgroundColor','white',...
    'units','pixels',...
    'Position', [300+360+15 415 360 360]);

panel_1_3_custom= uipanel('parent', tab1,'fontsize',12,...
    'backgroundColor','white',...
    'units','pixels',...
    'Position', [300+(360*2)+30 415 360 360]);

panel_1_4_custom= uipanel('parent', tab1,'fontsize',12,...
    'backgroundColor','white',...
    'units','pixels',...s
    'Position', [300 30 360 360]);

panel_1_5_custom= uipanel('parent', tab1,'fontsize',12,...
    'backgroundColor','white',...
    'units','pixels',...
    'Position', [300+360+15 30 360 360]);

panel_1_6_custom= uipanel('parent', tab1,'fontsize',12,...
    'backgroundColor','white',...
    'units','pixels',...
    'Position', [300+360*2+30 30 360 360]);

panel_legend= uipanel('parent', tab1,'fontsize',12,...
    'backgroundColor','white',...
    'units','pixels',...
    'Position', [65 170 180 220]);


%% Set axes PLOT linearized models
handles.ax_N1 = axes('Parent', panel_1_1_custom , 'units', 'pixels', 'Position',[60 50 280 280]);
 set(get(handles.ax_N1, 'XLabel'), 'String', '|Vol|     \nu [ml cm^{-3}]', 'FontSize', 10, 'FontName', 'Arial');
 set(get(handles.ax_N1, 'YLabel'), 'String', '|Kappa|      \kappa [ml cm^{-3} min^{-1}]', 'FontSize', 10, 'FontName', 'Arial');       

handles.ax_P1 = axes('Parent', panel_1_2_custom , 'units', 'pixels', 'Position',[60 50 280 280]);
  set(get(handles.ax_P1, 'XLabel'), 'String', '|Theta|     \Theta [min]', 'FontSize', 10, 'FontName', 'Arial');
 set(get(handles.ax_P1, 'YLabel'), 'String', '|1/Kappa|     \kappa^{-1} [min cm^{3} ml^{-1}]', 'FontSize', 10, 'FontName', 'Arial');

handles.ax_P3 = axes('Parent', panel_1_3_custom , 'units', 'pixels', 'Position',[60 50 280 280]);
  set(get(handles.ax_P3, 'XLabel'), 'String', '|1/Vol|     \nu^{-1} [cm{3} ml^{-1}]', 'FontSize', 10, 'FontName', 'Arial');
 set(get(handles.ax_P3, 'YLabel'), 'String', '|1/Theta|     \Theta^{-1} [min^{-1}]', 'FontSize', 10, 'FontName', 'Arial');
 
handles.ax_N2 = axes('Parent', panel_1_4_custom , 'units', 'pixels', 'Position',[60 50 280 280]);
set(get(handles.ax_N2, 'XLabel'), 'String', '|Kappa|      \kappa [ml cm^{-3} min^{-1}]', 'FontSize', 10, 'FontName', 'Arial');
 set(get(handles.ax_N2, 'YLabel'), 'String', '|Vol|     \nu [ml cm^{-3}]', 'FontSize', 10, 'FontName', 'Arial');     
 
handles.ax_P2 = axes('Parent', panel_1_5_custom , 'units', 'pixels', 'Position',[60 50 280 280]);
  set(get(handles.ax_P2, 'XLabel'), 'String', '|1/Kappa|     \kappa^{-1} [min cm^{3} ml^{-1}]', 'FontSize', 10, 'FontName', 'Arial');
 set(get(handles.ax_P2, 'YLabel'), 'String', '|Theta|     \Theta [min]', 'FontSize', 10, 'FontName', 'Arial');
 
handles.ax_P4 = axes('Parent', panel_1_6_custom , 'units', 'pixels', 'Position',[60 50 280 280]);
  set(get(handles.ax_P4, 'XLabel'), 'String', '|1/Theta|     \Theta^{-1} [min^{-1}]', 'FontSize', 10, 'FontName', 'Arial');
 set(get(handles.ax_P4, 'YLabel'), 'String', '|1/Vol|     \nu^{-1} [cm{3} ml^{-1}]', 'FontSize', 10, 'FontName', 'Arial'); 
 
handles.legend=axes('Parent', panel_legend , 'units', 'pixels', 'Position',[0 0  0 0]);
set(handles.legend,'handlevisibility','off','visible','off');

%% Set graph titles: 
 set(get(handles.ax_N1, 'Title'), 'String', 'N1'); % Gjedde et al. 1982, Cumming et al. 1993
 set(get(handles.ax_P1, 'Title'), 'String', 'P1'); % Gjedde et al, 1982
 set(get(handles.ax_P3, 'Title'), 'String', 'P3'); % Reith et al. 1990
 
 set(get(handles.ax_N2, 'Title'), 'String', 'N2'); % Gjedde 2000
 set(get(handles.ax_P2, 'Title'), 'String', 'P2'); % Logan 1990
 set(get(handles.ax_P4, 'Title'), 'String', 'P4 '); % Nahimi 2015
 
  function display_CustomFit(source,eventdata) % calculates time window of best linear fit
        %% get dynamic parameters:
     kappa = evalin('base','dynamic.kappa');
     theta = evalin('base','dynamic.theta');
     vol= evalin ('base','dynamic.vol');
     
     kappa_reciproc = evalin ('base','dynamic.kappa_reciproc');
     theta_reciproc = evalin ('base','dynamic.theta_reciproc');
     vol_reciproc = evalin ('base','dynamic.vol_reciproc');
     
      %% get yFitted parameters: 
     y_N1_CustomFit =evalin('base','CustomFit.yFitted.N1');       %kappa fitted
     y_P1_CustomFit=evalin('base','CustomFit.yFitted.P1');        %kappa_reciproc fitted
     y_P3_CustomFit=evalin('base','CustomFit.yFitted.P3');        %theta_reciproc fitted
     
     y_N2_CustomFit = evalin('base','CustomFit.yFitted.N2');      %vol fitted
     y_P2_CustomFit =evalin('base','CustomFit.yFitted.P2');       %theta fitted
     y_P4_CustomFit =evalin('base','CustomFit.yFitted.P4');       %vol_reciproc fitted 
     
    
 %% define custom fit frames:
     FrameStart= evalin ('base','CustomFit.FrameConfig.FrameStart');
     FrameEnd = evalin ('base','CustomFit.FrameConfig.FrameEnd');  
     
%% plot N1 cumming 1993:         
[pax,pLine1,pLine2] = plotyy(handles.ax_N1,...
         vol(FrameStart:FrameEnd,:),...
         kappa(FrameStart:FrameEnd,:),...
         vol(FrameStart:FrameEnd,:),...
         y_N1_CustomFit);
     
set(pLine1, 'marker', 'o',...
            'markersize',2.5,...
            'linewidth',2,...
            'linestyle', 'none');
        
set(pLine2, 'linestyle', '-','linewidth',1);
set(pax(2),'ytick',[]); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%% plot P1 Gjedde 1982:        
[pax,pLine1,pLine2] = plotyy(handles.ax_P1,...
         theta(FrameStart:FrameEnd,:),...
         kappa_reciproc(FrameStart:FrameEnd,:),...
         theta(FrameStart:FrameEnd,:),...
         y_P1_CustomFit);
set(pLine1, 'marker', 'o',...
            'markersize',2.5,...
            'linewidth',2,...
            'linestyle', 'none');
        
set(pLine2, 'linestyle', '-','linewidth',1);
set(pax(2),'ytick',[]);                      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% P3 plot Reith 1990:        
[pax,pLine1,pLine2] = plotyy(handles.ax_P3,...
         vol_reciproc(FrameStart:FrameEnd,:),...
         theta_reciproc(FrameStart:FrameEnd,:),...
         vol_reciproc(FrameStart:FrameEnd,:),...
         y_P3_CustomFit);
set(pLine1, 'marker', 'o',...
            'markersize',2.5,...
            'linewidth',2,...
            'linestyle', 'none');
        
set(pLine2, 'linestyle', '-','linewidth',1);
set(pax(2),'ytick',[]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% plot N2 gjedde 2000:       
[pax,pLine1,pLine2] = plotyy(handles.ax_N2,...
         kappa(FrameStart:FrameEnd,:),...
         vol(FrameStart:FrameEnd,:),...
         kappa(FrameStart:FrameEnd,:),...
         y_N2_CustomFit);
     
set(pLine1, 'marker', 'o',...
            'markersize',2.5,...
            'linewidth',2,...
            'linestyle', 'none');
        
set(pLine2, 'linestyle', '-','linewidth',1);
set(pax(2),'ytick',[]); 

%% plot P2 logan 1990
[pax,pLine1,pLine2] = plotyy(handles.ax_P2,...
         kappa_reciproc(FrameStart:FrameEnd,:),...
         theta(FrameStart:FrameEnd,:),...
         kappa_reciproc(FrameStart:FrameEnd,:),...
         y_P2_CustomFit);
     
set(pLine1, 'marker', 'o',...
            'markersize',2.5,...
            'linewidth',2,...
            'linestyle', 'none');
        
set(pLine2, 'linestyle', '-','linewidth',1);
set(pax(2),'ytick',[]);   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% plot P4 Nahimi 2015     
[pax,pLine1,pLine2] = plotyy(handles.ax_P4,...
         theta_reciproc(FrameStart:FrameEnd,:),...
         vol_reciproc(FrameStart:FrameEnd,:),...
         theta_reciproc(FrameStart:FrameEnd,:),...
         y_P4_CustomFit);
set(pLine1, 'marker', 'o',...
            'markersize',2.5,...
            'linewidth',2,...
            'linestyle', 'none');
        
set(pLine2, 'linestyle', '-','linewidth',1);
set(pax(2),'ytick',[]);   
legends = plot(handles.legend,vol,kappa, 'o','markersize',2.5,'linewidth',2);   

%%     %%%%%%%%%%%%%%%%%%%% Show legends %%%%%%%%%%%%%%%%%%%%%%%%%%
    handle_legend = evalin('base','TAC.brain_region');
    legend(handles.legend,handle_legend, 'Location', 'none', [550 320 0 0]) ;% (Show in a new panel)
    set(handles.legend,'handlevisibility','off','visible','off');


%% Set axes PLOT linearized models
set(get(handles.ax_N1, 'XLabel'), 'String', '|Vol|     \nu [ml cm^{-3}]', 'FontSize', 10, 'FontName', 'Arial');
set(get(handles.ax_N1, 'YLabel'), 'String', '|Kappa|      \kappa [ml cm^{-3} min^{-1}]', 'FontSize', 10, 'FontName', 'Arial');       

set(get(handles.ax_P1, 'XLabel'), 'String', '|Theta|     \Theta [min]', 'FontSize', 10, 'FontName', 'Arial');
set(get(handles.ax_P1, 'YLabel'), 'String', '|1/Kappa|     \kappa^{-1} [min cm^{3} ml^{-1}]', 'FontSize', 10, 'FontName', 'Arial');

set(get(handles.ax_P3, 'XLabel'), 'String', '|1/Vol|     \nu^{-1} [cm{3} ml^{-1}]', 'FontSize', 10, 'FontName', 'Arial');
set(get(handles.ax_P3, 'YLabel'), 'String', '|1/Theta|     \Theta^{-1} [min^{-1}]', 'FontSize', 10, 'FontName', 'Arial');
 
set(get(handles.ax_N2, 'XLabel'), 'String', '|Kappa|      \kappa [ml cm^{-3} min^{-1}]', 'FontSize', 10, 'FontName', 'Arial');
set(get(handles.ax_N2, 'YLabel'), 'String', '|Vol|     \nu [ml cm^{-3}]', 'FontSize', 10, 'FontName', 'Arial');     
 
set(get(handles.ax_P2, 'XLabel'), 'String', '|1/Kappa|     \kappa^{-1} [min cm^{3} ml^{-1}]', 'FontSize', 10, 'FontName', 'Arial');
set(get(handles.ax_P2, 'YLabel'), 'String', '|Theta|     \Theta [min]', 'FontSize', 10, 'FontName', 'Arial');
 
set(get(handles.ax_P4, 'XLabel'), 'String', '|1/Theta|     \Theta^{-1} [min^{-1}]', 'FontSize', 10, 'FontName', 'Arial');
set(get(handles.ax_P4, 'YLabel'), 'String', '|1/Vol|     \nu^{-1} [cm{3} ml^{-1}]', 'FontSize', 10, 'FontName', 'Arial'); 
 
set(handles.legend,'handlevisibility','off','visible','off');

%% Set graph titles: 
 set(get(handles.ax_N1, 'Title'), 'String', 'N1'); % Gjedde et al. 1982, Cumming et al. 1993
 set(get(handles.ax_P1, 'Title'), 'String', 'P1'); % Gjedde et al, 1982
 set(get(handles.ax_P3, 'Title'), 'String', 'P3'); % Reith et al. 1990
 
 set(get(handles.ax_N2, 'Title'), 'String', 'N2'); % Gjedde 2000
 set(get(handles.ax_P2, 'Title'), 'String', 'P2'); % Logan 1990
 set(get(handles.ax_P4, 'Title'), 'String', 'P4 ');% Nahimi 2015
  end

%% %%%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TAB 2: DISPLAY FITTED PARAMETERS
%%%%%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

handles.background = axes('Parent', tab2 , 'units', 'pixels','Position',[0 0 1500 820]);
background=imread([ImageDir '/' 'background_custom.png']);
imshow(background);
set(handles.background,'handlevisibility','off', 'visible','off');

panel_custom_2=imread([ImageDir '/' 'panel_custom_2.png']);  
handles.logo = uicontrol('Parent', tab2, 'Style','Pushbutton', 'Position',[0 0 270  820], 'CData',panel_custom_2);

custom_compute_estimate=imread([ImageDir '/' 'custom_compute_estimate.png']);  
handles.button_plot_rsq= uicontrol('Parent', tab2, 'Style','Pushbutton', 'Position',[50 660 196  36], 'CData',custom_compute_estimate, ...
          'Callback', 'CustomFit_steady_state_parameters');

custom_display_estimate_button=imread([ImageDir '/' 'custom_display_estimate.png']);  
handles.custom_display_estimate_button= uicontrol('Parent', tab2, 'Style','Pushbutton', 'Position',[50 620 196  36], 'CData',custom_display_estimate_button, ...
          'Callback', {@custom_display_estimate});

 function custom_display_estimate (source,eventdata)
 % DEFINE TABLES
columnname=evalin('base','TAC.brain_region'); % get the ROI names

% define table VT
handles.uitable_VT = uitable('Parent', tab2,...
        'ColumnName', columnname,...
        'rowname', {'N1 ', 'N2 ', 'P1 ','P2 ',....
        'P3 ', 'P4 '},...
        'Position',[500 570 930 148]); 
    
% define table K1
handles.uitable_K1 = uitable('Parent', tab2,...
        'ColumnName', columnname,...
        'rowname', {'N1 ', 'N2 ', 'P1 ','P2 ',....
        'P3 ', 'P4 '},...
        'Position',[500 570-170 930 148]);

% define table k2
handles.uitable_k2 = uitable('Parent', tab2,...
        'ColumnName', columnname,...
        'rowname', {'N1 ', 'N2 ', 'P1 ','P2 ',....
        'P3 ', 'P4 '},...
        'Position',[500 570-170*2 930 148]);
    
% define table RSquared
handles.uitable_rsq = uitable('Parent', tab2,...
        'ColumnName', columnname,...
        'rowname', {'N1 ', 'N2 ', 'P1 ',....
        'P2 ', 'P3 ', 'P4 '},...
        'Position',[500 570-170*3 930 148]);     
    
 % Now access the data in workspace
        VT = evalin('base', 'CustomFit.SteadyState.V_T.all_plots');
        K1=evalin('base', 'CustomFit.SteadyState.K1.all_plots');
        k2=evalin('base', 'CustomFit.SteadyState.k2.all_plots');
        rsq=evalin('base', 'CustomFit.SteadyState.rsq.all_plots');
 
% Now Make the values visible in the tables
        set(handles.uitable_VT, 'Visible', 'on');
        set(handles.uitable_VT, 'Data', VT, 'ColumnFormat', {'numeric'});
      
        set(handles.uitable_K1, 'Visible', 'on');
        set(handles.uitable_K1, 'Data', K1, 'ColumnFormat', {'numeric'});
       
        set(handles.uitable_k2, 'Visible', 'on');
        set(handles.uitable_k2, 'Data', k2, 'ColumnFormat', {'numeric'}); 
        
        set(handles.uitable_rsq, 'Visible', 'on');
        set(handles.uitable_rsq, 'Data', rsq, 'ColumnFormat', {'numeric'});                   
 end

%HEADINGS
VT=imread([ImageDir '/' 'VT.png']);  
handles.button_show_VT= uicontrol('Parent', tab2, 'Style','Pushbutton', 'Position',[300 680 196  36], 'CData',VT);        
K1=imread([ImageDir '/' 'K1.png']);  
handles.button_show_K1= uicontrol('Parent', tab2, 'Style','Pushbutton', 'Position',[300 680-170 196  36], 'CData',K1);
k2=imread([ImageDir '/' 'k2.png']);  
handles.button_show_k2= uicontrol('Parent', tab2, 'Style','Pushbutton', 'Position',[300 680-170*2 196  36], 'CData',k2);
rsq_values=imread([ImageDir '/' 'rsq.png']);  
handles.button_show_rsq= uicontrol('Parent', tab2, 'Style','Pushbutton', 'Position',[300 680-170*3 196  36], 'CData',rsq_values);
     
end
% KiWi |Kinetics Windows| 

% This interface enables the user to import brain TACs and reference TACs
% to compute dynamic variables and quantify volumes of distribution (V_T) ...   
% step by step from PET acquisitions. 
% The user can perform iterative linearization to obtain information about
% in which time interval best linearization is achieved.

% User Instructions 
% Tab 1: import TACs (brain and reference). SUV calculation is optional
% Tab 2: Display the dynamic variables Vol, Kappa and Theta and their reciprocal values.
% Tab 3: Display the six models. Define the length of frames for
% iterative linearization, (5 frames is default). 

% Tab 4: Display the Linearized plots in the time interval, where best
% R-squared value was identified. 

% Tab 5: Display the all the R-squared values for all six models.
% The six models don't neccessary produce same time interval with best fit,
% therefore you can choose to do a custom fit. 

% Click on the red button to go to custom fit where you can choose start
% and end frame for linearization for all six plot.

% Tab 6: Display the estimates of K1, k2' and V_T from all the six
% linearized models.

    
% Code written by Jenny-Ann Phan, MD, PhD fellow.
% vs 0.2 - July 2017 
% Distributed under the Open Source license

function KiWi
%% open in the center of screen
size = [1500 850]; % figure size
screensize = get(0,'ScreenSize'); % find screen size
xpos = ceil((screensize(3)-size(1))/2); % center the figure on the screen horizontally
ypos = ceil((screensize(4)-size(2))/2); % center the figure on the screen vertically

%% Configure frame
h.kiwi = figure('MenuBar', 'none','units','pixels','Position', [xpos ypos size(1) size(2)],... % [x,y,width, height][0 0 1500 850]
    'name','KiWi | Kinetics Windows | - STEP 1','numbertitle','off','Resize', 'off');

tgroup = uitabgroup('Parent', h.kiwi,'units','pixels',...
      'Position', [0 0  size(1) size(2)]); 

% Define tabs
tab1 = uitab('Parent', tgroup, 'Title', '   1   ');
tab2 = uitab('Parent', tgroup, 'Title', '   2   ');
tab3 = uitab('Parent', tgroup, 'Title', '   3   ');
tab4 = uitab('Parent', tgroup, 'Title', '   4   ');
tab5 = uitab('Parent', tgroup, 'Title', '   5   ');
tab6 = uitab('Parent', tgroup, 'Title', '   6   '); 
tab7 = uitab('Parent', tgroup, 'Title', '   7   ');
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Modifies the appearance
%jTabGroup = getappdata(handle(tgroup),'JTabbedPane');
%lafs = javax.swing.UIManager.getInstalledLookAndFeels;
%javax.swing.UIManager.setLookAndFeel('com.sun.java.swing.plaf.windows.WindowsLookAndFeel');


%% %%%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TAB_1: importdata, plot TAC and SUV calculation
%%%%%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% predefine paths
ImageDir = strcat(pwd,'\elements');
addpath(genpath('./scripts'));
addpath(genpath('./scripts/one'));
addpath(genpath('./scripts/two'));
addpath(genpath('./scripts/three'));
addpath(genpath('./scripts/four'));

addpath(genpath('./scripts/six'));
addpath(genpath('./scripts/right_panel'));
addpath(genpath('./scripts/custom_fit'));

%% Define Appearance
panel_1_1= uipanel('parent', tab1,'fontsize',12,...
    'backgroundColor','white',...
    'units','pixels',...
    'Position', [300 420 500 380]);

panel_1_2= uipanel('parent', tab1,'fontsize',12,...
    'backgroundColor','white',...
    'units','pixels',...
    'Position', [820 420 500 380]);

panel_1_3= uipanel('parent', tab1,'fontsize',12,...
    'backgroundColor','white',...
    'units','pixels',...
    'Position', [300 20 500 380]);


handles.background = axes('Parent', tab1 , 'units', 'pixels','Position',[0 0 1500 820]);
background=imread([ImageDir '/' 'background.png']);
imshow(background);
set(handles.background,'handlevisibility','off', 'visible','off');
        
panel_1=imread([ImageDir '/' 'panel1.png']);  
handles.logo = uicontrol('Parent', tab1, 'Style','Pushbutton', 'Position',[0 0 270  820], 'CData',panel_1); 



% look here: https://se.mathworks.com/matlabcentral/answers/31113-call-functions-from-subpath


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Buttons in Tab one
import_wta=imread([ImageDir '/' 'import_wta.png']);  
handles.import_wta = uicontrol('Parent', tab1, 'Style','Pushbutton', 'Position',[50 660 196  36], 'CData',import_wta, ...
          'Callback','importTac');
      
import_excel= imread([ImageDir '\' 'import_excel.png']);       
handles.import_excel = uicontrol('Parent', tab1, 'Style','Pushbutton', 'Position',[50 620 196  36], 'CData',import_excel) 

show_ROI=imread([ImageDir '/' 'plot_ROI.png']); 
handles.plot_ROI= uicontrol('Parent', tab1, 'Style','Pushbutton', 'Position',[50 580 196  36], 'CData',show_ROI, ...
    'Callback', {@plot_ROI});

plasma=imread([ImageDir '/' 'plasma_ref.png']); 
handles.import_ref=uicontrol('Parent', tab1, 'Style','Pushbutton', 'Position',[50 450 196  36], 'CData',plasma, ...
    'Callback', 'importRef');

tissue=imread([ImageDir '/' 'tissue_ref.png']); 
handles.import_ref2=uicontrol('Parent', tab1, 'Style','Pushbutton', 'Position',[50 410 196  36], 'CData',tissue, ...
    'Callback', 'importRef2');

show_ref=imread([ImageDir '/' 'plot_ref.png']); 
handles.plot_ref=uicontrol('Parent', tab1, 'Style','Pushbutton', 'Position',[50 370 196  36], 'CData',show_ref, ...
    'Callback', {@plot_ref});


inj_dose=imread([ImageDir '/' 'inj_dose.png']); 
handles.button_Mbq = uicontrol('Parent', tab1, 'Style','pushbutton','Position',[112 237 130 36], 'CData', inj_dose, ...
    'Callback',{@get_injected_dose});

body_weight=imread([ImageDir '/' 'body_weight.png']); 

handles.button_kg = uicontrol('Parent', tab1, 'Style','pushbutton','Position',[112 198 130 36], 'CData', body_weight,...
     'Callback',{@get_body_weigth});

handles.editbox_injected_dose = uicontrol('Parent', tab1, 'style','edit',...
            'units','pixels',...
            'position',[58 240 50 29],...  
            'string','Mbq',...
            'foregroundcolor','[0.3176 0.4745 1]') ;      
        
handles.editbox_body_weigth = uicontrol('Parent', tab1, 'style','edit',...
            'units','pixels',...
            'position',[58 202 50 29],...  
            'string','Kg',...
            'foregroundcolor','[0.3176 0.4745 1]') ;

calc_suv=imread([ImageDir '/' 'compute_SUV.png']); 
handles.button_plot_SUV=uicontrol('Parent', tab1, 'Style','Pushbutton', 'Position',[50 160 196 36], 'CData',calc_suv, ...
    'Callback', 'SUV_calculator');
               
plot_suv=imread([ImageDir '/' 'plot_suv.png']); 
handles.button_plot_SUV=uicontrol('Parent', tab1, 'Style','Pushbutton', 'Position',[50 122 196 36], 'CData',plot_suv, ...
    'Callback', {@display_SUV});


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% predefine axes
handles.ax1_1 = axes('Parent', panel_1_1 , 'units', 'pixels','Position',[50 50 400 280]);
set(get(handles.ax1_1, 'XLabel'), 'String', 'Time [min]', 'FontSize', 10, 'FontName', 'Arial');
set(get(handles.ax1_1, 'YLabel'), 'String', 'Activity [kBq]', 'FontSize', 10, 'FontName', 'Arial');    

handles.ax1_2 = axes('Parent', panel_1_2 , 'units', 'pixels', 'Position',[50 50 400 280]);
set(get(handles.ax1_2, 'XLabel'), 'String', 'Time [min]', 'FontSize', 10, 'FontName', 'Arial');
set(get(handles.ax1_2, 'YLabel'), 'String', 'Activity [kBq]', 'FontSize', 10, 'FontName', 'Arial');  

handles.ax1_3 = axes('Parent', panel_1_3 , 'units', 'pixels', 'Position',[75 50 400 250]);
set(get(handles.ax1_3, 'XLabel'), 'String', 'Time [min]', 'FontSize', 10, 'FontName', 'Arial');
set(get(handles.ax1_3, 'YLabel'), 'String', 'SUV [kBq/bodymass/injected dose]', 'FontSize', 10, 'FontName', 'Arial');  

set(get(handles.ax1_1, 'Title'), 'String', 'Brain Activity');...
set(get(handles.ax1_2, 'Title'), 'String', 'Reference Activity');...
set(get(handles.ax1_3, 'Title'), 'String', 'Standardized Uptake Value');...

%% FUNCTIONS IN TAB ONE

    function plot_ROI(source,eventdata)
     time = evalin('base','TAC.time_min'); %
     brain = evalin('base','TAC.ROI_activity_kbq');

     p1_1 =plot(handles.ax1_1,time,brain,'o', 'markersize', 5);
     grid(handles.ax1_1,'on'), grid(handles.ax1_1,'minor');
          
        %% Set axes titles
        set(get(handles.ax1_1, 'XLabel'), 'String', 'Time [min]', 'FontSize', 10, 'FontName', 'Arial');
        set(get(handles.ax1_1, 'YLabel'), 'String', 'Activity [kBq]', 'FontSize', 10, 'FontName', 'Arial');          

        %% Set graph titles 
        set(get(handles.ax1_1, 'Title'), 'String', 'Brain Activity');
                        
    end

    function plot_ref (source,eventdata)
            time = evalin('base','TAC.time_min'); %
            reference_input =evalin('base','TAC.input_kbq');
            
            p1_2 =plot(handles.ax1_2,time,reference_input, 'ko', 'markersize', 5);
            grid(handles.ax1_2,'on'), grid(handles.ax1_2,'minor');
            
            p1_2 =plot(handles.ax1_2,time,reference_input, 'ko', 'markersize', 5);
            grid(handles.ax1_2,'on'), grid(handles.ax1_2,'minor');

            %% Set axes titles
            set(get(handles.ax1_2, 'XLabel'), 'String', 'Time [min]', 'FontSize', 10, 'FontName', 'Arial');
            set(get(handles.ax1_2, 'YLabel'), 'String', 'Activity [kBq]', 'FontSize', 10, 'FontName', 'Arial');  

            %% Set graph titles 
            set(get(handles.ax1_2, 'Title'), 'String', 'Reference Activity');

    end
    function get_injected_dose(source, eventdata)
      s=  str2double(get(handles.editbox_injected_dose, 'string'));
       assignin('base', 'SUV_injected_dose',  s);
    end
    function get_body_weigth(source, eventdata)
      s= str2double(get(handles.editbox_body_weigth, 'string'));
      assignin('base', 'SUV_body_weight',  s);
    end

    function display_SUV(source,eventdata)
     time = evalin('base','TAC.time_min'); %
     SUV = evalin('base','SUV.ROI_SUV');

          p1_3 =plot(handles.ax1_3,time,SUV,'o', 'markersize', 5);
          grid(handles.ax1_3,'on'), grid(handles.ax1_3,'minor');

    set(get(handles.ax1_3, 'XLabel'), 'String', 'Time [min]', 'FontSize', 10, 'FontName', 'Arial');
    set(get(handles.ax1_3, 'YLabel'), 'String', 'SUV [kg cm^{-3}]', 'FontSize', 10, 'FontName', 'Arial');  
    set(get(handles.ax1_3, 'Title'), 'String', 'Standardized Uptake Value');...

    end 


%function show_button(source, eventdata)
    %handles.button_1 = uicontrol('Parent', tab1, 'Style','pushbutton',...
    %         'String','Import TACs               [.wta]','Position',[10 650 180 25],...
    %         'Callback', 'importTac'); % [x,y,width, height]
         
 %   handles.button_2a = uicontrol('Parent', tab1, 'Style','pushbutton',...
    %         'String','Import reference         [.xlsx]','Position',[10 620 180 25],... % [x,y,width, height] button_importReference = uicontrol
   %          'Callback', 'importRef'); %imports plasma input or reference tissue input from excel file
         
  %  handles.button_2b = uicontrol('Parent', tab1, 'Style','pushbutton',...
   %          'String','Import reference         [.wta]','Position',[10 590 180 25],... % [x,y,width, height] button_importReference = uicontrol
  %           'Callback', 'importTissueRef'); %imports plasma input or reference tissue input from excel file
         
  %  button_state = get(handles.button_test,'Value');
  %  if button_state == get(handles.button_test,'Max');
 %      % set(handles.button_1,'Visible','on');
  %      set(handles.button_2a,'Visible','on');
 %       set(handles.button_2b,'Visible','on');
    %elseif button_state == get(handles.button_test,'Min');
        %set(handles.Array ,'Visible','off');  
 %   end

% end

%% %%%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%
%TAB_2: Dynamic parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Define Appearance
handles.background= axes('Parent', tab2 , 'units', 'pixels','Position',[0 0 1500 820]);
imagesc(background, 'Parent', handles.background);
set(handles.background,'handlevisibility','off','visible','off');

panel_2=imread([ImageDir '/' 'panel2.png']);  
handles.logo = uicontrol('Parent', tab2, 'Style','Pushbutton', 'Position',[0 0 270  820], 'CData',panel_2) 


%% Define panels
% |1|  |2|  |3|
% |4|  |5|  |6|

panel_2_1= uipanel('parent', tab2,'fontsize',12,...
    'backgroundColor','white',...
    'units','pixels',...
    'Position', [300 415 360 360]);

panel_2_2= uipanel('parent', tab2,'fontsize',12,...
    'backgroundColor','white',...
    'units','pixels',...
    'Position', [300+360+15 415 360 360]);

panel_2_3= uipanel('parent', tab2,'fontsize',12,...
    'backgroundColor','white',...
    'units','pixels',...
    'Position', [300+(360*2)+30 415 360 360]);

% next row
panel_2_4= uipanel('parent', tab2,'fontsize',12,...
    'backgroundColor','white',...
    'units','pixels',...
    'Position', [300 30 360 360]);

panel_2_5= uipanel('parent', tab2,'fontsize',12,...
    'backgroundColor','white',...
    'units','pixels',...
    'Position', [300+360+15 30 360 360]);

panel_2_6= uipanel('parent', tab2,'fontsize',12,...
    'backgroundColor','white',...
    'units','pixels',...
    'Position', [300+360*2+30 30 360 360]);

%% define buttons
dynamic_variables=imread([ImageDir '/' 'compute_variables.png']);  
handles.dynamic_variables= uicontrol('Parent', tab2, 'Style','Pushbutton', 'Position',[50 660 196  36], 'CData',dynamic_variables, ...
          'Callback', 'calc_dynamic_variables');

plot_variables=imread([ImageDir '/' 'plot_variables.png']);  
handles.button_plot_dyn = uicontrol('Parent', tab2, 'Style','Pushbutton', 'Position',[50 620 196  36], 'CData',plot_variables, ...
          'Callback', {@plot_dynamic});


%% Set axes PLOT time-dynamic-variable curves
handles.ax2_1 = axes('Parent', panel_2_1 , 'units', 'pixels', 'Position',[50 50 280 280]);
 set(get(handles.ax2_1, 'XLabel'), 'String', 'Time [min]', 'FontSize', 10, 'FontName', 'Arial');
 set(get(handles.ax2_1, 'YLabel'), 'String', '\nu [ml cm^{-3}]', 'FontSize', 10, 'FontName', 'Arial');  

handles.ax2_2 = axes('Parent', panel_2_2 , 'units', 'pixels', 'Position',[50 50 280 280]);
 set(get(handles.ax2_2, 'XLabel'), 'String', 'Time [min]', 'FontSize', 10, 'FontName', 'Arial');
 set(get(handles.ax2_2, 'YLabel'), 'String', '\kappa [ml cm^{-3} min^{-1}]', 'FontSize', 10, 'FontName', 'Arial');

handles.ax2_3 = axes('Parent', panel_2_3 , 'units', 'pixels', 'Position',[50 50 280 280]);
 set(get(handles.ax2_3, 'XLabel'), 'String', 'Time [min]', 'FontSize', 10, 'FontName', 'Arial');
 set(get(handles.ax2_3, 'YLabel'), 'String', '\Theta [min]', 'FontSize', 10, 'FontName', 'Arial');
 
handles.ax2_4 = axes('Parent', panel_2_4 , 'units', 'pixels', 'Position',[50 50 280 280]);
 set(get(handles.ax2_4, 'XLabel'), 'String', 'Time [min]', 'FontSize', 10, 'FontName', 'Arial');
 set(get(handles.ax2_4, 'YLabel'), 'String', '\nu^{-1} [cm{3} ml^{-1}]', 'FontSize', 10, 'FontName', 'Arial');  

handles.ax2_5 = axes('Parent', panel_2_5 , 'units', 'pixels', 'Position',[50 50 280 280]);
 set(get(handles.ax2_5, 'XLabel'), 'String', 'Time [min]', 'FontSize', 10, 'FontName', 'Arial');
 set(get(handles.ax2_5, 'YLabel'), 'String', '\kappa^{-1} [min cm^{3} ml^{-1}]', 'FontSize', 10, 'FontName', 'Arial');
 
handles.ax2_6 = axes('Parent', panel_2_6 , 'units', 'pixels', 'Position',[50 50 280 280]);
 set(get(handles.ax2_6, 'XLabel'), 'String', 'Time [min]', 'FontSize', 10, 'FontName', 'Arial');
 set(get(handles.ax2_6, 'YLabel'), 'String', '\Theta^{-1} [min^{-1}]', 'FontSize', 10, 'FontName', 'Arial');

 %% Set graph titles 
 set(get(handles.ax2_1, 'Title'), 'String', 'Vol');
 set(get(handles.ax2_2, 'Title'), 'String', 'Kappa');
 set(get(handles.ax2_3, 'Title'), 'String', 'Theta');
 set(get(handles.ax2_4, 'Title'), 'String', '1/Vol');
 set(get(handles.ax2_5, 'Title'), 'String', '1/Kappa');
 set(get(handles.ax2_6, 'Title'), 'String', '1/Theta');
%%%%%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Callback function PLOT DYNAMIC DATA
 function plot_dynamic(source,eventdata) 

     time = evalin('base','TAC.time_min');
     kappa = evalin('base','dynamic.kappa');
     theta = evalin('base','dynamic.theta');
     vol= evalin ('base','dynamic.vol');
     
     kappa_reciproc = evalin ('base','dynamic.kappa_reciproc');
     theta_reciproc = evalin ('base','dynamic.theta_reciproc');
     vol_reciproc = evalin ('base','dynamic.vol_reciproc');

          p2_1 = plot(handles.ax2_1,time,kappa,'o', 'markersize', 5);
          p2_2 = plot(handles.ax2_2,time,theta,'o', 'markersize', 5);
          p2_3 = plot(handles.ax2_3,time,vol,'o', 'markersize', 5);
          p2_4 = plot(handles.ax2_4,time,kappa_reciproc,'o', 'markersize', 5);
          p2_5 = plot(handles.ax2_5,time,theta_reciproc,'o', 'markersize', 5);
          p2_6 = plot(handles.ax2_6,time,vol_reciproc,'o', 'markersize', 5);
          
          grid(handles.ax2_1,'on'), grid(handles.ax2_1,'minor');
          grid(handles.ax2_2,'on'), grid(handles.ax2_2,'minor');
          grid(handles.ax2_3,'on'), grid(handles.ax2_3,'minor');
          grid(handles.ax2_4,'on'), grid(handles.ax2_4,'minor');
          grid(handles.ax2_5,'on'), grid(handles.ax2_5,'minor');
          grid(handles.ax2_6,'on'), grid(handles.ax2_6,'minor');
          
%% Set axes PLOT time-dynamic-variable curves
 set(get(handles.ax2_1, 'XLabel'), 'String', 'Time [min]', 'FontSize', 10, 'FontName', 'Arial');
 set(get(handles.ax2_1, 'YLabel'), 'String', '\nu [ml cm^{-3}]', 'FontSize', 10, 'FontName', 'Arial');  

 set(get(handles.ax2_2, 'XLabel'), 'String', 'Time [min]', 'FontSize', 10, 'FontName', 'Arial');
 set(get(handles.ax2_2, 'YLabel'), 'String', '\kappa [ml cm^{-3} min^{-1}]', 'FontSize', 10, 'FontName', 'Arial');

 set(get(handles.ax2_3, 'XLabel'), 'String', 'Time [min]', 'FontSize', 10, 'FontName', 'Arial');
 set(get(handles.ax2_3, 'YLabel'), 'String', '\Theta [min]', 'FontSize', 10, 'FontName', 'Arial');
 
 set(get(handles.ax2_4, 'XLabel'), 'String', 'Time [min]', 'FontSize', 10, 'FontName', 'Arial');
 set(get(handles.ax2_4, 'YLabel'), 'String', '\nu^{-1} [cm{3} ml^{-1}]', 'FontSize', 10, 'FontName', 'Arial');  

 set(get(handles.ax2_5, 'XLabel'), 'String', 'Time [min]', 'FontSize', 10, 'FontName', 'Arial');
 set(get(handles.ax2_5, 'YLabel'), 'String', '\kappa^{-1} [min cm^{3} ml^{-1}]', 'FontSize', 10, 'FontName', 'Arial');
 
 set(get(handles.ax2_6, 'XLabel'), 'String', 'Time [min]', 'FontSize', 10, 'FontName', 'Arial');
 set(get(handles.ax2_6, 'YLabel'), 'String', '\Theta^{-1} [min^{-1}]', 'FontSize', 10, 'FontName', 'Arial');
 
 %% Set graph titles 
 set(get(handles.ax2_1, 'Title'), 'String', 'Vol');
 set(get(handles.ax2_2, 'Title'), 'String', 'Kappa');
 set(get(handles.ax2_3, 'Title'), 'String', 'Theta');
 set(get(handles.ax2_4, 'Title'), 'String', '1/Vol');
 set(get(handles.ax2_5, 'Title'), 'String', '1/Kappa');
 set(get(handles.ax2_6, 'Title'), 'String', '1/Theta');

 %%     %%%%%%%%%%%%%%%%%%%% Show legends %%%%%%%%%%%%%%%%%%%%%%%%%%
    handle_legend = evalin('base','TAC.name');
    legend(handles.ax2_1,handle_legend, 'Location', 'NorthEast') ;%[20 620 180 25]  
        
 end

%%%%%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%
%TAB3: SIX PLOTS TO OBTAIN VT or BINDING POTENTIAL
%%%%%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Define Appearance
handles.background= axes('Parent', tab3 , 'units', 'pixels','Position',[0 0 1500 820]);
imagesc(background, 'Parent', handles.background);
set(handles.background,'handlevisibility','off','visible','off');


%% Define left toolbar
panel_3=imread([ImageDir '/' 'panel3.png']);  
handles.logo = uicontrol('Parent', tab3, 'Style','Pushbutton', 'Position',[0 0 270  820], 'CData',panel_3) 

%% Define panels

% |1| |2| |3|  = |N1| |P1| |P3| = |Gjedde et al. 1982+Cumming et al. 1993| |Gjedde et al. 1982| |Reith et al. 1990|
% |4| |5| |6|  = |N2| |P2| |P4| = |Gjedde 2000| |Logan 1990| |Nahimi 2015|

panel_3_1= uipanel('parent', tab3,'fontsize',12,...
    'backgroundColor','white',...
    'units','pixels',...
    'Position', [300 415 360 360]);

panel_3_2= uipanel('parent', tab3,'fontsize',12,...
    'backgroundColor','white',...
    'units','pixels',...
    'Position', [300+360+15 415 360 360]);

panel_3_3= uipanel('parent', tab3,'fontsize',12,...
    'backgroundColor','white',...
    'units','pixels',...
    'Position', [300+(360*2)+30 415 360 360]);

panel_3_4= uipanel('parent', tab3,'fontsize',12,...
    'backgroundColor','white',...
    'units','pixels',...
    'Position', [300 30 360 360]);

panel_3_5= uipanel('parent', tab3,'fontsize',12,...
    'backgroundColor','white',...
    'units','pixels',...
    'Position', [300+360+15 30 360 360]);

panel_3_6= uipanel('parent', tab3,'fontsize',12,...
    'backgroundColor','white',...
    'units','pixels',...
    'Position', [300+360*2+30 30 360 360]);



         
%% Set axes PLOT linearized models
handles.ax3_1 = axes('Parent', panel_3_1 , 'units', 'pixels', 'Position',[60 50 280 280]);
 set(get(handles.ax3_1, 'XLabel'), 'String', '|Vol|     \nu [ml cm^{-3}]', 'FontSize', 10, 'FontName', 'Arial');
 set(get(handles.ax3_1, 'YLabel'), 'String', '|Kappa|      \kappa [ml cm^{-3} min^{-1}]', 'FontSize', 10, 'FontName', 'Arial');       

handles.ax3_2 = axes('Parent', panel_3_2 , 'units', 'pixels', 'Position',[60 50 280 280]);
  set(get(handles.ax3_2, 'XLabel'), 'String', '|Theta|     \Theta [min]', 'FontSize', 10, 'FontName', 'Arial');
 set(get(handles.ax3_2, 'YLabel'), 'String', '|1/Kappa|     \kappa^{-1} [min cm^{3} ml^{-1}]', 'FontSize', 10, 'FontName', 'Arial');

handles.ax3_3 = axes('Parent', panel_3_3 , 'units', 'pixels', 'Position',[60 50 280 280]);
  set(get(handles.ax3_3, 'XLabel'), 'String', '|1/Vol|     \nu^{-1} [cm{3} ml^{-1}]', 'FontSize', 10, 'FontName', 'Arial');
 set(get(handles.ax3_3, 'YLabel'), 'String', '|1/Theta|     \Theta^{-1} [min^{-1}]', 'FontSize', 10, 'FontName', 'Arial');
 
handles.ax3_4 = axes('Parent', panel_3_4 , 'units', 'pixels', 'Position',[60 50 280 280]);
set(get(handles.ax3_4, 'XLabel'), 'String', '|Kappa|      \kappa [ml cm^{-3} min^{-1}]', 'FontSize', 10, 'FontName', 'Arial');
 set(get(handles.ax3_4, 'YLabel'), 'String', '|Vol|     \nu [ml cm^{-3}]', 'FontSize', 10, 'FontName', 'Arial');     
 
handles.ax3_5 = axes('Parent', panel_3_5 , 'units', 'pixels', 'Position',[60 50 280 280]);
  set(get(handles.ax3_5, 'XLabel'), 'String', '|1/Kappa|     \kappa^{-1} [min cm^{3} ml^{-1}]', 'FontSize', 10, 'FontName', 'Arial');
 set(get(handles.ax3_5, 'YLabel'), 'String', '|Theta|     \Theta [min]', 'FontSize', 10, 'FontName', 'Arial');
 
handles.ax3_6 = axes('Parent', panel_3_6 , 'units', 'pixels', 'Position',[60 50 280 280]);
  set(get(handles.ax3_6, 'XLabel'), 'String', '|1/Theta|     \Theta^{-1} [min^{-1}]', 'FontSize', 10, 'FontName', 'Arial');
 set(get(handles.ax3_6, 'YLabel'), 'String', '|1/Vol|     \nu^{-1} [cm{3} ml^{-1}]', 'FontSize', 10, 'FontName', 'Arial'); 

%% Set graph titles: 
 set(get(handles.ax3_1, 'Title'), 'String', 'N1'); % Gjedde et al. 1982, Cumming et al. 1993
 set(get(handles.ax3_2, 'Title'), 'String', 'P1'); % Gjedde et al, 1982
 set(get(handles.ax3_3, 'Title'), 'String', 'P3'); % Reith et al. 1990
 
 set(get(handles.ax3_4, 'Title'), 'String', 'N2'); % Gjedde 2000
 set(get(handles.ax3_5, 'Title'), 'String', 'P2'); % Logan 1990
 set(get(handles.ax3_6, 'Title'), 'String', 'P4 '); % Nahimi 2015
 
%% Define buttons:
plot_all_models=imread([ImageDir '/' 'plot_all_models.png']);  
handles.button_plot_lin= uicontrol('Parent', tab3, 'Style','Pushbutton', 'Position',[50 660 196  36], 'CData',plot_all_models, ...
          'Callback', {@linear_plots});

FrameWidth=imread([ImageDir '/' 'frame_width.png']); 
handles.get_FrameWidth = uicontrol('Parent', tab3, 'Style','Pushbutton', 'Position',[112 507 132  36], 'CData',FrameWidth, ...
        'Callback', {@get_FrameWidth}); % get frame width for Iterativ analysis

    
iterative=imread([ImageDir '/' 'compute_iterative.png']); 
handles.compute_iterative_analysis  = uicontrol('Parent', tab3, 'Style','Pushbutton', 'Position',[50 420 196  36], 'CData',iterative, ...
        'Callback', 'find_linear_position'); % perform iterative linear regression
   
show_best_fit=imread([ImageDir '/' 'show_best_fit.png']); 
handles.display_best_fit  = uicontrol('Parent', tab3, 'Style','Pushbutton', 'Position',[50 260 196  36], 'CData',show_best_fit, ...
        'Callback', @display_table_best_fit); % display best fitted frames
    
%% Insert no of frames Iterative Analysis
handles.editbox_frame = uicontrol('Parent', tab3, 'style','edit',...
            'units','pixels',...
            'position',[58 510 50 29],...  %[110 570 90 22],...
            'string','insert') ;
        
    function get_FrameWidth(source, eventdata)
      s=  str2double(get(handles.editbox_frame, 'string'));
       assignin('base', 'FrameWidth',  s);
        
% Select brain region for iterative analysis
% I put it here because it is undefined until TACs and brain region names
% are imported 
handle.legend = evalin('base','TAC.name'); % load ROI names
handle.region_for_iterative_analysis = uicontrol('Parent', tab3, 'Style', 'popup',... 
                       'String', handle.legend,... % display ROI names in drop down menu
                       'Position', [58 315 180 180], 'Fontsize', 11,...
                       'Callback',@select_ROI);            
 
     function select_ROI(obj,event)
         sels = get(handle.region_for_iterative_analysis,'String');
         idx  = get(handle.region_for_iterative_analysis,'Value');
         result = sels(idx);
         assignin ('base','iterative_region_idx',idx);
         assignin ('base','iterative_region',result);    
     end  
       
    end

 %% Drop down menu to select brain region 

 
                   

   
    
      function display_table_best_fit(source,eventdata)
        handles.table_best_fit_tab3= uitable('Parent', tab3,...
        'ColumnName', {'Start','End', 'min', 'min'},...
        'rowname', {'N1', 'N2', 'P1',....
        'P2', 'P3', 'P4'},...
        'Position',[35 115 236 130]);    

        frame= evalin('base', 'BestFit.all_plots');
        set(handles.table_best_fit_tab3, 'Visible', 'on');
        set(handles.table_best_fit_tab3, 'Data', frame, 'ColumnFormat', {'numeric'});
      end
                    

 % Callback function LINEAR PLOTS
 function linear_plots(source,eventdata)
 
     kappa = evalin('base','dynamic.kappa');
     theta = evalin('base','dynamic.theta');
     vol= evalin ('base','dynamic.vol');
     
     kappa_reciproc = evalin ('base','dynamic.kappa_reciproc');
     theta_reciproc = evalin ('base','dynamic.theta_reciproc');
     vol_reciproc = evalin ('base','dynamic.vol_reciproc');
      
        p3_1 = plot(handles.ax3_1,vol,kappa, 'o','markersize',2.5,'linewidth',2);
        p3_2 = plot(handles.ax3_2,theta,kappa_reciproc, 'o','markersize',2.5,'linewidth',2);
        p3_3 = plot(handles.ax3_3,vol_reciproc,theta_reciproc, 'o','markersize',2.5,'linewidth',2);
          
        p3_4 = plot(handles.ax3_4,kappa,vol,'o','markersize',2.5,'linewidth',2);
        p3_5 = plot(handles.ax3_5,kappa_reciproc,theta,'o','markersize',2.5,'linewidth',2);
        p3_6 = plot(handles.ax3_6,theta_reciproc,vol_reciproc, 'o','markersize',2.5,'linewidth',2);
 
 %% Set axes PLOT linearized models
set(get(handles.ax3_1, 'XLabel'), 'String', '|Vol|     \nu [ml cm^{-3}]', 'FontSize', 10, 'FontName', 'Arial');
set(get(handles.ax3_1, 'YLabel'), 'String', '|Kappa|      \kappa [ml cm^{-3} min^{-1}]', 'FontSize', 10, 'FontName', 'Arial');       

set(get(handles.ax3_2, 'XLabel'), 'String', '|Theta|     \Theta [min]', 'FontSize', 10, 'FontName', 'Arial');
set(get(handles.ax3_2, 'YLabel'), 'String', '|1/Kappa|     \kappa^{-1} [min cm^{3} ml^{-1}]', 'FontSize', 10, 'FontName', 'Arial');

set(get(handles.ax3_3, 'XLabel'), 'String', '|1/Vol|     \nu^{-1} [cm{3} ml^{-1}]', 'FontSize', 10, 'FontName', 'Arial');
set(get(handles.ax3_3, 'YLabel'), 'String', '|1/Theta|     \Theta^{-1} [min^{-1}]', 'FontSize', 10, 'FontName', 'Arial');
 
set(get(handles.ax3_4, 'XLabel'), 'String', '|Kappa|      \kappa [ml cm^{-3} min^{-1}]', 'FontSize', 10, 'FontName', 'Arial');
set(get(handles.ax3_4, 'YLabel'), 'String', '|Vol|     \nu [ml cm^{-3}]', 'FontSize', 10, 'FontName', 'Arial');     
 
set(get(handles.ax3_5, 'XLabel'), 'String', '|1/Kappa|     \kappa^{-1} [min cm^{3} ml^{-1}]', 'FontSize', 10, 'FontName', 'Arial');
set(get(handles.ax3_5, 'YLabel'), 'String', '|Theta|     \Theta [min]', 'FontSize', 10, 'FontName', 'Arial');
set(get(handles.ax3_6, 'XLabel'), 'String', '|1/Theta|     \Theta^{-1} [min^{-1}]', 'FontSize', 10, 'FontName', 'Arial');
set(get(handles.ax3_6, 'YLabel'), 'String', '|1/Vol|     \nu^{-1} [cm{3} ml^{-1}]', 'FontSize', 10, 'FontName', 'Arial'); 

%% Set graph titles: 
 set(get(handles.ax3_1, 'Title'), 'String', 'N1'); % Gjedde et al. 1982, Cumming et al. 1993
 set(get(handles.ax3_2, 'Title'), 'String', 'P1'); % Gjedde et al, 1982
 set(get(handles.ax3_3, 'Title'), 'String', 'P3'); % Reith et al. 1990
 
 set(get(handles.ax3_4, 'Title'), 'String', 'N2'); % Gjedde 2000
 set(get(handles.ax3_5, 'Title'), 'String', 'P2'); % Logan 1990
 set(get(handles.ax3_6, 'Title'), 'String', 'P4 '); % Nahimi 2015
 
%%     %%%%%%%%%%%%%%%%%%%% Show legends %%%%%%%%%%%%%%%%%%%%%%%%%%
    handle_legend = evalin('base','TAC.name');
    legend(handles.ax3_1,handle_legend, 'Location', 'NorthEast') ;%[20 620 180 25]  
        
 end


%%%%%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%
%tab4: LINEARIZED PLOTS - BEST FIT
%%%%%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%
handles.background= axes('Parent', tab4 , 'units', 'pixels','Position',[0 0 1500 820]);
imagesc(background, 'Parent', handles.background);
set(handles.background,'handlevisibility','off','visible','off');

%% Define left toolbar
panel_4=imread([ImageDir '/' 'panel4.png']);  
handles.logo = uicontrol('Parent', tab4, 'Style','Pushbutton', 'Position',[0 0 270  820], 'CData',panel_4) 



compute_values=imread([ImageDir '/' 'compute_values.png']);  
handles.button_compute_values= uicontrol('Parent', tab4, 'Style','Pushbutton', 'Position',[50 660 196  36], 'CData',compute_values, ...
          'Callback', 'linear_fit_calculator');

plot_linearizations=imread([ImageDir '/' 'plot_linearizations.png']);  
handles.button_plot_linearizations= uicontrol('Parent', tab4, 'Style','Pushbutton', 'Position',[50 620 196  36], 'CData',plot_linearizations, ...
          'Callback', {@best_fit});      

show_best_fit=imread([ImageDir '/' 'show_best_fit.png']); 
handles.display_best_fit_repeat  = uicontrol('Parent', tab4, 'Style','Pushbutton', 'Position',[50 260 196  36], 'CData',show_best_fit, ...
        'Callback', @display_table_best_fit_repeat);
 
%% Define panels    
% |1| |2| |3|  = |N1| |P1| |P3| = |Gjedde et al. 1982+Cumming et al. 1993| |Gjedde et al. 1982| |Reith et al. 1990|
% |4| |5| |6|  = |N2| |P2| |P4| = |Gjedde 2000| |Logan 1990| |Nahimi 2015|

panel_4_1= uipanel('parent', tab4,'fontsize',12,...
    'backgroundColor','white',...
    'units','pixels',...
    'Position', [300 415 360 360]);

panel_4_2= uipanel('parent', tab4,'fontsize',12,...
    'backgroundColor','white',...
    'units','pixels',...
    'Position', [300+360+15 415 360 360]);

panel_4_3= uipanel('parent', tab4,'fontsize',12,...
    'backgroundColor','white',...
    'units','pixels',...
    'Position', [300+(360*2)+30 415 360 360]);

panel_4_4= uipanel('parent', tab4,'fontsize',12,...
    'backgroundColor','white',...
    'units','pixels',...
    'Position', [300 30 360 360]);

panel_4_5= uipanel('parent', tab4,'fontsize',12,...
    'backgroundColor','white',...
    'units','pixels',...
    'Position', [300+360+15 30 360 360]);

panel_4_6= uipanel('parent', tab4,'fontsize',12,...
    'backgroundColor','white',...
    'units','pixels',...
    'Position', [300+360*2+30 30 360 360]);

panel_legend= uipanel('parent', tab4,'fontsize',12,...
    'backgroundColor','white',...
    'units','pixels',...
    'Position', [65 390 180 220]);

%% 
% |1| |2| |3|  = |N1| |P1| |P3| = |Gjedde et al. 1982+Cumming et al. 1993| |Gjedde et al. 1982| |Reith et al. 1990|
% |4| |5| |6|  = |N2| |P2| |P4| = |Gjedde 2000| |Logan 1990| |Nahimi 2015|

%% Define axes   
handles.ax_N1 = axes('Parent', panel_4_1 , 'units', 'pixels', 'Position',[60 50 280 280]);
handles.ax_P1 = axes('Parent', panel_4_2 ,'units', 'pixels', 'Position',[60 50 280 280]);
handles.ax_P3 = axes('Parent', panel_4_3 , 'units', 'pixels', 'Position',[60 50 280 280]);

handles.ax_N2 = axes('Parent', panel_4_4 , 'units', 'pixels', 'Position',[60 50 280 280]);
handles.ax_P2 = axes('Parent', panel_4_5 , 'units', 'pixels', 'Position',[60 50 280 280]);
handles.ax_P4 = axes('Parent', panel_4_6 , 'units', 'pixels', 'Position',[60 50 280 280]);

handles.legend=axes('Parent', panel_legend , 'units', 'pixels', 'Position',[0 0  0 0]);
set(handles.legend,'handlevisibility','off','visible','off');



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
    frame_start_N1 = evalin ('base','BestFit.N1.firstInd');         % N1 Cumming1993     
    frame_end_N1 = evalin ('base','BestFit.N1.lastInd');
    
    frame_start_N2 = evalin ('base','BestFit.N2.firstInd');         % N2 Gjedde 2000
    frame_end_N2 = evalin ('base','BestFit.N2.lastInd');
     
    frame_start_P1 = evalin ('base','BestFit.P1.firstInd');         % P1 Gjedde 1982
    frame_end_P1 = evalin ('base','BestFit.P1.lastInd');
    
    frame_start_P2 = evalin ('base','BestFit.P2.firstInd');         % P2 Logan 1990 
    frame_end_P2 = evalin ('base','BestFit.P2.lastInd');
     
    frame_start_P3 = evalin ('base','BestFit.P3.firstInd');         % P3 Reith 1990
    frame_end_P3 = evalin ('base','BestFit.P3.lastInd');
    
     frame_start_P4 = evalin ('base','BestFit.P4.firstInd');        % P4 Nahimi 2015
     frame_end_P4 = evalin ('base','BestFit.P4.lastInd');
     



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

%% P3 plot Reith 1990:        

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
%% plot N2 gjedde 2000:       
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

% plot legends    
legends = plot(handles.legend,vol,kappa, 'o','markersize',2.5,'linewidth',2);   
%%     %%%%%%%%%%%%%%%%%%%% Show legends %%%%%%%%%%%%%%%%%%%%%%%%%%
    handle_legend = evalin('base','TAC.name');
    legend(handles.legend,handle_legend, 'Location', 'none', [550 320 0 0]) ;% (Show in a new panel)
    set(handles.legend,'handlevisibility','off','visible','off');

%% redefine axes and title 
%Set graph titles 
set(get(handles.ax_N1, 'Title'), 'String', 'N1'); 
set(get(handles.ax_N2, 'Title'), 'String', 'N2');
 set(get(handles.ax_P1, 'Title'), 'String', 'P1');
 set(get(handles.ax_P2, 'Title'), 'String', 'P2');
 set(get(handles.ax_P3, 'Title'), 'String', 'P3');
 set(get(handles.ax_P4, 'Title'), 'String', 'P4');
 
 %% Set axes titles for dynamic variables 
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

 
    
      function display_table_best_fit_repeat(source,eventdata)
        handles.table_best_fit_tab4 = uitable('Parent', tab4,...
        'ColumnName', {'Start','End', 'min', 'min'},...
        'rowname', {'N1', 'N2', 'P1',....
        'P2', 'P3', 'P4'},...
        'Position',[35 115 236 130]);   
    
        frame= evalin('base', 'BestFit.all_plots');
        set(handles.table_best_fit_tab4, 'Visible', 'on');
        set(handles.table_best_fit_tab4, 'Data', frame, 'ColumnFormat', {'numeric'});
      end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%
%tab5: GOODNESS OF FIT
%%%%%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%
handles.background= axes('Parent', tab5 , 'units', 'pixels','Position',[0 0 1500 820]);
imagesc(background, 'Parent', handles.background);
set(handles.background,'handlevisibility','off','visible','off');

% |1| |2| |3|  = |N1| |P1| |P3| = |Gjedde et al. 1982+Cumming et al. 1993| |Gjedde et al. 1982| |Reith et al. 1990|
% |4| |5| |6|  = |N2| |P2| |P4| = |Gjedde 2000| |Logan 1990| |Nahimi 2015|
%% Define left toolbar
panel_5=imread([ImageDir '/' 'panel5.png']);  
handles.logo = uicontrol('Parent', tab5, 'Style','Pushbutton', 'Position',[0 0 270  820], 'CData',panel_5) 

panel_5_1= uipanel('parent', tab5,'fontsize',12,...
    'backgroundColor','white',...
    'units','pixels',...
    'Position', [300 415 360 360]);

panel_5_2= uipanel('parent', tab5,'fontsize',12,...
    'backgroundColor','white',...
    'units','pixels',...
    'Position', [300+360+15 415 360 360]);

panel_5_3= uipanel('parent', tab5,'fontsize',12,...
    'backgroundColor','white',...
    'units','pixels',...
    'Position', [300+(360*2)+30 415 360 360]);

% next row
panel_5_4= uipanel('parent', tab5,'fontsize',12,...
    'backgroundColor','white',...
    'units','pixels',...
    'Position', [300 30 360 360]);

panel_5_5= uipanel('parent', tab5,'fontsize',12,...
    'backgroundColor','white',...
    'units','pixels',...
    'Position', [300+360+15 30 360 360]);

panel_5_6= uipanel('parent', tab5,'fontsize',12,...
    'backgroundColor','white',...
    'units','pixels',...
    'Position', [300+360*2+30 30 360 360]);

% Define buttons
plot_rsq=imread([ImageDir '/' 'plot_rsq.png']);  
handles.button_plot_rsq= uicontrol('Parent', tab5, 'Style','Pushbutton', 'Position',[50 660 196  36], 'CData',plot_rsq, ...
          'Callback', {@rsq});
      
custom_fit=imread([ImageDir '/' 'custom_fit.png']);  
handles.custom_fit = uicontrol('Parent', tab5, 'Style','Pushbutton', 'Position',[50 620 196  36], 'CData',custom_fit, ...
          'Callback','KiWi_custom');         
         
handles.rsq_N1 = axes('Parent', panel_5_1 , 'units', 'pixels', 'Position',[50 50 280 280]);
handles.rsq_P1 = axes('Parent', panel_5_2 ,'units', 'pixels', 'Position',[50 50 280 280]);
handles.rsq_P3 = axes('Parent', panel_5_3 , 'units', 'pixels', 'Position',[50 50 280 280]);

handles.rsq_N2 = axes('Parent', panel_5_4 , 'units', 'pixels', 'Position',[50 50 280 280]);
handles.rsq_P2 = axes('Parent', panel_5_5 , 'units', 'pixels', 'Position',[50 50 280 280]);
handles.rsq_P4 = axes('Parent', panel_5_6 , 'units', 'pixels', 'Position',[50 50 280 280]);

%% Set graph titles: 
 set(get(handles.rsq_N1, 'Title'), 'String', 'N1'); % Gjedde et al. 1982, Cumming et al. 1993
 set(get(handles.rsq_P1, 'Title'), 'String', 'P1'); % Gjedde et al, 1982
 set(get(handles.rsq_P3, 'Title'), 'String', 'P3'); % Reith et al. 1990
 
 set(get(handles.rsq_N2, 'Title'), 'String', 'N2'); % Gjedde 2000
 set(get(handles.rsq_P2, 'Title'), 'String', 'P2'); % Logan 1990
 set(get(handles.rsq_P4, 'Title'), 'String', 'P4'); % Nahimi 2015
 
 %% Set axes in tab5
 set(get(handles.rsq_N1, 'XLabel'), 'String', 'Time of Last Frame [min]', 'FontSize', 10, 'FontName', 'Arial');
 set(get(handles.rsq_N1, 'YLabel'), 'String', 'R^{2}', 'FontSize', 10, 'FontName', 'Arial');  

 set(get(handles.rsq_P1, 'XLabel'), 'String', 'Time of Last Frame [min]', 'FontSize', 10, 'FontName', 'Arial');
 set(get(handles.rsq_P1, 'YLabel'), 'String', 'R^{2}', 'FontSize', 10, 'FontName', 'Arial');

 set(get(handles.rsq_P3, 'XLabel'), 'String', 'Time of Last Frame [min]', 'FontSize', 10, 'FontName', 'Arial');
 set(get(handles.rsq_P3, 'YLabel'), 'String', 'R^{2}', 'FontSize', 10, 'FontName', 'Arial');
 
 set(get(handles.rsq_N2, 'XLabel'), 'String', 'Time of Last Frame [min]', 'FontSize', 10, 'FontName', 'Arial');
 set(get(handles.rsq_N2, 'YLabel'), 'String', 'R^{2}', 'FontSize', 10, 'FontName', 'Arial');  

 set(get(handles.rsq_P2, 'XLabel'), 'String', 'Time of Last Frame [min]', 'FontSize', 10, 'FontName', 'Arial');
 set(get(handles.rsq_P2, 'YLabel'), 'String', 'R^{2}', 'FontSize', 10, 'FontName', 'Arial');
 
 set(get(handles.rsq_P4, 'XLabel'), 'String', 'Time of Last Frame [min]', 'FontSize', 10, 'FontName', 'Arial');
 set(get(handles.rsq_P4, 'YLabel'), 'String', 'R^{2}', 'FontSize', 10, 'FontName', 'Arial');
 
 
function rsq(source,eventdata) % calculates time window of best linear fit
     %% get dynamic parameters:
     rsq = evalin('base','BestFit.rsq_all');
     time = evalin('base','TAC.time_min'); %
     start=evalin('base','BestFit.FrameConfig.FrameWidth');
     
     N1_LastInd =evalin('base','BestFit.N1.lastInd');
     N1_FirstInd=evalin('base','BestFit.N1.firstInd');
     
     N2_LastInd =evalin('base','BestFit.N2.lastInd');
     N2_FirstInd=evalin('base','BestFit.N2.firstInd');
     
     P1_LastInd =evalin('base','BestFit.P1.lastInd');
     P1_FirstInd=evalin('base','BestFit.P1.firstInd');
     
     P2_LastInd =evalin('base','BestFit.P2.lastInd');
     P2_FirstInd=evalin('base','BestFit.P2.firstInd');
     
     P3_LastInd =evalin('base','BestFit.P3.lastInd');
     P3_FirstInd=evalin('base','BestFit.P3.firstInd');
     
     P4_LastInd =evalin('base','BestFit.P4.lastInd');
     P4_FirstInd=evalin('base','BestFit.P4.firstInd');  
     
% Display Rsq plots for N2 model (Gjedde et al. 1982a, Cumming et al. 1993)
% [AX,H1,H2] = plotyy(x,H1,x,H2) 
[pax,pLine1,pLine2] = plotyy(handles.rsq_N1,...
         time(start:end,1),...
         rsq(:,1),...  %(:,2) number indicates column in BestFit.rsq_all
         time(N1_LastInd,1),...
         rsq(N1_FirstInd,1));
     
set(pLine1, 'marker', 'o',...
            'markersize',2.5,...
            'linewidth',2,...
            'linestyle', 'none');
        
set(pLine2, 'marker', '*','markersize',7,...
            'linewidth',2,...
            'linestyle', 'none');
        
set(pax(1),'ylim',[0.7,1], 'ytick', [0.7 0.8 0.9 1],...
'Xgrid','on','Ygrid','on','XMinorGrid','on','YMinorGrid','on');    
set(pax(2),'ylim',[0.7,1], 'ytick', []);     
legend([pLine1;pLine2],'R^{2} of Iterative Analysis','R^{2} of Best Fit Interval', 'Location', 'SouthWest');

% Display Rsq plots for N2 model (Gjedde 2000)
[pax,pLine1,pLine2] = plotyy(handles.rsq_N2,...
         time(start:end,1),...
         rsq(:,2),...       %(:,2) number indicates column in BestFit.rsq_all
         time(N2_LastInd,1),...
         rsq(N2_FirstInd,2)); %(:,2) number indicates column in BestFit.rsq_all
     
set(pLine1, 'marker', 'o',...
            'markersize',2.5,...
            'linewidth',2,...
            'linestyle', 'none');
        
set(pLine2, 'marker', '*','markersize',7,...
            'linewidth',2,...
            'linestyle', 'none');
        
set(pax(1),'ylim',[0.7,1], 'ytick', [0.7 0.8 0.9 1],...
'Xgrid','on','Ygrid','on','XMinorGrid','on','YMinorGrid','on');    
set(pax(2),'ylim',[0.7,1], 'ytick', []);        

% Display Rsq plots for P1 model (Gjedde et al, 1982b)
[pax,pLine1,pLine2] = plotyy(handles.rsq_P1,...
         time(start:end,1),...
         rsq(:,3),...       %(:,2) number indicates column in BestFit.rsq_all
         time(P1_LastInd,1),...
         rsq(P1_FirstInd,3)); %(:,2) number indicates column in BestFit.rsq_all
     
set(pLine1, 'marker', 'o',...
            'markersize',2.5,...
            'linewidth',2,...
            'linestyle', 'none');
        
set(pLine2, 'marker', '*','markersize',7,...
            'linewidth',2,...
            'linestyle', 'none');
set(pax(1),'ylim',[0.7,1], 'ytick', [0.7 0.8 0.9 1],...
'Xgrid','on','Ygrid','on','XMinorGrid','on','YMinorGrid','on');    
set(pax(2),'ylim',[0.7,1], 'ytick', []);     

% Display Rsq plots for P2 model (Logan et al, 1990)
[pax,pLine1,pLine2] = plotyy(handles.rsq_P2,...
         time(start:end,1),...
         rsq(:,4),...       %(:,2) number indicates column in BestFit.rsq_all
         time(P2_LastInd,1),...
         rsq(P2_FirstInd,4)); %(:,2) number indicates column in BestFit.rsq_all
     
set(pLine1, 'marker', 'o',...
            'markersize',2.5,...
            'linewidth',2,...
            'linestyle', 'none');
        
set(pLine2, 'marker', '*','markersize',7,...
            'linewidth',2,...
            'linestyle', 'none');

set(pax(1),'ylim',[0.7,1], 'ytick', [0.7 0.8 0.9 1],...
'Xgrid','on','Ygrid','on','XMinorGrid','on','YMinorGrid','on');    
set(pax(2),'ylim',[0.7,1], 'ytick', []);          


% Display Rsq plots for P3 model (Reith et al. 1990)
[pax,pLine1,pLine2] = plotyy(handles.rsq_P3,...
         time(start:end,1),...
         rsq(:,5),...       %(:,2) number indicates column in BestFit.rsq_all
         time(P3_LastInd,1),...
         rsq(P3_FirstInd,5)); %(:,2) number indicates column in BestFit.rsq_all
     
set(pLine1, 'marker', 'o',...
            'markersize',2.5,...
            'linewidth',2,...
            'linestyle', 'none');
        
set(pLine2, 'marker', '*','markersize',7,...
            'linewidth',2,...
            'linestyle', 'none');
        
set(pax(1),'ylim',[0.7,1], 'ytick', [0.7 0.8 0.9 1],...
'Xgrid','on','Ygrid','on','XMinorGrid','on','YMinorGrid','on');    
set(pax(2),'ylim',[0.7,1], 'ytick', []);     

% Display Rsq plots for P4 model (Nahimi et al. 2015)
[pax,pLine1,pLine2] = plotyy(handles.rsq_P4,...
         time(start:end,1),...
         rsq(:,6),...       %(:,2) number indicates column in BestFit.rsq_all
         time(P4_LastInd,1),...
         rsq(P4_FirstInd,6)); %(:,2) number indicates column in BestFit.rsq_all
     
set(pLine1, 'marker', 'o',...
            'markersize',2.5,...
            'linewidth',2,...
            'linestyle', 'none');
        
set(pLine2, 'marker', '*','markersize',7,...
            'linewidth',2,...
            'linestyle', 'none');
set(pax(1),'ylim',[0.7,1], 'ytick', [0.7 0.8 0.9 1],...
'Xgrid','on','Ygrid','on','XMinorGrid','on','YMinorGrid','on');    
set(pax(2),'ylim',[0.7,1], 'ytick', []);     

%% Set graph titles: 
 set(get(handles.rsq_N1, 'Title'), 'String', 'N1'); % Gjedde et al. 1982, Cumming et al. 1993
 set(get(handles.rsq_P1, 'Title'), 'String', 'P1'); % Gjedde et al, 1982
 set(get(handles.rsq_P3, 'Title'), 'String', 'P3'); % Reith et al. 1990
 
 set(get(handles.rsq_N2, 'Title'), 'String', 'N2'); % Gjedde 2000
 set(get(handles.rsq_P2, 'Title'), 'String', 'P2'); % Logan 1990
 set(get(handles.rsq_P4, 'Title'), 'String', 'P4'); % Nahimi 2015

end

%% %%%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%
%tab6: SHOW RESULTS VT K1,k2'
%%%%%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Appearance
handles.background= axes('Parent', tab6 , 'units', 'pixels','Position',[0 0 1500 820]);
imagesc(background, 'Parent', handles.background);
set(handles.background,'handlevisibility','off','visible','off');
         
panel_6=imread([ImageDir '/' 'panel6.png']);  
handles.logo = uicontrol('Parent', tab6, 'Style','Pushbutton', 'Position',[0 0 270  820], 'CData',panel_6)          

% BUTTONS
compute_steady_state_values=imread([ImageDir '/' 'compute_values.png']);  
handles.compute_steady_state_values= uicontrol('Parent', tab6, 'Style','Pushbutton', 'Position',[50 660 196  36], 'CData',compute_steady_state_values, ...
          'Callback', 'steady_state_parameters_calculator');

display_estimates=imread([ImageDir '/' 'display_estimates.png']);  
handles.display_estimates= uicontrol('Parent', tab6, 'Style','Pushbutton', 'Position',[50 620 196  36], 'CData',display_estimates, ...
          'Callback', {@display_steady_state_parameters});
      


   
    function display_steady_state_parameters (source,eventdata)
% DEFINE TABLES
       
columnname=evalin('base','TAC.name'); % get the ROI names

% define tableVT
handles.uitable_VT = uitable('Parent', tab6,...
        'ColumnName', columnname,...
        'rowname', {'N1 ', 'N2 ', 'P1 ','P2 ',....
        'P3 ', 'P4 '},...
        'Position',[500 570 930 148]);
    
% define table K1
handles.uitable_K1 = uitable('Parent', tab6,...
        'ColumnName', columnname,...
        'rowname', {'N1 ', 'N2 ', 'P1 ','P2 ',....
        'P3 ', 'P4 '},...
        'Position',[500 570-170 930 148]);
     
% define table k2
handles.uitable_k2 = uitable('Parent', tab6,...
        'ColumnName', columnname,...
        'rowname', {'N1 ', 'N2 ', 'P1 ','P2 ',....
        'P3 ', 'P4 '},...
        'Position',[500 570-170*2 930 148]);

% define table RSquared
handles.uitable_rsq = uitable('Parent', tab6,...
        'ColumnName', columnname,...
        'rowname', {'N1 ', 'N2 ', 'P1 ',....
        'P2 ', 'P3 ', 'P4 '},...
        'Position',[500 570-170*3 930 148]); 

% Now access the data in workspace
        VT = evalin('base', 'SteadyState.VT.all_plots');
        K1=evalin('base', 'SteadyState.K1.all_plots');
        k2=evalin('base', 'SteadyState.k2.all_plots');
        rsq=evalin('base', 'SteadyState.rsq.all_plots');

% Now Make the values visible in 
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
handles.button_show_VT= uicontrol('Parent', tab6, 'Style','Pushbutton', 'Position',[300 680 196  36], 'CData',VT);        
K1=imread([ImageDir '/' 'K1.png']);  
handles.button_show_K1= uicontrol('Parent', tab6, 'Style','Pushbutton', 'Position',[300 680-170 196  36], 'CData',K1);
k2=imread([ImageDir '/' 'k2.png']);  
handles.button_show_k2= uicontrol('Parent', tab6, 'Style','Pushbutton', 'Position',[300 680-170*2 196  36], 'CData',k2);
rsq_values=imread([ImageDir '/' 'rsq.png']);  
handles.button_show_rsq= uicontrol('Parent', tab6, 'Style','Pushbutton', 'Position',[300 680-170*3 196  36], 'CData',rsq_values);
     
%% %%%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%
%tab7: LINEARIZED PLOTS - BEST FIT
%%%%%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%-o-%%%%%%%%%%%%%%%%%%%%%%%%%%%
handles.background= axes('Parent', tab7 , 'units', 'pixels','Position',[0 0 1500 820]);
imagesc(background, 'Parent', handles.background);
set(handles.background,'handlevisibility','off','visible','off');

%% Define left toolbar
panel_7=imread([ImageDir '/' 'panel7.png']);  
handles.logo = uicontrol('Parent', tab7, 'Style','Pushbutton', 'Position',[0 0 270  820], 'CData',panel_7) 

panel_7_1= uipanel('parent', tab7,'fontsize',12,...
    'backgroundColor','white',...
    'units','pixels',...
    'Position',  [300 365 525 345]);

% BUTTONS
add_notes=imread([ImageDir '/' 'add_notes.png']);  
handles.button_plot_rsq= uicontrol('Parent', tab7, 'Style','Pushbutton', 'Position',[50 660 196  36], 'CData',add_notes, ...
          'Callback', {@saveNotes});
 %%        
handles.editbox_notes1 = uicontrol('Parent', panel_7_1, 'style','edit',...
    'units','pixels',...
    'horizontalAlignment', 'left',...
    'string','YYYY MM DD',...
    'FontSize',10,...
    'position',[160 300 314 25]);

handles.editbox_notes2 = uicontrol('Parent', panel_7_1, 'style','edit',...
    'units','pixels',...
    'horizontalAlignment', 'left',...
    'string','...',...
    'FontSize',10,...
    'position',[160 264 314 25]) ;  

handles.editbox_notes3 = uicontrol('Parent', panel_7_1, 'style','edit',...
    'units','pixels',...
    'horizontalAlignment', 'left',...
    'string','...',...
    'FontSize',10,...
    'position',[160 229 314 25]);

handles.editbox_notes4 = uicontrol('Parent', panel_7_1, 'style','edit',...
    'units','pixels',...
    'horizontalAlignment', 'left',...
    'string','...',...
    'FontSize',10,...
    'position',[160 194 314 25]) ;  

function saveNotes(source, eventdata)
      s1= get(handles.editbox_notes1, 'string');
      assignin('base', 'notes1', s1);
     
      s2= get(handles.editbox_notes2, 'string');
       assignin('base', 'notes2',  s2);
       
      s3= get(handles.editbox_notes3, 'string');
       assignin('base', 'notes3',  s3);
       
      s4= get(handles.editbox_notes4, 'string');
       assignin('base', 'notes4',  s4);
            
end

%% 
text1 = uicontrol('Parent', panel_7_1, 'style','text',...
    'units','pixels',...
    'horizontalAlignment', 'left',...
    'string','Analysis date:',...
    'FontSize',10,...
    'BackgroundColor','white',...
    'position',[20 290 120 25]);

text2 = uicontrol('Parent', panel_7_1, 'style','text',...
    'units','pixels',...
    'horizontalAlignment', 'left',...
    'string','Study ID:',...
    'FontSize',10,...
    'BackgroundColor','white',...
    'position',[20 255 120 25]) ;  

text3 = uicontrol('Parent', panel_7_1, 'style','text',...
    'units','pixels',...
    'horizontalAlignment', 'left',...
    'string','Best fit frames',...
    'FontSize',10,...
    'BackgroundColor','white',...
    'position',[20 220 120 25]);


%% RIGHT PANEL FUNCTIONS
% BUTTONS
% save data button
SaveDataText = sprintf('Click here to save data'); % Text to display when you hover your mouse over button   
save_data=imread([ImageDir '/' 'save_data.png']);  
handles.save_data = uicontrol('Parent', tab1, 'Style','Pushbutton', 'Position',[1455 660 35  35], 'CData',save_data, ...
          'Callback','save_file');      
set(handles.save_data,'TooltipString',SaveDataText);      
      
handles.save_data = uicontrol('Parent', tab2, 'Style','Pushbutton', 'Position',[1455 660 35  35], 'CData',save_data, ...
          'Callback','save_file');
SaveDataText = sprintf('Click here to save data');
set(handles.save_data,'TooltipString',SaveDataText);      
 
handles.save_data = uicontrol('Parent', tab3, 'Style','Pushbutton', 'Position',[1455 660 35  35], 'CData',save_data, ...
          'Callback','save_file');
SaveDataText = sprintf('Click here to save data');
set(handles.save_data,'TooltipString',SaveDataText);      

handles.save_data = uicontrol('Parent', tab4, 'Style','Pushbutton', 'Position',[1455 660 35  35], 'CData',save_data, ...
          'Callback','save_file');
SaveDataText = sprintf('Click here to save data');
set(handles.save_data,'TooltipString',SaveDataText);

handles.save_data = uicontrol('Parent', tab5, 'Style','Pushbutton', 'Position',[1455 660 35  35], 'CData',save_data, ...
          'Callback','save_file');
SaveDataText = sprintf('Click here to save data');
set(handles.save_data,'TooltipString',SaveDataText);

handles.save_data = uicontrol('Parent', tab6, 'Style','Pushbutton', 'Position',[1455 660 35  35], 'CData',save_data, ...
          'Callback','save_file');
SaveDataText = sprintf('Click here to save data');
set(handles.save_data,'TooltipString',SaveDataText);

handles.save_data = uicontrol('Parent', tab7, 'Style','Pushbutton', 'Position',[1455 660 35  35], 'CData',save_data, ...
          'Callback','save_file');
SaveDataText = sprintf('Click here to save data');
set(handles.save_data,'TooltipString',SaveDataText);

% Clear work space button
ClearText = sprintf('Clear Work Space'); % Text to display when you hover your mouse over button   
clear_data=imread([ImageDir '/' 'clear.png']);  
handles.clear_data = uicontrol('Parent', tab1, 'Style','Pushbutton', 'Position',[1455 400 35  35], 'CData',clear_data, ...
          'Callback','clear_data');
set(handles.clear_data,'TooltipString',ClearText);

handles.clear_data = uicontrol('Parent', tab2, 'Style','Pushbutton', 'Position',[1455 400 35  35], 'CData',clear_data, ...
          'Callback','clear_data');
set(handles.clear_data,'TooltipString',ClearText);

handles.clear_data = uicontrol('Parent', tab3, 'Style','Pushbutton', 'Position',[1455 400 35  35], 'CData',clear_data, ...
          'Callback','clear_data');
set(handles.clear_data,'TooltipString',ClearText);

handles.clear_data = uicontrol('Parent', tab4, 'Style','Pushbutton', 'Position',[1455 400 35  35], 'CData',clear_data, ...
          'Callback','clear_data');
set(handles.clear_data,'TooltipString',ClearText);

handles.clear_data = uicontrol('Parent', tab5, 'Style','Pushbutton', 'Position',[1455 400 35  35], 'CData',clear_data, ...
          'Callback','clear_data');
set(handles.clear_data,'TooltipString',ClearText);

handles.clear_data = uicontrol('Parent', tab6, 'Style','Pushbutton', 'Position',[1455 400 35  35], 'CData',clear_data, ...
          'Callback','clear_data');
set(handles.clear_data,'TooltipString',ClearText);

handles.clear_data = uicontrol('Parent', tab7, 'Style','Pushbutton', 'Position',[1455 400 35  35], 'CData',clear_data, ...
          'Callback','clear_data');
set(handles.clear_data,'TooltipString',ClearText);

% Clear work space button
FaqText = sprintf('Go To References'); % Text to display when you hover your mouse over button   
save_data=imread([ImageDir '/' 'faq.png']);  

handles.save_data = uicontrol('Parent', tab1, 'Style','Pushbutton', 'Position',[1455 400-260 35  35], 'CData',save_data, ...
          'Callback','FAQ');      
set(handles.save_data,'TooltipString',FaqText);      
 
handles.save_data = uicontrol('Parent', tab2, 'Style','Pushbutton', 'Position',[1455 400-260 35  35], 'CData',save_data, ...
          'Callback','FAQ');      
set(handles.save_data,'TooltipString',FaqText);   

handles.save_data = uicontrol('Parent', tab3, 'Style','Pushbutton', 'Position',[1455 400-260 35  35], 'CData',save_data, ...
          'Callback','FAQ');      
set(handles.save_data,'TooltipString',FaqText);   

handles.save_data = uicontrol('Parent', tab4, 'Style','Pushbutton', 'Position',[1455 400-260 35  35], 'CData',save_data, ...
          'Callback','FAQ');      
set(handles.save_data,'TooltipString',FaqText);   

handles.save_data = uicontrol('Parent', tab5, 'Style','Pushbutton', 'Position',[1455 400-260 35  35], 'CData',save_data, ...
          'Callback','FAQ');      
set(handles.save_data,'TooltipString',FaqText);   

handles.save_data = uicontrol('Parent', tab6, 'Style','Pushbutton', 'Position',[1455 400-260 35  35], 'CData',save_data, ...
          'Callback','FAQ');      
set(handles.save_data,'TooltipString',FaqText);  
%exit_text = sprintf('Exit KiWi'); % Text to display when you hover your mouse over button   
%exit=imread([ImageDir '/' 'exit.png']);  
%handles.exit = uicontrol('Parent', tab1, 'Style','Pushbutton', 'Position',[1455 140 35  35], 'CData',exit, ...
%          'Callback','exit');      
%set(handles.exit,'TooltipString',exit_text);    

end
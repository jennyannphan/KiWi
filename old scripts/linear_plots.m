% Plot the linear fit of frames with best fit
h.fig2 = figure('MenuBar', 'none','units','pixels','Position', [0 0 1280 750],... % [x,y,width, height]
    'name','KinA | Linear regression | - STEP2','numbertitle','off','Resize', 'off');

uicontrol('Style','text', 'string','Display best linear fits - "individual"',  'Position',[150 700 500 30],...
    'fontsize', 18, 'FontName', 'Calibri');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%- PLOT ALL -%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Define axes   
handles.ax_gjedde2000 = axes('units', 'pixels', 'Position',[250 410 300 250]);
handles.ax_logan1990 = axes('units', 'pixels', 'Position',[600 410 300 250]);
handles.ax_hypotime = axes('units', 'pixels', 'Position',[950 410 300 250]);
handles.ax_gjedde1993 = axes('units', 'pixels', 'Position',[250 60 300 250]);
handles.ax_gjedde1982 = axes('units', 'pixels', 'Position',[600 60 300 250]);
handles.ax_reith1990 = axes('units', 'pixels', 'Position',[950 60 300 250]);

 %Set graph titles 
 set(get(handles.ax_gjedde2000, 'Title'), 'String', 'Gjedde 2000');
 set(get(handles.ax_logan1990, 'Title'), 'String', 'Logan 1990');
 set(get(handles.ax_hypotime, 'Title'), 'String', 'Hypotime');
 set(get(handles.ax_gjedde1993, 'Title'), 'String', 'Gjedde 1993');
 set(get(handles.ax_gjedde1982, 'Title'), 'String', 'Gjedde 1982');
 set(get(handles.ax_reith1990, 'Title'), 'String', 'Reith 1990');

% plot linearized curves
%1
plot(handles.ax_gjedde2000,dynamic.kappa(linear.gjedde2000.firstInd:linear.gjedde2000.lastInd,:),...
     dynamic.vol(linear.gjedde2000.firstInd:linear.gjedde2000.lastInd,:),'o');
%2
plot(handles.ax_logan1990,dynamic.kappa_reciproc(linear.logan1990.firstInd:linear.logan1990.lastInd,:), ...
     dynamic.theta(linear.logan1990.firstInd:linear.logan1990.lastInd,:),'o');
%3
plot(handles.ax_hypotime,dynamic.theta_reciproc(linear.hypotime.firstInd:linear.hypotime.lastInd,:), ...
     dynamic.vol_reciproc(linear.hypotime.firstInd:linear.hypotime.lastInd,:),'o');
%4 
plot(handles.ax_gjedde1993,dynamic.vol(linear.gjedde1993.firstInd:linear.gjedde1993.lastInd,:), ...
     dynamic.kappa(linear.gjedde1993.firstInd:linear.gjedde1993.lastInd,:),'o');
%5
plot(handles.ax_gjedde1982,dynamic.vol(linear.gjedde1982.firstInd:linear.gjedde1982.lastInd,:), ...
     dynamic.kappa(linear.gjedde1982.firstInd:linear.gjedde1982.lastInd,:),'o');
%6
plot(handles.ax_reith1990,dynamic.vol(linear.reith1990.firstInd:linear.reith1990.lastInd,:), ...
     dynamic.kappa(linear.reith1990.firstInd:linear.reith1990.lastInd,:),'o');
 
 % Show legends (ROI) for all plots
handles.legends = axes('units', 'pixels', 'Position',[0.1 670 0.1 0.1]);
plot(handles.legends,dynamic.vol(:,:), ...
     dynamic.kappa(:,:),'o', 'markersize', 4);
  set(gca,'visible','off','xtick',[]);
  
 legend_handle=legend (ans.name);
    set(legend_handle,'location', 'west')
     


 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
%show time windows

%%text:
txt_plots = sprintf('\n  Gjedde2000: \n  Logan 1990: \n Hypotime: \n  Gjedde 1993: \n  Gjedde 1982: \n Reith 1990:');
uicontrol('Style','text', 'string', txt_plots, 'Position',[25 100 100 110],    'fontsize', 10, 'FontName', 'Calibri');

%%heading:
txt_time_frame = sprintf('Time window [min]');
uicontrol('Style','text', 'string', txt_time_frame, 'Position',[0.1 200 100 20],'fontsize', 12, 'FontName', 'Calibri');

%time for gjedde2000
gjedde2000_start = sprintf(ans.time_min(1,linear.gjedde2000.firstInd));
uicontrol('Style','text', 'string', gjedde2000_start, 'Position',[25 100 100 110],    'fontsize', 10, 'FontName', 'Calibri');


function [hFig]=loadingScreen()

% get the figure and axes handles
logo = imread('playful2.jpg');
logo = imresize(logo,[490,286]);
imshow(logo);
hFig = gcf;
hAx  = gca;
% set the figure to full screen
set(hFig,'units','normalized','outerposition',[0.4 0.1 0.2 0.7]);
% set the axes to full screen
set(hAx,'Unit','normalized','Position',[0 0 1 1]);
% hide the toolbar
set(hFig,'menubar','none')
% to hide the title
% title('Automagic')
title(['\fontsize{16}A {\color{magenta}U '...
'\color[rgb]{0 .5 .5}T \color{red}O} \fontsize{16}M {\color{magenta}A '...
'\color[rgb]{0 .5 .5}G \color{red}I} \fontsize{16}C']);
set(hFig,'NumberTitle','off');
t = text(100, 500 ,'Loading...');
t.FontSize = 20;
set(hFig,'Name','Automagic v.2.3.8');
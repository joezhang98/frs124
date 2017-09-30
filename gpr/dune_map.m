% Author:       Joe Zhang
% Email:        zhaoz@princeton.edu
% Date Started: 03/30/17
% Date Updated: 05/04/17
% 
% Function: duneMap
%
% Input:  n/a
% Output: n/a
%
% Description: Plots all transect lines taken by the GPR at the Dune du
%              Pilat site.  The figure is split into three separate plots
%              to better highlight the different types of lines taken.
%
% BEGIN CODE
function duneMap

% Saves the directory where GPS data is located
diro='/Users/zhaozhang/frs124/GPR/data/duneDuPilat/';
perh=fullfile(diro,'gathered.mat');

% tic - timing function (start)
% Gathers all GPS coordinates into three structures (easting, northing,
% elevation)
if exist(perh)~=2
    for index=2:37
        wantit=sprintf('FILE____%3.3i.csv',index);
        try
            [x02{index},y02{index},z02{index}]=...
                gatherVariables(fullfile(diro,'/grid1/',wantit));
            c02{index}=1;
        catch
            try
                [x02{index},y02{index},z02{index}]=...
                    gatherVariables(fullfile(diro,'/grid2/',wantit));
                c02{index}=2;
            catch
                try
                    [x02{index},y02{index},z02{index}]=...
                        gatherVariables(fullfile(diro,'/lines/',wantit));
                    c02{index}=3;
                catch
                    try
                        [x02{index},y02{index},z02{index}]=...
                            gatherVariables(fullfile...
                            (diro,'/treeline/',wantit));
                        c02{index}=4;
                    catch
                        [x02{index},y02{index},z02{index}]=...
                            gatherVariables(fullfile...
                            (diro,'/calibration/',wantit));
                        c02{index}=5;
                    end
                end
            end
        end
    end
    save(perh,'x02','y02','z02','c02')
else
    load(perh)
end
% toc - timing function (stop)

% Color symbols for the different categories of line transects
cols={'green','green','r','k','b'};
axys=[2 2 1 1 3];
clf

% Here you premake them (i.e. the figures)
ah(1)=subplot(131);
ah(2)=subplot(132);
ah(3)=subplot(133);

% Defines mineasting and minnorthing so axes make more sense
mineast=641835; minnorth=4939369;
mineast3=642319; minnorth3=4939819.5;

% Here you use them all - i.e. plot all GPR data in the background
cgray=[0.7 0.7 0.7];
for index=2:37
    % Where to direct this plot?
    axes(ah(1)); p1(index)=...
        plot(x02{index}-mineast,y02{index}-minnorth,'Color',cgray);
    hold on
    axes(ah(2)); p2(index)=...
        plot(x02{index}-mineast,y02{index}-minnorth,'Color',cgray);
    hold on
end


% Now you use them individually - i.e. display lines to specific plots
for index=2:37
    % Where to direct this plot?
    axes(ah(axys(c02{index})))
    if index<14 || index>14
        ph(index)=...
            plot(x02{index}-mineast,y02{index}-minnorth,cols{c02{index}});
    end
    if index==14
        ph(index)=plot(x02{index}-mineast3,...
            y02{index}-minnorth3,cols{c02{index}});
    end
    if c02{index}==1
        ph(index).Color=[0 0.7 0];
    end
    if c02{index}==2
        ph(index).Color=[0 0.7 0];
    end
    ph(index).LineWidth=2;
    hold on; grid on
end
hold off
axis equal

% Mark the special one
ph(14).Marker='s';
ph(14).MarkerSize=6;
ph(14).MarkerFaceColor=ph(14).Color;
p1(14).Marker='s';
p1(14).Color=ph(14).Color;
p2(14).Color=ph(14).Color;
p1(14).MarkerFaceColor=ph(14).MarkerFaceColor;
p2(14).MarkerFaceColor=ph(14).MarkerFaceColor;
p1(14).MarkerSize=6;
p2(14).Marker='s';
p2(14).MarkerSize=6;

% Prettify the plots
% First subplot
ah(1)=subplot(131);
xlabel(sprintf('Easting from %d [m]',mineast),'FontSize',10);
ylabel(sprintf('Northing from %d [m]',minnorth),'FontSize',10);
axis tight
xli=xlim;
yli=ylim;
xperc=5; xspace=round([xli(2)-xli(1)]*xperc/100);
yperc=5; yspace=round([yli(2)-yli(1)]*yperc/100);
xlim(xli+[-1 1]*xspace);
ylim(yli+[-1 1]*yspace);
set(gca,'TickDir','out','TickLength',[0.02 0.025]/2)
tstring='(a) Transect Line Locations';
tl=title(tstring,'FontSize',14);
tl.Position=tl.Position+[0 yspace/4 0];

% second subplot
ah(2)=subplot(132);
xlabel(sprintf('Easting from %d [m]',mineast),'FontSize',10);
ylabel(sprintf('Northing from %d [m]',minnorth),'FontSize',10);
axis tight
xli=xlim;
yli=ylim;
xperc=5; xspace=round([xli(2)-xli(1)]*xperc/100);
yperc=15; yspace=round([yli(2)-yli(1)]*yperc/100);
xlim(xli+[-1 1]*xspace);
ylim(yli+[-1 1]*yspace);
set(gca,'TickDir','out','TickLength',[0.02 0.025]/2)
tstring='(b) Grid Locations';
tl=title(tstring,'FontSize',14);
tl.Position=tl.Position+[0 yspace/8 0];

% third subplot
ah(3)=subplot(133);
xlabel(sprintf('Easting from %d [m]',mineast3),'FontSize',10);
ylabel(sprintf('Northing from %.1f [m]',minnorth3),'FontSize',10);
axis tight
xli=xlim;
yli=ylim;
xperc=5; xspace=round([xli(2)-xli(1)]*xperc/100);
yperc=15; yspace=round([yli(2)-yli(1)]*yperc/100);
xlim(xli+[-1 1]*xspace);
ylim(yli+[-1 1]*yspace);
set(gca,'TickDir','out','TickLength',[0.02 0.025]/2)
handle=title('(c) Depth Calibration','FontSize',14);
set(handle,'Position',[1,1.4,0]);
axes(ah(3))
axis([0 1e6*0.642321095743802-mineast3...
    0 1e6*4.939820872686718-minnorth3])

% Make sure it works - prints and saves the figure
orient landscape
%print('-dpdf','-bestfit',mfilename)
figdir='/Users/zhaozhang/frs124/GPR/submissions';
% Issue the print command, which does the same as "save" it
print('-dpdf','-bestfit',fullfile(figdir,'duneMap-fig.pdf'))
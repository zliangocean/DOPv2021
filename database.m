
% load DOPv2021 database
data = readtable('dopv2021.csv');
% remove BML DOP concentration
data = data(data.DOP_flag == 2,:);


%% make Figure 1
%% generate global of DOP distribution ()
%% this code needs 'm_map' package to run
data(data.LONGITUDE<=20,:).LONGITUDE = data(data.LONGITUDE<=20,:).LONGITUDE+360;
thisstudy = data(strcmp(data.reference,'this study'),:);
m_proj('Equidistant Cylindrical','lon',[20,380])

h1=m_line(data.LONGITUDE,data.LATITUDE,'marker','o','color','k','linewi',0.5,...
          'linest','none','markersize',4,'markerfacecolor','k')
h2=m_line(thisstudy.LONGITUDE,thisstudy.LATITUDE,'marker','o','color','r','linewi',0.5,...
          'linest','none','markersize',4,'markerfacecolor','r')
m_coast('patch',[.6 .6 .6]);
m_grid('box','fancy','linestyle','-','gridcolor','none','backcolor',[1 1 1],...
    'fontsize',20);
legend([h1 h2],'Observations from literature','Observations in this study');




%% make Figure 4
% make Figure 4a
% plot histogram of dop concentration 
datapos = data(data.DOP>0,:);
parmhat = lognfit(datapos.DOP);
xt = 0:0.01:0.7;
r = lognpdf(xt,parmhat(1),parmhat(2))

h = histfit(datapos.DOP,25,'lognormal')
h(2).Color = [0,0,0]

h(2).LineStyle = '--'
hold on
h = histfit(datapos.DOP,25,'lognormal')
h(1).FaceColor = '#67ABD7';
h(2).Color = [0,0,0]
h(2).LineStyle = '--'

xlim([0 0.7])
ylim([0 700])
xlabel("DOP concentration (\muM)")
ylabel("Observations")
set(findobj(gcf,'type','axes'),'FontName','Arial','FontSize',16,'FontWeight','Bold', 'LineWidth', 2);

% make Figure 4b
% plot histogram of method used to measure DOP concentration
method = categorical(data.method)
summary(method)
method = categorical(method,...
    {'UV oxidation' 'Wet oxidation ' 'ash/hydrolysis'},'Ordinal',true);
xh = histogram(method)
set(findobj(gcf,'type','axes'),'FontName','Arial','FontSize',16,'FontWeight','Bold', 'LineWidth', 2);
ylabel("Observations")
ylim([0 1800])


%% make Figure 6
% figure a
% plot histogram of month collected for samples
dataS = data(data.LATITUDE<0,:)
monthS = categorical(dataS.month)
monthS = categorical(monthS,...
    {'1' '2 ' '3','4','5','6','7','8','9','10','11','12','nd'},'Ordinal',true);


hold on
month = categorical(data.month)
month = categorical(month,...
    {'1','2 ','3','4','5','6','7','8','9','10','11','12','nd'},'Ordinal',true);
histogram(month)
ylabel('Observations')
xlabel('Month') 
histogram(monthS)
legend('Northern hemisphere','Southern hemsiphere','location','northwest')
set(findobj(gcf,'type','axes'),'FontName','Arial','FontSize',16,'FontWeight','Bold', 'LineWidth', 2);
box on

% figure 6b
% plot histogram of year
year = categorical(data.year)
summary(year)
yearseries = string([1990:2021 ])
year = categorical(year,yearseries,'Ordinal',true);
histogram(year)
set(findobj(gcf,'type','axes'),'FontName','Arial','FontSize',16,'FontWeight','Bold', 'LineWidth', 2);
ylabel('Observations')
xlabel('Year')
ylim([0 900])


% figure 6c
% plot histogram of ocean basins
region = categorical(data.region)
summary(region)
region = categorical(region,...
    {'North Atlantic' 'South Atlantic ' 'North Pacific' 'South Pacific' 'Indian Ocean' 'Southern Ocean'},'Ordinal',true);
histogram(region)
set(findobj(gcf,'type','axes'),'FontName','Arial','FontSize',16,'FontWeight','Bold', 'LineWidth', 2);
ylabel('Observations')

% figure 6d
% plot histogram of latitude
histogram(data.LATITUDE)
set(findobj(gcf,'type','axes'),'FontName','Arial','FontSize',16,'FontWeight','Bold', 'LineWidth', 2);
ylabel('Observations')
xlabel('Latitude')
ylim([0 900])


% figure 6e
% plot histogram of longitude
histogram(data.LONGITUDE)
set(findobj(gcf,'type','axes'),'FontName','Arial','FontSize',16,'FontWeight','Bold', 'LineWidth', 2);
ylabel('Observations')
xlabel('Longtitude')
ylim([0 900])

% figure 6f
% plot histogram of depth
histogram(data.depth,[0 250 500 2000 6001])
xticks([0 500 2000 6000])
xlabel('Depth (m)')
ylabel('Observations')
set(findobj(gcf,'type','axes'),'FontName','Arial','FontSize',16,'FontWeight','Bold', 'LineWidth', 2);


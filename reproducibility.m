
% read TDP reproducibity data
data = readtable("TDPreproducibility.csv");


TDP_L = data(data.TDP_avg<=2,:);
TDP_H = data(data.TDP_avg>2,:);


%% make figure 3a
% type 2 linear fit
[c,bintr,bintjm,p] = gmregress(TDP_L.TDP, TDP_L.TDP_rerun)
b = c(1)
m = c(2)

x = [0:0.1:2.5];

hold on

plot(TDP_L.TDP, TDP_L.TDP_rerun,'ko','MarkerFaceColor','k','MarkerSize',8)

hline = plot(x,m*x+b,'-k','LineWidth',2);
set(hline,'color','k','Linewidth',2);

legend(hline,'best fit line, y = 1.06x-0.004\newlineR^{2} = 0.97,p<0.001,n = 36)','location','northwest','FontSize',20);
legend boxoff
xlabel('[TDP] from first analysis (然)')
ylabel('[TDP] after five months (然)')
ylim([0,2.5])
xlim([0,2.5])
set(findobj(gcf,'type','axes'),'FontName','Arial','FontSize',18,'FontWeight','Bold', 'LineWidth', 2);
box on
grid off


%% make figure 3b
[c,bintr,bintjm,p] = gmregress(TDP_H.TDP, TDP_H.TDP_rerun)
b = c(1)
m = c(2)

x = [1.5:0.1:3.5];

hold on

plot(TDP_H.TDP, TDP_H.TDP_rerun,'ko','MarkerFaceColor','k','MarkerSize',8)

hline = plot(x,m*x+b,'-k','LineWidth',2);
set(hline,'color','k','Linewidth',2);

legend(hline,'best fit line, y = 0.86x+0.34\newlineR^{2} = 0.84,p<0.001,n = 13)','location','northwest','FontSize',20);
legend boxoff
xlabel('[TDP] from first analysis (然)')
ylabel('[TDP] after five months (然)')
ylim([1.5,3.5])
xlim([1.5,3.5])
set(findobj(gcf,'type','axes'),'FontName','Arial','FontSize',18,'FontWeight','Bold', 'LineWidth', 2);
box on
grid off





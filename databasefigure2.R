
library(tidyverse)

# red DOv2021 dataset
data <- read.csv('dopv2021.csv')

data <- filter(data,data$DOP_flag==2);

data$region <- factor(data$region,levels = c("North Atlantic","South Atlantic","Indian Ocean","Southern Ocean","North Pacific","South Pacific"))

# plot Figure 2a
ggplot(data)+
  geom_point(aes(x=DOP, y=depth,color=region,shape = method))+
  ylab('Depth (m)')+
  xlab('DOP (µM)')+
  ylim(0,6001)+
  xlim(0, 0.8)+
  scale_y_reverse()+
  scale_x_continuous(position = 'top')+
  theme(text = element_text(size=30))+
  scale_color_brewer(palette = "Paired")+
  theme_few()

# plot figure 2b
ggplot(filter(data,depth<=500))+
  geom_point(aes(x=DOP, y=depth,color=region,shape = method))+
  ylab('Depth (m)')+
  xlab('DOP (µM)')+
  ylim(0,500)+
  xlim(0, 0.8)+
  scale_y_reverse()+
  scale_x_continuous(position = 'top')+
  theme(text = element_text(size=30))+
  scale_color_brewer(palette = "Paired")+
  theme_few()

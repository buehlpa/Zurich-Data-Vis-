# Libraries
library(ggplot2)
library(dplyr)
library(hrbrthemes)
library(viridis)
library(lubridate)


load("Rdata/data_aggregate.rda")




unemplot=ggplot(data_agg,aes(x=year, y=unemploymentratio,group=district))+
  geom_line(aes(color=district),size=1.8)+
  scale_color_viridis_d()+                  #use the viridis theme could be any discrete
  scale_x_date(date_breaks = "years" , date_labels = "20%y")+
  scale_y_continuous( limits=c(0,4))+
  theme(axis.text.x=element_text(angle=60, hjust=1))+
  theme(panel.grid.minor = element_blank(),
        panel.background = element_blank(),
        panel.grid.major =element_line(colour = "lightgrey"),
        plot.background = ggplot2::element_blank(), 
        legend.background = ggplot2::element_blank(),
        legend.key = element_rect(colour = NA, fill = NA)
  )

ggsave(file="plots/GGplot_unemploy_linechart.svg", plot=unemplot)



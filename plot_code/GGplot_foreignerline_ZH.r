# Libraries
library(ggplot2)
library(dplyr)

 #loading data
load("Rdata/data_aggregate.rda")


#filter 
aranged=data_agg_full %>% filter(district=="Zürich")%>%
  select(year,foreignerratio)

#remove Na could as be done with na.omit()
aranged=aranged[-c(1:16),]


#Foreignerrate plot
foreignplot=ggplot(aranged)+
  geom_line(aes(x=year, y=foreignerratio),color="darkorange",size=1.3)+#geomline plot

  labs(x = NULL, y = NULL, title = "Foreignerratio district Zuerich in %")+
  
  theme(
        
        panel.grid.minor = element_blank(),                   #background theme
        panel.background = element_blank(),
        panel.grid.major =element_line(colour = "lightgrey"),
        plot.background = ggplot2::element_blank(),
        
        aspect.ratio=1/3,                                    #Aspect ratio of the plot
        
        axis.text.y=element_text( size=13),                 
        axis.text.x=element_text(size=13,angle=60, hjust=1) # Style of the axis labeling
         
  )


#save the plot

ggsave(file="plots/GGplot_foreignerline_ZH.svg", plot=foreignplot)
